library(tidyverse)
mm8 <- read_tsv('Class/mm8.bed/mm8.bed')

mm8 %>%
  group_by(chrom) %>%
  summarize(count = length(name)) %>%
  arrange(desc(count))

mm8 %>%
  mutate(txLength = txEnd - txStart) %>%
  group_by(chrom) %>%
  summarize(mean = mean(txLength), median = median(txLength)) %>%
  arrange(desc(median))
