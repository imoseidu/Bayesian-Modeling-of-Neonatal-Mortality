#CLEANING

library(tidyverse)
vlbw <- readRDS("../data/vlbw.rds")
glimpse(vlbw)

vlbw_clean <- vlbw %>%
  transmute(
    dead   = as.integer(dead),
    sex    = factor(sex),
    bwt    = as.numeric(bwt),
    pltct  = as.numeric(pltct),
    ivh    = as.integer(as.numeric(ivh) > 1),
    pneumo = as.integer(as.numeric(pneumo) > 0)
  ) %>%
  drop_na()

summary(vlbw_clean$ivh)
table(vlbw_clean$ivh)
saveRDS(vlbw_clean, "data/vlbw_clean.rds")

#DATASET AMOUNT
total <- nrow(vlbw_clean)
dead  <- sum(vlbw_clean$dead == 1)
alive <- sum(vlbw_clean$dead == 0)

total
dead
alive