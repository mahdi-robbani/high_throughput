library(tidyverse)
flowers <- read_tsv("data/data/flowers.txt")
flowers

x <- filter(as.data.frame(flowers), Species == "setosa")
as.tibble(x)
typeof(as.data.frame(flowers))

filter(flowers, Species == "setosa", Sepal.Width > 3.1, Sepal.Width < 5)
arrange(flowers, desc(Petal.Width), desc(Sepal.Width))

new_flowers <- mutate(flowers, Sepal.Area = Sepal.Length * Sepal.Width)
head(new_flowers)
transmute(flowers, Sepal.Area = Sepal.Length * Sepal.Width)

flowers %>%
  group_by(Species) %>%
  summarize(Sepal.Mean = mean(Sepal.Width), 
            Sepal.Max = max(Sepal.Width), 
            Sepal.Min = min(Sepal.Width),
            Sepal.SD = sd(Sepal.Width), 
            Sepal.Range = Sepal.Max - Sepal.Min)

flowers %>%
  mutate(Sepal.Area = Sepal.Width * Sepal.Length) %>%
  filter(Sepal.Area > 15) -> output_flowers
output_flowers

flowers %>%
  mutate(Sepal.Area = Sepal.Width * Sepal.Length) %>%
  filter (Sepal.Area > 15) %>%
  group_by(Species) %>%
  summarise(Sepal.Area.Mean = mean(Sepal.Area),
            Sepal.Area.SD = sd(Sepal.Area)) %>%
  ggplot(aes(y=Sepal.Area.Mean, x=Species, fill=Species)) + 
  geom_bar(stat = "identity") + 
  geom_errorbar(aes(ymin = Sepal.Area.Mean - Sepal.Area.SD, 
                    ymax = Sepal.Area.Mean + Sepal.Area.SD,
                    width = 0.1))

