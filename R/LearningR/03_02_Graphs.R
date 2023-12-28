# PACKAGES #####################################################################
if (!require("pacman")) install.packages("pacman")
pacman::p_load(pacman, rio, tidyverse)

# 'diamonds' contains data on different kinds of diamonds
?diamonds
diamonds

# BARPLOT #####################################################################
# - easiest way to display data
# - one of the most common graphs in R

# shortest way to make a bar plot
plot(diamonds$cut)

# another way with piping
select(diamonds, color) %>%
  plot()
# plot(select(diamonds, color))

# need to convert data to a table before it can be a bar plot
?table
select(diamonds, clarity) %>%
  table() %>%
  barplot()
# barplot(table(select(diamonds, clarity)))

# sort in decreasing value
select(diamonds, clarity) %>%
  table() %>%
  sort(decreasing = T) %>%
  barplot()

# add options to plot
select(diamonds, clarity) %>%
  table() %>%
  barplot(
    main   = "Clarity of Diamonds",           # Main title
    sub    = "(Source: ggplot2::diamonds)",   # Subtitle
    horiz  = T,                               # Draw horizontal bars
    ylab   = "Clarity of Diamonds",           # Label for y-axis
    xlab   = "Frequency",                     # Label for x-axis
    xlim   = c(0, 15000),                     # Limits for x-axis
    border = NA,                              # No borders on bars
    col    = "#CD0000"                        # Bar color is red3
  )

## Multi-Data Barplots #######################################################
# - displays different sets of data together
# - useful for comparisons

# 100% (percent-based) stacked bars
select(diamonds, color, clarity) %>%
  plot()

# Numerical stacked bars
#   Step 1: Create a table
df <- select(diamonds, color, clarity) %>%
  table() %>%
  print()  # Show table in Console

#   Step 2: Create graph w/ legend
df %>%
  barplot(legend = rownames(.)) # dot indicates where the piped thing goes

# Side-by-side bar
df %>%
  barplot(
    legend = rownames(.),
    beside = T  # Put bars next to each other
  )

# HISTOGRAMS ###################################################################
# - a way to visualize quantitative data
# - useful for seeing how data is distributed

# Histogram with defaults
hist(diamonds$price)

# Histogram with options
hist(diamonds$price,
  breaks = 7,  # Suggest number of bars (not guaranteed)
  main   = "Histogram of Price of Diamonds",
  sub    = "(Source: ggplot2::diamonds)",
  ylab   = "Frequency",
  xlab   = "Price of Diamonds",
  col    = "red3"
)

# BOXPLOTS #####################################################################
# - shows the presence of any outliers in data

# default is vertical
boxplot(diamonds$price)

# boxplot with options
diamonds$price %>%
  boxplot(
    horizontal = T,  # Horizontal
    notch  = T,      # Confidence interval for median
    main   = "Boxplot of Price of Diamonds",
    sub    = "(Source: ggplot2::diamonds)",
    xlab   = "Price of Diamonds",
    col    = "#CD0000"  # red3
  )

## Boxplots By Group ###########################################################
# - can be used to compare boxplots of different variables

# Boxplots by group using plot()
diamonds %>%
  select(color, price) %>%
  plot()

# Boxplots by group using boxplot()
diamonds %>%
  select(color, price) %>%
  boxplot(
    price ~ color,  # Tilde indicates formula
    data  = . ,     # Dot is placeholder for pipe
    col   = "#CD0000"
  )

# SCATTERPLOTS #################################################################
# - used for finding connections among data

# load data spreadsheet
df <- import("data/StateData.xlsx") %>%
  as_tibble() %>%
  select(state_code, 
         psychRegions,
         instagram:modernDance) %>% 
  mutate(psychRegions = as.factor(psychRegions)) %>%
  print()

# Plot all possible paired associations
df %>%
  select(instagram:modernDance) %>% 
  plot()

# Bivariate scatterplot with defaults
df %>%
  select(scrapbook:modernDance) %>% 
  plot()

# Bivariate scatterplot with options
df %>%
  select(scrapbook:modernDance) %>% 
  plot(
    main = "Scatterplot of Google Searches by State",
    xlab = "Searches for \"scrapbook\"",
    ylab = "Searches for \"modern dance\"",
    col  = "red3",  # Color of points
    pch  = 20,      # "Plotting character" (small circle)
  )

?pch  # See plotting characters

## Linear Regression Line ######################################################

# Add fit linear regression line (y ~ x) 
df %>%
  lm(modernDance ~ scrapbook, data = .) %>%
  abline()

# Identify outlier
df %>%
  select(state_code, scrapbook) %>%
  filter(scrapbook > 4) %>%  # Select outlier
  print()

# Bivariate scatterplot without outlier
df %>%
  select(scrapbook:modernDance) %>% 
  filter(scrapbook < 4) %>%  # filter out outlier
  plot(
    main = "Scatterplot of Google Searches by State",
    xlab = "Searches for \"scrapbook\"",
    ylab = "Searches for \"modern dance\"",
    col  = "gray",  # Color of points
    pch  = 20,      # "Plotting character" (small circle)
  )

# Add fit line without outlier
df %>%
  filter(scrapbook < 4) %>%  # filter out outlier
  lm(modernDance ~ scrapbook, data = .) %>%
  abline()

# LINE CHARTS ##################################################################

## Single Time Series #######################################

# US population
?uspop  # Get info about data
uspop   # Display data

?ts  # Get info about time-series objects

# Plot with default plot()
plot(uspop)

# Plot with options
uspop %>% 
  plot(
    main = "US Population 1790–1970 ",
    sub  = "(Source: datasets::uspop)",
    xlab = "Year",
    ylab = "Population (in millions)",
  )

abline(v = 1930, col = "lightgray")   # vertical line at year 1930
text(1930, 10, "1930", col = "red3")  # '1930' label in red
abline(v = 1940, col = "lightgray")   # vertical line at year 1940
text(1940, 2, "1940", col = "red3")   # '1940' label in red

# Plot with ts.plot()
?ts.plot
# Although this can be used for a single time series, plot
# is easier to use and is preferred.
ts.plot(uspop)

# Plot with plot.ts()
# More powerful alternative
?plot.ts
plot.ts(uspop)

# MULTIPLE TIME SERIES #####################################
# - compares multiple time series
# - can be different windows or side-by-side

# EuStockMarkets
?EuStockMarkets
EuStockMarkets

# Three different plot functions
plot(EuStockMarkets)     # Stacked windows
plot.ts(EuStockMarkets)  # Identical
ts.plot(EuStockMarkets)  # One window

# CLUSTER PLOTS ################################################################
df <- import("data/StateData.xlsx") %>%
  as_tibble() %>%
  select(state_code, 
         psychRegions,
         instagram:modernDance) %>% 
  mutate(psychRegions = as.factor(psychRegions)) %>%
  rename(y = psychRegions) %>%
  print()

## Analyze Data ################################################################
## - By using standardized object and variable names, the same code can be
##   reused for different analyses

# Calculate clusters
hc <- df %>%  # Get data
  dist %>%    # Compute distance/dissimilarity matrix
  hclust      # Compute hierarchical clusters

# Plot dendrogram
hc %>% plot(labels = df$state_code)

# Draw boxes around clusters
hc %>% rect.hclust(k = 2, border = "gray80")  # 2 boxes
hc %>% rect.hclust(k = 3, border = "gray60")  # 3 boxes
hc %>% rect.hclust(k = 4, border = "gray40")  # 4 boxes
