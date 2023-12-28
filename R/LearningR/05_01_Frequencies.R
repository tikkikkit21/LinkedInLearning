# File:     05_01_Frequencies.R
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

# SUMMARIZE DATAFRAME ######################################

summary(df)  # Gives frequencies for factors only

# SUMMARIZE CATEGORICAL VARIABLE ###########################

# "region" is a character variable

# summary() not very useful
df %>% 
  select(region) %>%
  summary()

# table() works better
df %>% 
  select(region) %>%
  table()

# SUMMARIZE FACTOR #########################################

# "psychRegions" is a factor

# Using summary() works best
df %>%
  select(psychRegions) %>%
  summary()

# Using table()
df %>%
  select(psychRegions) %>%
  table()

# Summarize multiple factors
df <- df %>%
  mutate(region = as.factor(region)) %>%
  mutate(psychRegions = as.factor(psychRegions)) %>%
  print()

summary(df)

# CLEAN UP #################################################

# Clear environment
rm(list = ls()) 

# Clear packages
p_unload(all)  # Remove all add-ons

# Clear console
cat("\014")  # ctrl+L

# Clear mind :)
