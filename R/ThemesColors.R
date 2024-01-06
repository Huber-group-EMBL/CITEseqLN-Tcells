# Set themes
mytheme_1 <- theme_bw()+
  theme(axis.title = element_text(size=7, color="black"),
        axis.text = element_text(size=7, color="black"),
        legend.position = "none",
        legend.text = element_text(size = 6.5, color="black"),
        legend.title = element_text(size = 7, color="black"),
        legend.key.width = unit(0.5, "cm"),
        plot.title = element_text(hjust = 0.5, size = 7, color="black", face = "bold"),
        panel.border = element_rect(size=0.25),
        strip.background = element_rect(fill="white", size=0.5),
        strip.text = element_text(size=6.5, color="black"),
        panel.grid = element_blank()
        )

theme_characteristics <- theme(plot.tag = element_text(vjust = -1),
                               axis.title.x = element_blank(),
                               panel.border = element_rect(size=0.5))

mytheme_codex <- theme_void()+
  theme(legend.position = "none",
        plot.title = element_text(color="white", hjust=0.1, size=10, 
                                  margin = unit(units = "cm", c(0,0,-0.6,0)), face = "bold"),
        panel.background = element_rect(fill = "white", color=NA),
        plot.background = element_rect(fill = "white", color=NA))

theme_axis_sub <- theme(
  plot.margin = unit(c(0,0.25,0.18,0), units = "cm"),
  plot.title = element_text(vjust = -1),
  axis.title.x = element_textbox_simple(size = 7,
    width = NULL,
    padding = margin(1.25, 0, 2.25, 0),
    lineheight = 1.25,
    halign=0.5),
  axis.title.y = element_textbox_simple(size = 7,
    width = NULL,
    orientation = "left-rotated",
    padding = margin(0, 0, 1.25, 0)),
  axis.text = element_text(size=7, color="black")
)

theme_axis_sub3 <- theme(
  plot.margin = unit(c(0,0.25,0.1,0), units = "cm"),
  plot.title = element_text(vjust = -1),
  axis.title.x = element_textbox_simple(size = 7,
                                        width = NULL,
                                        margin = unit(units = "cm", c(0.05,0,0,0)),
                                        padding = margin(1.25, 0, 1, 0),
                                        lineheight = 1.25,
                                        halign=0.5),
  axis.title.y = element_blank(),
  axis.text = element_text(size=7, color="black")
)

# Set colors
colors_characteristics <- c(
  "DLBCL"=brewer.pal(5, "Paired")[1],
  "FL"=brewer.pal(5, "Paired")[3],
  "MCL"=brewer.pal(5, "Paired")[2],
  "MZL"=brewer.pal(5, "Paired")[4],
  "rLN"=brewer.pal(5, "Paired")[5],
  "M"="#fdbb84",
  "F"="#e34a33",
  "Initial diagnosis"="#9ebcda",
  "Relapse"="purple", 
  "NA"="grey85")

colors_umap_cl <- 
  c("1"=brewer.pal(9, "Purples")[4],
    "2"=brewer.pal(9, "Purples")[6],
    "3"=brewer.pal(9, "YlOrRd")[4],
    #"4"=brewer.pal(9, "YlOrRd")[8],
    "5"=brewer.pal(9, "YlOrRd")[7],
    "6"=brewer.pal(9, "Greens")[6],
    "8"=brewer.pal(9, "Blues")[3],
    "9"=brewer.pal(9, "Purples")[8],
    #"10"=brewer.pal(9, "YlOrRd")[5],
    "11"=brewer.pal(9, "Blues")[9],
    "12"=brewer.pal(9, "YlOrRd")[3],
    "13"=brewer.pal(9, "Blues")[5],
    "14"=brewer.pal(9, "RdPu")[7],
    "15"=brewer.pal(9, "Blues")[7],
    "16"=brewer.pal(9, "YlOrRd")[6],
    "18"=brewer.pal(9, "YlOrRd")[9],
    "19"=brewer.pal(9, "Greys")[4]
  )

colors_celltype <- 
  c("T[Pr]"=brewer.pal(9, "RdPu")[8],
    "T[FH]"=brewer.pal(9, "Greens")[5],
    "T[H]"=brewer.pal(9, "Purples")[5],
    "T[REG]"=brewer.pal(9, "Blues")[5],
    "T[TOX]"=brewer.pal(9, "YlOrRd")[7],
    "T[DN]"=brewer.pal(9, "Greys")[6]
  )

