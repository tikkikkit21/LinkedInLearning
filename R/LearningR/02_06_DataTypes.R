# DATA TYPES ###################################################################

# Numerical
n1 <- 15
n1
typeof(n1) # double by default

n2 <- 1.5
n2
typeof(n2)

# Characters
c1 <- "c"
c1
typeof(c1) # character

c2 <- "a string of text"
c2
typeof(c2) # also a character (chars and strings are both "character"s in R)

# Logical
l1 <- TRUE    # all caps
l1
typeof(l1)

l2 <- F       # can also use capital initials
l2
typeof(l2)

# DATA STRUCTURES ##############################################################

## Vector ======================================================================
# - the default data structures in R
#     - everything is a vector unless it's more complicated
# - vectors with 1 value is still a vector (not a scalar)
v1 <- c(1, 2, 3, 4, 5)
v1
is.vector(v1)

v2 <- c("a", "b", "c")
v2
is.vector(v2)

v3 <- c(T, T, F, F, T)
v3
is.vector(v3)

v4 <- c("one_val") # still a vector
v4
is.vector(v4)

## Matrix ======================================================================
# - Matrices can only store 1 data type
# - Properties:
#    - nrow: number of rows in the matrix
#    - byrow: fills matrices row by row (default is false, or column-by-column)
m1 <- matrix(c(T, T, F, F, T, F), nrow = 2)
m1

m2 <- matrix(c("a", "b",
             "c", "d"),
             nrow = 2,
             byrow = T)
m2

## Array =======================================================================
# - arrays are more flexible than matrices
# - can have have more dimensions

# give data, then the dimensions (rows, columns, tables)
a1 <- array(c(1:24), c(4,3,2))

## Data Frame ==================================================================
# - universal container in R, very popular for large datasets
# - can have data with different types (like a spreadsheet)

# combine vectors of the same length
vNumeric <- c(1,2,3)
vChar    <- c("a","b","c")
vLogical <- c(T,F,T)

# coerces all values to most basic data type
df1 <- cbind(vNumeric, vChar, vLogical)
df1

# preserves data types
df2 <- as.data.frame(cbind(vNumeric, vChar, vLogical))
df2

## List ========================================================================
## - list is the most generic data structure
##     - can put anything in it
## - good for working with text and JSON files
o1 <- c(1,2,3)
o2 <- c("a","b","c","d")
o3 <- c(T,F,T,T,F)

list1 <- list(o1,o2,o3)
list1

list2 <- list(o1,o2,o3,list1)
list2

# COERCING TYPES ###############################################################
# - same as "casting" in Java

## Automatic Coercing ==========================================================
## - goes to least restrictive type
(coerce1 <- c(1, "b", T))
typeof(coerce1)

## Numeric to Integer ==========================================================
(coerce2 <- 5)
typeof(coerce2)

(coerce3 <- as.integer(5))
typeof(coerce3)

## Character to Numeric ========================================================
(coerce4 <- c("1","2","3"))
typeof(coerce4)

(coerce5 <- as.numeric(coerce4))
typeof(coerce5)

## Matrix to Data Frame ========================================================
## - sometimes even though data can be represented as a matrix, we need to treat
##   it as a data frame
(coerce6 <- matrix(1:9, nrow = 3))
is.matrix(coerce6)

(coerce7 <- as.data.frame(matrix(1:9, nrow = 3)))
is.data.frame(coerce7)