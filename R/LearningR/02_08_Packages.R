# Installs pacman (a package manager) if needed
if (!require("pacman")) install.packages("pacman")

# Load the following packages with pacman
# - pacman: for loading/unloading packages
# - party: decision trees
# - psych: statistical procedures
# - rio: importing data
# - tidyverse: many functionalities
pacman::p_load(pacman, party, psych, rio, tidyverse)

# Load base packages manually
library(datasets)

# CLEANING UP ##################################################################

# Clear enviornment
rm(list = ls())

# Clear packages
p_unload(all)
detach("package:datasets", unload = TRUE)

# Clear plots
dev.off() # onlf if there is a plot

# Clear console
cat("\014")
