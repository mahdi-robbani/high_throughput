library(tidyverse)
?mpg
#Class and drv are categorical values so scatter plots wont make any sense, use barchart instead I guess
#use geom_count
ggplot(data = mpg) + geom_point(aes(x=class, y = drv))
ggplot(data = mpg) + geom_count(aes(x=class, y = drv))

ggplot(data = mpg) + geom_point(aes(x=displ, y = hwy, color = class))
#Top left are outliers?

ggplot(data = mpg) +
  geom_point(aes(x = hwy, y= cty, col = displ))
#Highway and City miles are directly proportional, but some large engines have better highway mileage than city milage


ggplot(data = mpg) +
  geom_point(aes(x = hwy, y= cty, size = cyl, col = class))

ggplot(data = mpg) +
  geom_point(aes(x = hwy, y= cty, shape = as.factor(cyl), col = class))
#suvs and 2 seaters tend to be the best


ggplot(data = mpg) +
  geom_point(aes(x = cty, y = hwy, col = displ))+
  facet_grid(cyl ~ class)


demo <- tribble(~cut, ~freq,
                "Fair", 1610,
                "Good", 4906,
                "Very Good", 12082,
                "Premium", 13791,
                "Ideal", 21551)

ggplot(data = demo) + geom_bar(mapping = aes(x = cut, y = freq), stat = "identity")


ggplot(data = diamonds) + geom_bar(aes(x = clarity, fill = color), position = "dodge")
ggplot(data = diamonds) + geom_bar(aes(x = cut, fill = color), position = "dodge")
ggplot(data = diamonds) + geom_bar(aes(x = cut, fill = color), position = "dodge") + facet_wrap(~clarity)

