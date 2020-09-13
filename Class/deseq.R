library(tidyverse)
library(DESeq2)

# Information about samples
design <- read_tsv("Class/DE_datasets/IBD_study_design.tab")
# Count matrix (This is not a tibble, so we read it
#in as a data.frame and convert to matrix)
EM <- read.table("Class/DE_datasets/IBD_count_matrix.tab") %>% as.matrix
design
head(EM)

#Differential Expression ANalysis
dds <- DESeqDataSetFromMatrix(countData = EM, # Count matrix
                              colData = design, # - indicate what the design matrix is
                              design = ~ Class # - and then what column that 'splits' the data
                              # in this case the wto values in 'Minute': min0 and min30
)
dds <- DESeq(dds)
res_cda <- results(dds, contrast = c("Class", "con", "CDa"), alpha = 0.05) %>% as.data.frame %>% rownames_to_column("Gene") %>% as_tibble
res_uca <- results(dds, contrast = c("Class", "con", "UCa"), alpha = 0.05) %>% as.data.frame %>% rownames_to_column("Gene") %>% as_tibble
res_both <- results(dds, contrast = c("Class", "CDa", "UCa"), alpha = 0.05) %>% as.data.frame %>% rownames_to_column("Gene") %>% as_tibble

#check output
res_cda


#Dispersion plot
plotDispEsts(dds)

#MA plot
ggplot(res_cda, aes(x=baseMean, y=log2FoldChange)) +
  geom_point(alpha=0.5) + geom_smooth() +
  scale_x_log10() +
  geom_hline(yintercept = 0, alpha = 0.75,
             color="red")+
  theme_bw()
ggplot(res_uca, aes(x=baseMean, y=log2FoldChange)) +
  geom_point(alpha=0.5) + geom_smooth() +
  scale_x_log10() +
  geom_hline(yintercept = 0, alpha = 0.75,
             color="red")+
  theme_bw()
ggplot(res_both, aes(x=baseMean, y=log2FoldChange)) +
  geom_point(alpha=0.5) + geom_smooth() +
  scale_x_log10() +
  geom_hline(yintercept = 0, alpha = 0.75,
             color="red")+
  theme_bw()

#P value dist
ggplot(as.data.frame(res_cda), aes(x=pvalue)) +
  geom_histogram(binwidth = 0.05,
                 fill="hotpink", color="black")+theme_bw()
ggplot(as.data.frame(res_uca), aes(x=pvalue)) +
  geom_histogram(binwidth = 0.05,
                 fill="hotpink", color="black")+theme_bw()
ggplot(as.data.frame(res_both), aes(x=pvalue)) +
  geom_histogram(binwidth = 0.05,
                 fill="hotpink", color="black")+theme_bw()

#Independant filtering
ggplot(res_cda, aes(x=dense_rank(baseMean),
                 y=-log10(pvalue), color=padj < 0.05)) +
  geom_point(alpha=0.5)+theme_bw()
#bulge may be caused by batch effects 
ggplot(res_uca, aes(x=dense_rank(baseMean),
                    y=-log10(pvalue), color=padj < 0.05)) +
  geom_point(alpha=0.5)+theme_bw()
ggplot(res_both, aes(x=dense_rank(baseMean),
                    y=-log10(pvalue), color=padj < 0.05)) +
  geom_point(alpha=0.5)+theme_bw()

#Volcano plot
ggplot(res_cda, aes(x=log2FoldChange,
                 y=-log10(pvalue), color=padj < 0.05)) +
  geom_point(alpha=0.5) +
  geom_vline(xintercept = 0, alpha = 0.75,
             linetype="dashed")+theme_bw()
ggplot(res_uca, aes(x=log2FoldChange,
                    y=-log10(pvalue), color=padj < 0.05)) +
  geom_point(alpha=0.5) +
  geom_vline(xintercept = 0, alpha = 0.75,
             linetype="dashed")+theme_bw()
ggplot(res_both, aes(x=log2FoldChange,
                    y=-log10(pvalue), color=padj < 0.05)) +
  geom_point(alpha=0.5) +
  geom_vline(xintercept = 0, alpha = 0.75,
             linetype="dashed")+theme_bw()


#Compare manually
res_cda %>%
  arrange(padj)
res_uca %>%
  arrange(padj)
res_both %>%
  arrange(padj)
