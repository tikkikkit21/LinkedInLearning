# - piping commands make it a lot easier to mentally trace code
# - we use the %<% operator
# - doesn't come with R, part of package Magrittr, which is part of tidyverse

# function(data) -> data %<% function()

# function(data, args) -> data %<% function(args)

# three(two(one(data, a), b), c) -> data %<% one(a) <%< two(b) <%< three(c)