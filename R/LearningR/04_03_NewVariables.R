# File:     04_03_NewVariables.R
# Project:  LearningR

# INSTALL AND LOAD PACKAGES ################################

# pacman must already be installed; then load contributed
# packages (including pacman) with pacman
pacman::p_load(pacman, rio, tidyverse)

# LOAD AND PREPARE DATA ####################################

df <- import("data/StateData.xlsx") %>%
  as_tibble() %>%
  select(state_code, 
    psychRegions,
    instagram:modernDance) %>% 
  mutate(psychRegions = as.factor(psychRegions)) %>%
  # rename(y = psychRegions) %>%
  print()

# AVERAGE VARIABLES ########################################

df %>%
  mutate(
    socialMedia = (instagram + facebook + retweet) / 3,
    artsCrafts  = (museum + scrapbook + modernDance) / 3
  ) %>%
  select(state_code, socialMedia, artsCrafts)

# REVERSE CODING ###########################################

df %>%
  mutate(
    outgoing = (volunteering + (privacy * -1)) / 2
  ) %>%
  select(state_code, outgoing, volunteering, privacy)

# For 1-n scale, use (n+1) - x
# For 0-n scale, use n - x

# PACKAGES #################################################

# Packages "psych" and "scale" make this process much easier
browseURL("https://CRAN.R-project.org/package=psych")
browseURL("https://CRAN.R-project.org/package=Scale")

# CLEAN UP #################################################

# Clear environment
rm(list = ls()) 

# Clear packages
p_unload(all)  # Remove all add-ons

# Clear console
cat("\014")  # ctrl+L

# Clear mind :)
