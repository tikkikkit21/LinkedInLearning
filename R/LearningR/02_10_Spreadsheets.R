# INSTALL AND LOAD PACKAGES ####################################################
if (!require("pacman")) install.packages("pacman")

# pacman: package manager
# party: partitioning and decision trees
# rio: R I/O (importing data)
# tidyverse: duh
pacman::p_load(pacman, party, rio, tidyverse)

# LOAD AND PREPARE DATA ########################################################
# - save data to "df" (a "data frame")
# - rename outcome as "y" if it helps
# - specify outcome with df$y

# import CSV files with readr:read_csv() from tidyverse
(df <- read_csv("data/StateData.csv"))

# import any other formats with rio::format()
(df <- import("data/StateData.xlsx") %>% as_tibble())

# some data manipulation
df <- import("data/StateData.xlsx") %>%
as_tibble() %>%
  select(state_code, 
         psychRegions,
         instagram:modernDance) %>% 
  mutate(psychRegions = as.factor(psychRegions)) %>%
  rename(y = psychRegions) %>%
  print()