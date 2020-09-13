library(tidyverse)
drugs2 <- read_tsv("data/data/patients_drugs2.txt")
drugs2 <- gather(drugs2, key = "drug.id", val ="drug.response", drug1, drug2, drug3, drug4)
drugs2
ggplot(drugs2) + geom_point(aes(x=age, y=drug.response, col= drug.id))
ggplot(drugs2) + geom_point(aes(x=weight, y=drug.response, col= drug.id))
ggplot(drugs2) + geom_point(aes(x=weight, y=drug.response, col= drug.id)) + facet_wrap(~gender)

diamonds %>%
  group_by(cut) %>%
  summarize(price.mean = mean(price), )


ggplot(diamonds, aes(x=price)) + geom_histogram() + facet_wrap(~cut)
ggplot(diamonds, aes(x=price, col = cut)) + geom_density()
ggplot(diamonds, aes(x=cut, y = price)) + geom_boxplot() + geom_jitter(alpha=0.05, aes(col=cut))
ggplot(diamonds, aes(x=cut, y = price)) + geom_violin()

erab <- read_tsv("data/data/ERab_width.txt")
tail(erab)
e_a <- erab %>% filter()
e_b <- erab[erab$transcription.factor == "ERb",1]
wilcox.test(e_a, e_b)
