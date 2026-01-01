#LOAD DATA
library(tidyverse)
library(brms)
vlbw_clean <- readRDS("data/vlbw_clean.rds")
glimpse(vlbw_clean)

vlbw_model <- vlbw_clean %>%
  mutate(
    bwt_z   = scale(bwt)[, 1],
    pltct_z = scale(pltct)[, 1])

priors1 <- c(
  prior(normal(0, 1), class = "Intercept"),
  prior(normal(0, 1), class = "b", coef = "bwt_z"),
  prior(normal(0, 1), class = "b", coef = "pltct_z"),
  prior(normal(0, 1), class = "b", coef = "ivh"),
  prior(normal(0, 1), class = "b", coef = "pneumo"))

#FITTING MODEL
fit1 <- brm(
  dead ~ bwt_z + pltct_z + ivh + pneumo,
  data = vlbw_model,
  family = bernoulli(link = "logit"),
  prior = priors1,
  chains = 4,
  iter = 2000,
  seed = 123,
  control = list(adapt_delta = 0.95))
summary(fit1)
plot(fit1)

#POSTERIOR CHECK WITH PLOT
pp_check(fit1, type = "bars")
