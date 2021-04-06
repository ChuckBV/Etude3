#===========================================================================#
# fames-script3_lda_vs_pca_now_fames.R
#
# Use Martins code with NOW Fames dataset
#
# 1. Perform and annotate PCA
# 2. Perform and annotate LDA
# 3. Graphical comparisons of PCA and LDA
#
#===========================================================================#

require(MASS)
require(ggplot2)
require(scales)
require(gridExtra)

#-- 1. Perform and annotate PCA ---------------------------------------------

pca <- prcomp(iris[,-5], # drops Species, all numeric data frame
              center = TRUE,
              scale. = TRUE) 
## prcomp is base R. pca is a list with 5 objects

pca$sdev # num [1:4]
# [1] 1.7083611 0.9560494 0.3830886 0.1439265

pca$rotation #num, 1:4, 1:4]
#                     PC1         PC2        PC3        PC4
# Sepal.Length  0.5210659 -0.37741762  0.7195664  0.2612863
# Sepal.Width  -0.2693474 -0.92329566 -0.2443818 -0.1235096
# Petal.Length  0.5804131 -0.02449161 -0.1421264 -0.8014492
# Petal.Width   0.5648565 -0.06694199 -0.6342727  0.5235971

pca$center # Named num [1:4]
# Sepal.Length  Sepal.Width Petal.Length  Petal.Width 
#     5.843333     3.057333     3.758000     1.199333

pca$scale #  Named num [1:4]
# Sepal.Length  Sepal.Width Petal.Length  Petal.Width 
#    0.8280661    0.4358663    1.7652982    0.7622377 

head(pca$x,3) # num [1:150]
#            PC1        PC2         PC3          PC4
# [1,] -2.257141 -0.4784238  0.12727962  0.024087508
# [2,] -2.074013  0.6718827  0.23382552  0.102662845
# [3,] -2.356335  0.3407664 -0.04405390  0.028282305
# [4,] -2.291707  0.5953999 -0.09098530 -0.065735340
# [5,] -2.381863 -0.6446757 -0.01568565 -0.035802870
# [6,] -2.068701 -1.4842053 -0.02687825  0.006586116

## Proportion of between-class variance by components
prop.pca = pca$sdev^2/sum(pca$sdev^2)
prop.pca
# [1] 0.729624454 0.228507618 0.036689219 0.005178709

#-- 2. Perform and annotate LDA ---------------------------------------------

lda <- MASS::lda(Species ~ ., 
                 iris, 
                 prior = c(1,1,1)/3)
# lda is a list of 10 objects

prop.lda = lda$svd^2/sum(lda$svd^2)
prop.lda
# [1] 0.991212605 0.008787395

plda <- predict(object = lda,
                newdata = iris) # plda is a list of three objects

plda$class # factor w 3 levels, 150 obs

head(plda$posterior,2) # posterior prob. by classification
#   setosa   versicolor    virginica
# 1      1 3.896358e-22 2.611168e-42
# 2      1 7.217970e-18 5.042143e-37

head(plda$x) # score on two axes
#        LD1        LD2
# 1 8.061800  0.3004206
# 2 7.128688 -0.7866604

#-- 3. Graphical comparisons of PCA and LDA -----------------------------------

dataset = data.frame(species = iris[,"Species"], # take single col frm src dat
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