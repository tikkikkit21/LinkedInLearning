# File:     05_03_Correlations.R
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

# CORRELATION MATRIX #######################################

# Correlation matrix for data frame
cor(df)

# Rounded to 2 decimals
df %>%
  cor() %>%
  round(2)

# SINGLE CORRELATION #######################################

# Can test one pair of variables at a time
# Gives r, hypothesis test, and confidence interval
cor.test(df$instagram, df$privacy)

# P-VALUES FOR MATRIX ######################################

# Install "Hmisc" package to get p-values for matrix
p_load(Hmisc)

# Need to coerce from dataframe to matrix to get both a
# correlation matrix and p-values (in separate tables)
df %>%
  as.matrix() %>%
  rcorr()

# CLEAN UP #################################################

# Clear environment
rm(list = ls()) 

# Clear packages
p_unload(all)  # Remove all add-ons

# Clear console
cat("\014")  # ctrl+L

# Clear mind :)