colors_codex <- list(
  "B"="#01178B",
  "CD4T"=colors_umap_cl[["9"]],
  "TFH"="#22d22f",
  "TTOX"=brewer.pal(9, "YlOrRd")[5],
  "TTOXNaive"=colors_umap_cl[["12"]],
  "TTOX_exh"=colors_umap_cl[["5"]],
  "Treg"="#FFF201",
  "CD4TNaive"=colors_umap_cl[["2"]],
  "TPR"=colors_umap_cl[["14"]],
  "FDC"="white",
  "Myeloid"="brown",
  "Stromal cells"="pink",
  "Other"="grey50"
)

colors_codex_exp <- list(
  "B"="#01178B",
  "CD4T"=colors_umap_cl[["9"]],
  "TFH"="#22d22f",
  "TTOX"=brewer.pal(9, "YlOrRd")[5],
  "TTOXNaive"=colors_umap_cl[["12"]],
  "TTOX_exh"=colors_umap_cl[["5"]],
  "Treg"="#FFF201",
  "CD4TNaive"=colors_umap_cl[["2"]],
  "TPR"=colors_umap_cl[["14"]],
  "FDC"="white",
  "Macro"="brown",
  "Granulo"="brown",
  "DC"="brown",
  "Stromal cells"="pink",
  "PC"="grey50",
  "MC"="grey50",
  "NK"="grey50",
  "NKT"="grey50"
)

colors_dendrogramm_codex <- 
  c("1"=colors_umap_cl[["2"]],
    "2"=colors_umap_cl[["9"]],
    "3"=colors_umap_cl[["3"]],
    "5"=colors_umap_cl[["5"]],
    "6"="#22d22f",
    "12"=brewer.pal(9, "YlOrRd")[3],
    "14"=colors_umap_cl[["14"]],
    "19"=colors_umap_cl[["19"]],
    "TREG"="#FFF201",
    "TH"=brewer.pal(9, "Purples")[7],
    "TTOX"=brewer.pal(9, "YlOrRd")[5]
  )


# Set labels
labels_codex <- list(
  "B"=expression("B cells"),
  "CD4T"=expression('Memory T'[H]~''),
  "TFH"=expression('T'[FH]~''),
  "TTOX"=expression('Memory T'[TOX]~''),
  "TTOXNaive"=expression('CD8'^'+'~'Naive'),
  "TTOX_exh"=expression('Exhausted T'[TOX]~''),
  "Treg"=expression('T'[REG]~''),
  "CD4TNaive"=expression('CD4'^'+'~'Naive'),
  "TPR"=expression('T'[Pr]~''),
  "Myeloid"=expression("Myeloid cells"),
  "FDC"=expression("FDC"),
  "Stroma"=expression("Stromal cells"),
  "Other"=expression("Other")
)

labels_codex_exp <- list(
  "B"=expression("B cells"),
  "CD4T"=expression('Memory T'[H]),
  "TFH"=expression('T'[FH]),
  "TTOX"=expression('Memory T'[TOX]),
  "TTOXNaive"=expression('CD8'^'+'~'Naive'),
  "TTOX_exh"=expression('Exhausted T'[TOX]),
  "Treg"=expression('T'[REG]),
  "CD4TNaive"=expression('CD4'^'+'~'Naive'),
  "TPR"=expression('T'[Pr]),
  "Myeloid"=expression("Myeloid cells"),
  "FDC"=expression("FDC"),
  "Stroma"=expression("Stromal cells"),
  "Other"=expression("Other"),
  "FDC"=expression("FDC"),
  "Macro"=expression("Macrophages"),
  "Granulo"=expression("Granulocytes"),
  "DC"=expression("DC"),
  "Stromal cells"=expression("Stromal cells"),
  "PC"=expression("Plasma cells"),
  "MC"=expression("Mast cells"),
  "NK"=expression("NK cells"),
  "NKT"=expression("NKT cells")
)


labels_codex_parsed <- list(
  "B"="B cells",
  "CD4T"=expression('T'[H]~'  '),
  "TFH"=expression('T'[FH]~'  '),
  "TTOX"=expression('T'[TOX]~'  '),
  "TTOXNaive"=expression('CD8'^'+'~'Naive  '),
  "TTOX_exh"=expression('T'[TOX]~'Exhausted'),
  "Treg"=expression('T'[REG]~'  '),
  "CD4TNaive"=expression('CD4'^'+'~'Naive  '),
  "TPR"=expression('T'[Pr]~'  ')#,
  #"nonBT"=expression("Other  ")
)


