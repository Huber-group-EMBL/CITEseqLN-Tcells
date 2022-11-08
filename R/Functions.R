# glmnet function part a
cv.glmnet.balanced = function(x, y, nfolds = 10, ...) {
  
  foldid = rep(NA_integer_, length(y))
  sink("/dev/null")
  ll = pamr:::balanced.folds(y, nfolds) 
  sink()
  for (i in seq_along(ll)) { foldid[ ll[[i]] ] = i }
  stopifnot(!any(is.na(foldid)), nrow(x) == length(y))
  
  weights = rep(NA_real_, length(y))
  tab = table(y)
  stopifnot(setequal(names(tab), levels(y)))
  for (nm in names(tab)) weights[ y == nm ] = 1/tab[nm]

  cv.glmnet(x = x, y = y, foldid = foldid, weights = weights, ...) 
}

entities = c("rLN", "MZL", "FL", "MCL", "DLBCL") 

# glmnet function part b
my_glmnet = function(df) {
  require("glmnet")
  require("pamr")
  x = dplyr::select(df, all_of(cell_types)) |> as.matrix()
  y = factor(df$Entity, levels = entities)
  
  ## estimate prediction performance by LOO CV
  confusion_table = lapply(seq_along(y), function(i) {
    pr = cv.glmnet.balanced(x[-i, ], y[-i], family = "multinomial") |>
      predict(newx = x[i,, drop = FALSE], type = "response")
    tibble(truth   = y[i],
           predicted = factor(names(which.max(pr[1,,1])), levels = entities))
  }) |> bind_rows() |> table()
  
  ## final fit
  fit  = cv.glmnet.balanced(x, y, family = "multinomial")
  cfit = coef(fit)
  coefs = lapply(names(cfit), function(ent) { 
    m = cfit[[ent]]
    tibble(Entity    = ent,
           cell_type = rownames(m), 
           beta      =  m[, 1]) 
  }) |> bind_rows() |> mutate(Entity = factor(Entity, levels = entities))
  
  list(fit = fit, 
       confusion_table = confusion_table,
       coefs = coefs)
}

# This function reads and handles TCR data
readTCR <- function(files=NULL){
  
  lapply(files, data.table::fread) %>% 
    bind_rows() %>% 
    as_tibble() %>% 
    mutate(PatientID=strsplit(barcode, split = "_") %>% sapply("[[", 2)) %>% 
    select(PatientID, 1:(ncol(.)-1)) %>% 
    rename(Barcode_full=barcode)

} 

# This function adds entity to df
add_entity <- 
  function(data){
      data %>% 
        left_join(., df_meta %>% select(PatientID, Entity) %>% distinct, by="PatientID") %>% 
        dplyr::mutate(Entity=gsub(Entity, pattern = ", GCB|, non-GCB", replacement = ""))
  }


# This function calculates the proportion of variables
add_prop <- 
  function(data=NULL, vars=NULL, group.vars=NULL, ungroup=TRUE, keep.n=FALSE, prop.name=NULL) {
    
    group.vars <-  vars[group.vars]
    
    dftmp <- 
      data %>% 
        dplyr::count(!!!syms(unique(c(vars, group.vars)))) %>% 
        group_by(!!!syms(c(group.vars))) %>% 
        dplyr::mutate(Prop=n/sum(n))
    
    if(keep.n==FALSE){
      dftmp <- dftmp %>% select(-n)
    }
    
    if(ungroup==TRUE){
      dftmp <- dftmp %>% ungroup()
    }
    
    if(!is.null(prop.name)){
      colnames(dftmp)[which(colnames(dftmp)=="Prop")] <- prop.name
      
    }
    
    return(dftmp)
  }

# This functions expands data frames and fills missing values with 0
fill_zeros <- 
  function(data=NULL ,names_from=NULL, values_from=NULL) {
    data %>% 
      pivot_wider(names_from = all_of(names_from), values_from = all_of(values_from), values_fill = 0) %>% 
      pivot_longer(cols = (ncol(data)-1):ncol(.), names_to = names_from, values_to = values_from)
  }
  
# Run standard Seurat processing pipeline
SeuratProc_T <- 
  function(sobj, verbose=FALSE, dims.clustering=NULL, resolution.clustering=NULL, dims.umap=NULL) {
    
    # Remove 
    sobj <- DietSeurat(sobj)
    DefaultAssay(sobj) <- "RNA"
    
    # Filter data set based on RNA
    sobj <- FindVariableFeatures(sobj, selection.method = "vst", nfeatures = 2000, verbose=verbose)
    
    # Scale data (RNA and ADT)
    sobj <- ScaleData(sobj, features = rownames(sobj), verbose=verbose)
    
    # Assess cell cycle
    sobj <- CellCycleScoring(sobj, s.features = cc.genes$s.genes, g2m.features = cc.genes$g2m.genes, set.ident = TRUE)
    sobj <- ScaleData(sobj, vars.to.regress = c("S.Score", "G2M.Score", "percent.mt"), verbose=verbose)
    
    # Run PCA
    sobj <- RunPCA(sobj, features = VariableFeatures(sobj), nfeatures.print=5, ndims.print=1:2,
                   reduction.name = "pcaRNA", reduction.key = "pcaRNA_")
    
    # Run clustering based on transcriptome
    sobj <- FindNeighbors(sobj, dims = dims.clustering, verbose=verbose, reduction = "pcaRNA")
    sobj <- FindClusters(sobj, resolution = resolution.clustering, verbose=verbose)
    
    # Run UMAP based on transcriptome
    sobj <- RunUMAP(sobj, dims = dims.umap, verbose=verbose, reduction.key = "umapRNA_",
                    reduction.name = "umapRNA", reduction = "pcaRNA")
    
    return(sobj)
    
  }

SeuratProcADT_T <- 
  function(sobj, verbose=FALSE, dims.clustering=NULL, resolution.clustering=NULL, dims.umap=NULL) {
    
    DefaultAssay(sobj) <- "ADT"
    VariableFeatures(sobj, assay="ADT") <- rownames(sobj@assays$ADT)
    
    sobj <- ScaleData(sobj, assay = "ADT", verbose=verbose)
    
    #### Run PCA and print ElbowPlot
    sobj <- RunPCA(sobj, features = rownames(sobj@assays$ADT), nfeatures.print=5, ndims.print=1:2, 
                   reduction.name = "pcaADT", reduction.key = "pcaADT_")
    
    #### Run clustering based on ADT
    sobj <- FindNeighbors(sobj, dims = dims.clustering, verbose=verbose,  reduction = "pcaADT")
    sobj <- FindClusters(sobj, resolution = resolution.clustering, verbose=verbose)
    
    #### Run UMAP based on ADT
    sobj <- RunUMAP(sobj, dims = dims.umap, verbose=verbose, reduction = "pcaADT",
                    reduction.name = "umapADT", reduction.key = "umapADT_")
    
    DefaultAssay(sobj) <- "RNA"
    
    return(sobj)
    
  }
