#===========================================================================#
# fames-script4_lda_vs_pca_now_figs.R
#
# Use Martins code with NOW Fames dataset. This time with NOW from lab
# tree nut sources, not from iris data set
#
# 1. Perform and annotate PCA
# 2. Perform and annotate LDA
# 3. Graphical comparisons of PCA and LDA
#
#===========================================================================#

require(MASS)
require(ggplot2)
require(scales) # Scales is installed when you install ggplot2 or the tidyverse
require(gridExtra) # for grid.arrange()

stds <- read.csv("Y21-04-06-lda-fames-rvw/stds_all_now.csv")
stds_fig <- stds[stds$Host != "Pistachio", ]

head(stds_fig,2)
#     Host    C1     C2    C3    C4     C5     C6    C7    C8 C9 C10
# 1 Almond 0.162 14.192 0.472 5.985 48.372 29.147 1.672 0.000  0   0
# 2 Almond 0.245 23.799 1.092 4.577 43.573 22.443 4.163 0.115  0   0

unique(stds_fig$Host)

#-- 1. Perform and annotate PCA ---------------------------------------------

pca <- prcomp(stds_fig[,-1], # drops Species, all numeric data frame
              center = TRUE,
              scale. = TRUE) 

## Proportion of between-class variance by components
prop.pca = pca$sdev^2/sum(pca$sdev^2)
prop.pca
# [1] 4.413335e-01 2.151833e-01 1.173387e-01 9.427267e-02 5.989982e-02 
# [6] 3.104827e-02 1.607752e-02 1.305772e-02 1.178040e-02 8.073571e-06

#-- 2. Perform and annotate LDA ---------------------------------------------

lda <- MASS::lda(Host ~ ., 
                 stds_fig)

prop.lda = lda$svd^2/sum(lda$svd^2)
prop.lda
# [1] 0.91130801 0.08869199

plda <- predict(object = lda,
                newdata = stds_fig) # plda is a list of three objects



#-- 3. Graphical comparisons of PCA and LDA -----------------------------------

dataset = data.frame(species = stds_fig[,"Host"], # take single col frm src dat
                     pca = pca$x, lda = plda$x)

p1 <- ggplot(dataset) + geom_point(aes(lda.LD1, lda.LD2, colour = species, shape = species), size = 2.5) + 
  labs(x = paste("LD1 (", percent(prop.lda[1]), ")", sep=""),
       y = paste("LD2 (", percent(prop.lda[2]), ")", sep=""))
p1

p2 <- ggplot(dataset) + geom_point(aes(pca.PC1, pca.PC2, colour = species, shape = species), size = 2.5) +
  labs(x = paste("PC1 (", percent(prop.pca[1]), ")", sep=""),
       y = paste("PC2 (", percent(prop.pca[2]), ")", sep=""))
p2

x <- grid.arrange(p1, p2)
ggsave("x.jpg", plot = x, device = "jpg", path = "C:/Users/Charles.Burks/Desktop/")
# from gridExtra. Not clear how to save this
# http://www.sthda.com/english/articles/24-ggpubr-publication-ready-plots/81-ggplot2-easy-way-to-mix-multiple-graphs-on-the-same-page/
# https://rpkgs.datanovia.com/ggpubr/reference/ggarrange.html