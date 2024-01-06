## CITEseqLN-Tcells

This repository contains data and executable scripts to reproduce the figures and analysis presented in the paper:

**Multimodal and spatially resolved profiling identifies distinct patterns of T-cell infiltration in nodal B-cell lymphoma entities**  

*by Tobias Roider\*, Marc A. Baertsch\*, Donnacha Fitzgerald, Harald Voehringer, Berit J. Brinkmann, Felix Czernilofsky, Mareike Knoll, Laura Llaó-Cid, Anna Mathioudaki, Bianca Faßbender, Maxime Herbon, Tobias Lautwein, Peter-Martin Bruch, Nora Liebers, Christian M. Schürch, Verena Passerini, Marc Seifert, Alexander Brobeil, Carsten Müller-Tidow, Oliver Weigert, Martina Seiffert, Garry P. Nolan, Wolfgang Huber#, Sascha Dietrich#*

\* These first authors contributed equally.  
\# These senior authors contributed equally.

available at bioRxiv 2022.11.04.514366; doi: https://doi.org/10.1101/2022.11.04.514366

RNA–seq, epitope and TCR data that support the findings of this study have been deposited in the Gene Expression Omnibus (GEO) under accession codes GSE252608 and GSE252455.  Highly multiplexed immunofluorescence images will be available in the BioStudies database (https://www.ebi.ac.uk/biostudies/) under accession number S-BIAD565 upon final publication. 
Additional data are provided in `data` as .csv, .rds or .RData files. 
Among the Rmarkdown files contained in `analysis/`, only `MapTcells_5scRNA.Rmd` and `NeighborhoodAnalysis.Rmd` is absolutely necessary to run. All other Rmarkdown documents contained in `analysis/` allow to reproduce files contained in `output/`. The object `Tcells_Integrated.rds` can either be downloaded from HeiData database (see above) or reproduced using `IntegrateTcells.Rmd`. Additional instructions can be found in `R/ReadData.R`

If you use this analysis in published research, please cite the manuscript above. Please refer to the manuscript for more details on experimental methods and analysis. The presented analysis was performed by Tobias Roider, Marc A. Bärtsch, Donnacha Fitzgerald, Harald Vöhringer, Felix Czernilofsky, Verena Passerini, and Wolfgang Huber. This repository is maintained by Tobias Roider. If you have questions, email me at tobias.roider@embl.de.
