# File:     05_05_Contingency.R
# Project:  LearningR

# INSTALL AND LOAD PACKAGES ################################

# pacman must already be installed; then load contributed
# packages (including pacman) with pacman
pacman::p_load(pacman, rio, tidyverse)

# LOAD AND PREPARE DATA ####################################

# Save categorical variables
df <- import("data/StateData.xlsx") %>%
  as_tibble() %>%
  select(state_code, region, psychRegions) %>%
  mutate(psychRegions = as.factor(psychRegions)) %>%
  print()

# ANALYZE DATA #############################################

# Create contingency table
ct <- table(df$region, df$psychRegions)
ct

# Call also get cell, row, and column %
# With rounding to get just 2 decimal places
# Multiplied by 100 to make %

p_load(magrittr)  # To get arithmetic aliases

# Row percentages
ct %>%
  prop.table(1) %>%  # 1 is for row perdentages
  round(2) %>%
  multiply_by(100)

# Column percentages
ct %>%
  prop.table(2) %>%  # 2 is for columns percentages
  round(2) %>%
  multiply_by(100)

# Total percentages
ct %>%
  prop.table() %>%  # No argument for total percentages
  round(2) %>%
  multiply_by(100)

# Chi-squared testj (but n is small)
tchi <- chisq.test(ct)
tchi

# Additional tables
tchi$observed   # Observed frequencies (same as ct)
tchi$expected   # Expected frequencies
tchi$residuals  # Pearson's residual
tchi$stdres     # Standardized residual

# CLEAN UP #################################################

# Clear environment
rm(list = ls()) 

# Clear packages
p_unload(all)  # Remove all add-ons

# Clear console
cat("\014")  # ctrl+L

# Clear mind :)
