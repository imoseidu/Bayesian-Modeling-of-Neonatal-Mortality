library(tidyverse)
vlbw_clean <- readRDS("data/vlbw_clean.rds")
glimpse(vlbw_clean)

mean(vlbw_clean$dead)
table(vlbw_clean$dead)
summary(vlbw_clean$bwt)
summary(vlbw_clean$pltct)

#PLOTS
ggplot(vlbw_clean, aes(bwt)) +
  geom_histogram(bins = 30)
ggplot(vlbw_clean, aes(pltct)) +
  geom_histogram(bins = 30)

#CORRELATION MATRIX
num_dat <- vlbw_clean %>%
  select(dead, bwt, pltct, ivh, pneumo) %>%
  mutate(across(everything(), as.numeric))
cor(num_dat)

#VIF
glm_check <- glm(
  dead ~ bwt + pltct + ivh + pneumo,
  data = vlbw_clean,
  family = binomial()
)
car::vif(glm_check)

