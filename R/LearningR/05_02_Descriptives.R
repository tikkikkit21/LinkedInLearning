# File:     05_02_Descriptives.R
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

# SUMMARY ##################################################

df %>% summary()  # Summary for entire table

df %>%    # Summary for one variable
  select(entrepreneur) %>%
  summary()

# QUARTILES ################################################

# Tukey's five-number summary: minimum, lower-hinge,
# median, upper-hinge, maximum. No labels.
fivenum(df$entrepreneur)

# Boxplot stats: hinges, n, CI for median, outliers
boxplot(df$entrepreneur, notch = T, horizontal = T)
boxplot.stats(df$entrepreneur)

# ALTERNATIVE DESCRIPTIVES #################################

p_load(psych)           # Load psych package
p_help(psych, web = F)  # Get info on psych package

describe(df$entrepreneur)  # Single variable
describe(df)               # Entire dataframe

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
