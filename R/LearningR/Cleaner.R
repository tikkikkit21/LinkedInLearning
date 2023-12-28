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

