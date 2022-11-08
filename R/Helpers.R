# CITE-seq data
df_comb <- FetchData(Combined_T, vars = c("wnnUMAP_1", "wnnUMAP_2", colnames(Combined_T@meta.data))) %>%  
  mutate(IdentI=factor (IdentI, levels = cluster_order)) %>% 
  left_join(., df_celltypes, by = "IdentI") %>% 
  mutate(CellType=factor(CellType, levels=rev(celltypes), labels = rev(labels_celltypes_pars)))

# 5'scRNA and scTCR data
DFtotal_5prime <- 
  lapply(sobjs_T_5prime, function(x){
    FetchData(x, vars = c("PatientID", "umapRNA_1", "umapRNA_2", "refUMAP_1", "refUMAP_2",
                          "predicted.celltype", "predicted.celltype.score", "CD4", "CD8A")) 
  }) %>% 
  bind_rows() %>% 
  rownames_to_column("Barcode_full") %>% 
  add_entity() %>% 
  rename(IdentI=predicted.celltype) %>% 
  left_join(., DF_TCRrep, by=c("Barcode_full", "PatientID"))

# ADT data from CITE-seq data
df_ADT <- FetchData(Combined_T, slot = "scale.data", 
                    vars = c("Barcode_full", 
                             paste0("integratedadt_", rownames(Combined_T@assays$integratedADT)))) %>% 
  left_join(df_comb %>% select(IdentI, Barcode_full, Entity, PatientID), ., by = "Barcode_full") %>% 
  pivot_longer(cols = 6:ncol(.), names_to = "Epitope", values_to = "Expression") %>% 
  mutate(Epitope=gsub(Epitope, pattern = "integratedadt_.", replacement = "")) %>% 
  na.omit()

df_ADTdenoised <- FetchData(Combined_T, slot = "data", 
                            vars = c("Barcode_full", 
                                     paste0("denoisedprotein_", rownames(Combined_T@assays$denoisedProtein)))) %>% 
  left_join(df_comb %>% select(IdentI, Barcode_full, Entity, PatientID), .,  by = "Barcode_full") %>% 
  pivot_longer(cols = 6:ncol(.), names_to = "Epitope", values_to = "Expression") %>% 
  mutate(Epitope=gsub(Epitope, pattern = "denoisedprotein_", replacement = "")) %>% 
  left_join(., thresh, by="Epitope") %>%  
  na.omit()

percentageADT <- 
  df_ADTdenoised %>% 
  mutate(Pos=Expression>value) %>% 
  add_prop(vars = c("Pos", "Epitope", "IdentI", "PatientID"), group.vars = c(2:4)) %>% 
  filter(Pos==T) %>% 
  select(-Pos) %>% 
  group_by(Epitope, IdentI) %>% 
  summarise(Prop=mean(Prop), `.groups`="drop")

meanADT <- 
  df_ADT %>% group_by(IdentI, Epitope) %>% 
  summarise(Expression=mean(Expression), `.groups`="drop") %>% 
  group_by(Epitope) %>% 
  mutate(Expression=(Expression-min(Expression))/(max(Expression)-min(Expression)))

# Align FACS and CITE-seq data
df_freq <- 
  df_comb %>% 
  add_prop(vars = c("IdentI", "PatientID"), group.vars = 2) %>% 
  pivot_wider(names_from = "IdentI", values_from = "Prop", values_fill = 0) %>% 
  mutate(TREG= `8`+`11`+`13`+`15`,
         TFH=`6`,
         `TREGCM1`=`8`,
         `TREGCM2`=`13`,
         `TREGEM1`=`15`,
         `TREGEM2`=`11`,
         `TREG/CM1`=`8`/TREG,
         `TREG/CM2`=`13`/TREG,
         `TREG/EM1`=`15`/TREG,
         `TREG/EM2`=`11`/TREG,
         THNaive=`1`,
         TTOXNaive=`12`,
         TDN=`19`,
         TTOX=`5`+`3`+`16`,
         TPR=`14`,
         `TTOXEM1`=`3`,
         `TTOXEM2`=`16`,
         `TTOXEM3`=`5`,
         `TTOX/EM1`=(`3`)/TTOX,
         `TTOX/EM2`=(`16`)/TTOX,
         `TTOX/EM3`=(`5`)/TTOX,
         THCM1=`2`,
         THCM2=`9`
         ) %>% 
    pivot_longer(cols = 2:ncol(.), names_to = "Population", values_to = "RNA") %>% 
    mutate(RNA=100*RNA)
