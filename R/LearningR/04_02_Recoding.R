# File:     04_02_Recoding.R
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

# COMBINE CATEGORIES WITH RECODE ###########################

df %>%
  mutate(relaxed = recode(psychRegions,
    "Relaxed and Creative" = "yes",
    "Friendly and Conventional" = "no",
    .default = "no")) %>%  # Sets default value
  select(state_code, psychRegions, relaxed)

# CFREATE CATEGORIES WITH CASE_WHEN ########################

# case_when works a little differently so we'll save as df2
df2 <- df %>%
  mutate(likeArts = case_when(
    museum > 1 | scrapbook > 1 | modernDance > 1 ~ "yes",
    TRUE ~ "no"))  # All other values

df2 %>% 
  select(state_code, likeArts, museum:modernDance) %>%
  arrange(desc(likeArts)) %>%
  print(n = Inf)

# CLEAN UP #################################################

# Clear environment
rm(list = ls()) 

# Clear packages
p_unload(all)  # Remove all add-ons

# Clear console
cat("\014")  # ctrl+L

# Clear mind :)