labels_cl <- list(
  "14"=expression('T'[Pr]), 
  "1"=expression('T'[H]~'Naive'),
  "2"=expression('T'[H]~'CM'[1]),
  "9"=expression('T'[H]~'CM'[2]),
  "6"=expression('T'[FH]),
  "8"=expression('T'[REG]~'CM'[1]), 
  "13"=expression('T'[REG]~'CM'[2]), 
  "15"=expression('T'[REG]~'EM'[1]), 
  "11"=expression('T'[REG]~'EM'[2]), 
  "12"=expression('T'[TOX]~'Naive'), 
  "3"=expression('T'[TOX]~'EM'[1]), 
  "16"=expression('T'[TOX]~'EM'[2]), 
  "5"=expression('T'[TOX]~'EM'[3]), 
  "19"=expression('T'[DN])
)

labels_cl_parsed <- list(
  "14"='T'[Pr]~'', 
  "1"='T'[H]~'Naive',
  "2"='T'[H]~'CM'[1]~'',
  "9"='T'[H]~'CM'[2]~'',
  "6"='T'[FH]~'',
  "8"='T'[REG]~'CM'[1]~'',
  "13"='T'[REG]~'CM'[2]~'',
  "15"='T'[REG]~'EM'[1]~'',
  "11"='T'[REG]~'EM'[2]~'',
  "12"='T'[TOX]~'Naive',
  "3"='T'[TOX]~'EM'[1]~'',
  "16"='T'[TOX]~'EM'[2]~'',
  "5"='T'[TOX]~'EM'[3]~'',
  "19"='T'[DN]~''
)

labels_cl <- list(
  "14"=expression('T'[Pr]), 
  "1"=expression('T'[H]~'Naive'),
  "2"=expression('T'[H]~'CM'[1]),
  "9"=expression('T'[H]~'CM'[2]),
  "6"=expression('T'[FH]),
  "8"=expression('T'[REG]~'CM'[1]), 
  "13"=expression('T'[REG]~'CM'[2]), 
  "15"=expression('T'[REG]~'EM'[1]), 
  "11"=expression('T'[REG]~'EM'[2]), 
  "12"=expression('T'[TOX]~'Naive'), 
  "3"=expression('T'[TOX]~'EM'[1]), 
  "16"=expression('T'[TOX]~'EM'[2]), 
  "5"=expression('T'[TOX]~'EM'[3]), 
  "19"=expression('T'[DN])
)


# Set other
limits_codex <- c("B", "TPR", "CD4TNaive", "CD4T", "TFH", "Treg", "TTOXNaive", "TTOX_exh", "TTOX", "Stromal cells", "Myeloid", "FDC", "Other")
order_nn <- c( "B", "FDC", "TFH", "CD4T", "Treg", "CD4TNaive", "TTOXNaive", "TPR", "TTOX", "TTOX_exh",  "Myeloid", "Stroma")
cluster_order <- c(14, 1, 2, 9, 6, 8, 13, 15, 11, 12, 3, 16, 5, 19)

colors_nn <- c(        "#80B1D3", "#D9D9D9", "#BEBADA", "#FFFFB3", "#8DD3C7", "#BC80BD", "#B3DE69", "#FDB462", "#FCCDE5", "#FB8072")
names(colors_nn) <- c( "1"      ,  "9"     ,  "8"     , "3"      ,  "7"     , "5"      , "10"     , "6"      , "4"      , "2"      )

celltypes <- c("Proliferating T-cells", "Conventional T-cells", "Follicular T helper cells",  "Regulatory T-cells", "Cytotoxic T-cells", "CD4-CD8- T-cells")
labels_celltypes_pars <- c("T[Pr]", "T[H]", "T[FH]", "T[REG]", "T[TOX]", "T[DN]")
labels_celltypes_expr <- list(expression('T'[Pr]), expression('T'[H]), expression('T'[FH]), expression('T'[REG]), expression('T'[TOX]), expression('T'[DN]))

df_celltypes <- data.frame(IdentI=c(cluster_order)) %>% 
  mutate(CellType=case_when(IdentI==19 ~ celltypes[6],
                            IdentI %in% c(3,5,12,16,18) ~ celltypes[5],
                            IdentI %in% c(1,2,9) ~ celltypes[2],
                            IdentI %in% c(6,17) ~ celltypes[3],
                            IdentI %in% c(8,11,13,15) ~ celltypes[4],
                            IdentI==14 ~ celltypes[1])) %>% 
  mutate(IdentI=as.factor(IdentI))

labels_celltypes_expr <- 
  list(expression('T'[Pr]),
       expression('T'[H]),
       expression('T'[FH]),
       expression('T'[REG]),
       expression('T'[TOX]),
       expression('T'[DN]))

df_pop <- data.frame(Population=c("TPR", "THNaive", "THCM1", "THCM2", "TFH", "TREGCM1", 
                                  "TREGCM2", "TREGEM1", "TREGEM2", "TTOXNaive",  
                                  "TTOXEM1", "TTOXEM2", "TTOXEM3", "TDN"),
                     IdentI=cluster_order)

