library(tidyverse)
# GGally includes many pre-made graphs
library(GGally)
# Pheatmap for good-looking heatmaps
library(pheatmap)
# Viridis for nice color gradients
library(viridis)
#Ex 1
oil_measurements <- read_tsv("Class/data_for_pca/data_for_pca/oil_measurements.tab") %>% as.matrix
oil_groups <- read_tsv("Class/data_for_pca/data_for_pca/oil_groups.tab")
dim(oil_measurements)
dim(oil_groups)
head(oil_measurements)
summary(oil_measurements)
head(oil_groups)
#Ex 2
pca_oil <- prcomp(oil_measurements, scale. = TRUE)
pca_oil_annotated <- cbind(as_tibble(pca_oil$x), oil_groups)
head(pca_oil_annotated)
summary(pca_oil)

ggplot(pca_oil_annotated, aes(x=PC1, y=PC2, col=region, shape=macro.area)) + geom_point()
ggplot(pca_oil_annotated, aes(x=PC3, y=PC4, col=region, shape=macro.area)) + geom_point()

#Ex 3
wang_measurements <- read_tsv("Class/data_for_pca/data_for_pca/wang_measurements.tab") %>% as.matrix
wang_groups <- read_tsv("Class/data_for_pca/data_for_pca/wang_groups.tab")
dim(wang_measurements)
dim(wang_groups)
head(wang_groups)
pca_wang <- prcomp(wang_measurements, scale. = TRUE)
pca_wang_annotate <- cbind(pca_wang, wang_groups)
#ggplot(pca_oil_annotated, aes(x=PC1, y=PC2, col=region, shape=macro.area)) + geom_point()
cbind(pca_wang, t(wang_groups))
dim(t(wang_groups))
head(wang_measurements)

head(wang_measurements)
gene_rows <-t(cbind(t(wang_measurements), wang_groups))
head(gene_rows)


#Ex 5
crohns_measurements <- read_tsv("Class/data_for_pca/data_for_pca/crohns_measurements.tab") %>% as.matrix
crohns_groups <- read_tsv("Class/data_for_pca/data_for_pca/crohns_groups.tab")
dim(crohns_measurements)
dim(crohns_groups)
head(crohns_measurements)
head(crohns_groups)
crohns_measurements <- t(crohns_measurements)
pca_crohns <- prcomp(crohns_measurements, scale. = T, center = T)
pca_crohns_annotated <- cbind(as_tibble(pca_crohns$x), crohns_groups[2:3])
head(pca_crohns_annotated)
unique(pca_crohns_annotated$batch)
ggplot(pca_crohns_annotated, aes(x=PC1, y=PC2, col=batch)) + geom_point() + facet_wrap(~condition)
ggplot(pca_crohns_annotated, aes(x=PC1, y=PC2, shape=condition)) + geom_point(size=3)
pca_crohns_annotated %>%
  filter(condition == "con") %>%
  select(1:49) %>%
  apply(., 2, var)
