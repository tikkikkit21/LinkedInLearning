# SAMPLE DATASET ###############################################################
x = c(24, 13, 7, 15, 3, 2)
barplot(x) # simple bar plot

# COLORS IN R ##################################################################
# - there are 657 color names for 502 unique colors
#     - deals with different spellings and variations
# - arranged alphabetically except for white, which is first
# - a good resource is https://datalab.cc/rcolors
?colors
colors() # gets a list of colors

# USING COLORS #################################################################

# Color names
barplot(x, col = "red3")        # red3
barplot(x, col = "slategray3")  # slategray3

# RGB triplets (0.00-1.00)
barplot(x, col = rgb(.80, 0, 0))      # red3
barplot(x, col = rgb(.62, .71, .80))  # slategray3

# RGB triplets (0-255), need to specify max = 255
barplot(x, col = rgb(205, 0, 0, maxColorValue = 255))     # red3
barplot(x, col = rgb(159, 182, 205, maxColorValue = 255)) # slategray3

# RGB hexcodes
barplot(x, col = "#CD0000")  # red3
barplot(x, col = "#9FB6CD")  # slategray3

# Index numbers
barplot(x, col = colors() [555])  # red3
barplot(x, col = colors() [602])  # slategray3

# MULTIPLE COLORS ##############################################################
# - can specify several colors in a vector, which will cycle
barplot(x, col = c("red3", "slategray3"))
barplot(x, col = c("#9FB6CD", "#CD0000"))

# COLOR PALETTES #########################################################
?palette  # Info on palettes
palette() # See current palette

barplot(x, col = 1:6)                # Use current palette
barplot(x, col = rainbow(6))         # Rainbow colors
barplot(x, col = heat.colors(6))     # Yellow through red
barplot(x, col = terrain.colors(6))  # Gray through green
barplot(x, col = topo.colors(6))     # Purple through tan
barplot(x, col = cm.colors(6))       # Pinks and blues
