# Reference CITE-seq data
# RNA–seq, epitope and TCR raw and processed data have been deposited in the Gene Expression Omnibus (GEO) under accession codes GSE252608 and GSE252455.
# Or reproduced by IntegrateTcells.Rmd
Combined_T <- readRDS("output/Tcells_Integrated.rds") 

# List of objects containing 5' scRNA data mapped to CITE-seq reference
# Please create with MapTcells_5scRNA.Rmd
sobjs_T_5prime <- readRDS("output/SeuratObjects_T_5'scRNA.rds")

# Read pseudotime from trajectory analysis
load("output/ttox_pseudotime.RData")

# Gradient boosting results
# Available in data folder
# Reproducible by GB_surface.Rmd and GB_surfaceplus.Rmd
GBresults_surfaceplus <- readRDS("output/GBresults_Combined_T_surfaceplus.rds")
GBclasses_surfaceplus <- readRDS("output/GBclasses_Combined_T_surfaceplus.rds")
GBresults_surface <- readRDS("output/GBresults_Combined_T_surface.rds")
GBclasses_surface <- readRDS("output/GBclasses_Combined_T_surface.rds")

# ADT thresholds based on denoised protein expression (TotalVI)
# Reproducible by thresholds_denoised.Rmd
thresh <- read.csv("output/threshholds_denProtein.csv")

# Sample list
df_meta <- read.csv("data/metaData.csv")

# Flow cytometry data
df_facs <- read.csv("data/FlowCytometryData.csv") %>% 
  `colnames<-`(gsub(colnames(.), pattern = ".", replacement = "/", fixed = T)) %>% 
  pivot_longer(cols = 3:ncol(.), names_to = "Population", values_to = "FACS")
df_ikzf3 <- read_delim("data/IKZF3_add.csv", show_col_types = F, progress = F)

# Subset to TTOX and add pseudotime
Idents(Combined_T) <- "IdentI"
ttox <- subset(Combined_T, idents=c(3,5,12,16))
ttox <- AddMetaData(ttox, metadata=ttox_pseudotime, col.name = "Pseudotime")

# Read CIBERSORTx output (https://cibersortx.stanford.edu/)
df_ttoxcompl_schmitz <- read.csv("data/Cibersortx_Schmitz_FreqTTOX.csv")
df_tfhtreg_schmitz <- read.csv("data/Cibersortx_Schmitz_FreqTFH+TREG.csv")
df_ttoxcompl_chapuy <- read.csv("data/Cibersortx_Chapuy_FreqTTOX.csv")
df_tfhtreg_chapuy <- read.csv("data/Cibersortx_Chapuy_FreqTFH+TREG.csv")

# External survival data (Schmitz et al. 2018, Chapuy et al. 2018)
# Available at https://www.nejm.org/doi/10.1056/NEJMoa1801445
# Available at https://www.nature.com/articles/s41591-018-0016-8
df_surv_schmitz <- read.delim("data/MetaData_Schmitz_2018.txt", na.strings = "")
df_surv_chapuy <- read.delim("data/MetaData_Chapuy_2018.txt", na.strings = "") %>% 
  filter(!is.na(time_pfs) & !is.na(time_os))

# External snv data (Chapuy et al. 2018)
# Available at https://www.nature.com/articles/s41591-018-0016-8
df_snvs_chapuy <- read.delim("data/SomaticVariants_Chapuy2018.txt", na.strings = "")  %>% 
  pivot_longer(cols = 3:ncol(.), names_to = "PatientID") %>% 
  left_join(., df_ttoxcompl_chapuy, by="PatientID") %>% 
  drop_na()

# Single cell T-cell receptor data
# RNA–seq, epitope and TCR raw and processed data have been deposited in the Gene Expression Omnibus (GEO) under accession codes GSE252608 and GSE252455.
DF_TCRrep <- readTCR(list.files(path = "countMatrices", pattern = "TCRrep", full.names = T))

# Read CODEX data (only meta data) 
# Available at BioStudies database (https://www.ebi.ac.uk/biostudies/) under accession number S-BIAD565
codex_annotation <- data.table::fread("data/cells_annotation.csv") %>% tibble() %>% 
  filter(Merged_final!="na") %>% 
  add_entity()
