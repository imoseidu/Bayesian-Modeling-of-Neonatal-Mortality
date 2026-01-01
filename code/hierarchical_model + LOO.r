#LOAD
library(tidyverse)
library(brms)
vlbw_clean <- readRDS("data/vlbw_clean.rds")

vlbw_model <- vlbw_clean %>%
  mutate(
    bwt_z   = scale(bwt)[, 1],
    pltct_z = scale(pltct)[, 1])

priors2 <- c(
  prior(normal(0, 1), class = "Intercept"),
  prior(normal(0, 1), class = "b", coef = "bwt_z"),
  prior(normal(0, 1), class = "b", coef = "pltct_z"),
  prior(normal(0, 1), class = "b", coef = "ivh"),
  prior(normal(0, 1), class = "b", coef = "pneumo"),
  prior(exponential(1), class = "sd", group = "sex"))


#FITTING MODEL
fit2 <- brm(
  dead ~ bwt_z + pltct_z + ivh + pneumo + (1 | sex),
  data = vlbw_model,
  family = bernoulli(link = "logit"),
  prior = priors2,
  chains = 4,
  iter = 4000,
  warmup = 2000,
  seed = 123,
  control = list(adapt_delta = 0.99, max_treedepth = 15))
summary(fit2)
plot(fit2)


#LOO COMPARISON
library(loo)
fit1 <- readRDS("data/fit_pooled.rds")
loo1 <- loo(fit1)
loo2   <- loo(fit2)
loo_compare(loo1, loo2)