# File:     05_04_Regression.R
# Project:  LearningR

# INSTALL AND LOAD PACKAGES ################################

# pacman must already be installed; then load contributed
# packages (including pacman) with pacman
pacman::p_load(pacman, rio, tidyverse)

# LOAD AND PREPARE DATA ####################################

# Save Google Correlate variables
df <- import("data/StateData.xlsx") %>%
  as_tibble() %>%
  select(instagram:modernDance) %>% 
  print()

# SCATTERPLOTS #############################################

# Scatterplot of all Google Correlate variables
df %>%
  select(instagram:modernDance) %>%
  plot()

# Quick graphical check on data
df %>%
  select(museum, volunteering) %>%
  plot()

# Add regression line with lm()
lm(df$volunteering ~ df$museum) %>% abline()

# BIVARIATE REGRESSION #####################################

# Compute and save bivariate regression
fit1 <- lm(df$volunteering ~ df$museum)

# Show model
fit1

# Summarize regression model
summary(fit1)

# Confidence intervals for coefficients
confint(fit1)

# Predict values of "volunteering"
predict(fit1)

# Prediction intervals for values of "volunteering"
predict(fit1, interval = "prediction")

# Regression diagnostics
lm.influence(fit1)
influence.measures(fit1)

# MULTIPLE REGRESSION ######################################

# Moving the outcome to the front can make things easier
df <- df %>%
  select(volunteering, everything()) %>%
  print()

# Three ways to specify model

# Most concise
lm(df)

# Identify outcome, infer rest
lm(volunteering ~ ., data = df)

# Identify entire model
lm(volunteering ~ instagram + facebook + retweet +
   entrepreneur + gdpr + privacy + university + 
   mortgage + museum + scrapbook + modernDance, 
   data = df)

# Save model
fit2 <- lm(df)

# Show model
fit2

# Summarize regression model
summary(fit2)

# Confidence intervals for coefficients
confint(fit2)

# Predict values of "volunteering"
predict(fit2)

# Prediction intervals for values of "volunteering"
predict(fit2, interval = "prediction")

# Regression diagnostics
lm.influence(fit2)
influence.measures(fit2)

# CLEAN UP #################################################

# Clear environment
rm(list = ls()) 

# Clear packages
p_unload(all)  # Remove all add-ons

# Clear plots
dev.off()  # But only if there IS a plot

# Clear console
cat("\014")  # ctrl+L

# Clear mind :)
