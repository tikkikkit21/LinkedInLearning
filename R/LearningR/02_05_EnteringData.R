# BASIC COMMANDS ###############################################################
2+2     # simple math

1:100   # prints numbers 1 to 100

print("Hello, World!")

# ASSIGNING VALUES #############################################################
a <- 1              # Use '<-' instead of '=' (pronounced "a gets 1")
2 -> b              # works, but silly
c <- d <- e <- 3    # multiple assignments

# Multiple values
x <- c(1, 2, 5, 9)  # c = combine/concatenate (making a vector in this case)
x                   # prints contents of x to console

# SEQUENCES ####################################################################
# good for representing structured data
0:10                # 0 through 10
10:0                # 10 through 0
seq(10)             # same thing as 1:10
seq(30, 0, by = -3)  # counts down by 3

# MATH #########################################################################
(y <- c(5, 1, 0, 10)) # surrounding statement with () prints it
x + y                 # vector addition (x and y both have 4 elements)
x * 2                 # multiply all elements in x by 2

# more basic math
2^6
sqrt(64)
log(100)    # natural log (base e)
log10(100)  # log base 10

# CLEAN UP ####################################################################
rm(list = ls()) # clears variables in environment
cat("\014")     # clear console (ctrl+L)