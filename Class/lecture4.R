#lecture 4
install.packages('hexbin')
library(hexbin)
library(tidyverse)
genes <- read_tsv("data/data/gene_lengths.txt")
genes
ggplot(genes) + geom_density(aes(x=gene_length)) + facet_wrap((~chr))
#the plots show the data is not normally distributed at all, chr1 looks likeit has more small genes
kruskal.test(gene_length ~ chr, data=genes)
pairwise.wilcox.test(genes$gene_length, g =genes$chr)

#ex 2
heights <- read_tsv("data/data/height.txt")
heights
ggplot(heights, aes(x=Year, y= mean_weight, col = mean_height)) +
  geom_point() + 
  facet_wrap(~Gender, scales = "free_y") +
  geom_smooth(method = "lm")

#ex4
many.genes <- read_tsv("data/data/manyGenes.txt")
ggplot(many.genes, aes(x=exprA, y=exprB)) + geom_point(alpha = 0.1)
ggplot(many.genes, aes(x=exprA, y=exprC)) + geom_point(alpha = 0.1, size = 0.1)

ggplot(many.genes, aes(y=exprA, x=exprC ))+
  geom_bin2d(bins=100) # try changing bins to some other value
ggplot(many.genes, aes(y=exprA, x=exprC ))+
  geom_hex(bins=50) # try changing bins to some other value
ggplot(many.genes, aes(y=exprA, x=exprC ))+
  geom_density_2d()
ggplot(many.genes, aes(y=exprA, x=exprC ))+
  stat_density_2d(aes(fill = after_stat(level)), geom = "polygon")

#ex 5
gss_cat
gss_cat %>%
  filter(relig=="Christian" | relig== "Orthodox-christian",
         marital=="Divorced"| marital=="Married") %>%
  count(marital, relig) %>%
  spread(relig, n) -> simple_count
simple_count
simple_count_mat <- as.matrix(simple_count[1:2, 2:3])
fisher.test(simple_count_mat)
fisher.test(simple_count_mat*2)
fisher.test(round(simple_count_mat*0.5))
