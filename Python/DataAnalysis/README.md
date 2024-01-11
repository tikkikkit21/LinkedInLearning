# Python Data Analysis
https://www.linkedin.com/learning/python-data-analysis-2

## Basic Data Structures
### Loops
- Basic loop structure is;
    ```Python
    for i in iterable:
        # do something with i
    ```
    - Iterable can be a list, dict, set, iterator, generator, etc.
    - Most common is `range`
- Different uses for `range`
    ```Python
    range(0,10)     # goes from 0,1,...,9
    range(5)        # goes from 0,1,...,5
    range(0,10,2)   # goes from 0,2,...,8
    ```

### Sequences
#### Lists
- Basics about lists
    - Uses brackets, separated by commas
    - Use `len(list)` to get number of elements
    - Indexing uses bracket notation (`list[0]`)
    - Does not need to be homogenous
    - By default, indexes go from `0` to `len(list)-1`
- Negative indexes are possible in Python
    - `-1` is the end of the list
    - `-(N-1)` is the beginning
- Useful functions:
    ```Python
    myList.append(4)            # adds an element to the end of list
    myList.extend([5,6])        # adds multiple elements at the same time
    newList = list1 + list2     # concats the 2 lists together
    myList.insert(0, 7)         # specifies where to insert an element
    del myList[1]               # removes element at specified index
    myList.remove(6)            # removes element based on value
    myList.sort()               # sorts the list
    sortedList = sorted(        # creates a new sorted list (can be reversed)
        list,
        reverse=True
    )
    ```

#### Slicing
- Slices work similarly to loops in terms of indexing (start is inclusive, end
  is not)
- Makes it easy to get subsections of data structures

```Python
myList[0:2]             # gives elements at index 0,1
myList[:4]              # gives elements from 0,...,3
myList[:3]              # gives elements from 3,...,end
myList[:]               # makes a copy of entire list
myList[0:7:2]           # moves through indexes by 2
myList[-3:-1]           # move backwards
myList[2:4] = [a, b]    # reassign subsections
del myList[4:6]         # delete subsections
```

#### Tuples
- Tuples are similar to lists, except they're immutable

```Python
(a,b) = (1,2)   # creating tuple
c,d = 3,4       # alternate way

args = (1,2,3)
*args           # asterisk indicates variable is a tuple
```

### Dictionaries
- Note that when `update`ing, if `myDict` already has a key in `moreDict`, it
  will be overwritten by `moreDict`
- For a dict key to be valid, it must be unique and hashable

```Python
myDict['new_key'] = 'new_value'     # add new element to dict
'key' in myDict                     # check if kv-pair exists
myDict.update(moreDict)             # adds 2 dicts together
myDict[(0,1)] = 'value'             # tuples can be used as keys
hash('value')                       # generates numerical representation of value

for key in mydict                   # key looping
for key in myDict.keys()            # explicit key looping
for value in myDict.values()        # value looping
for key, value in myDict.items()    # loop over both
```

### Sets
- Sets can be thought of a bags of items
- Note that sets don't have indexing functions

```Python
mySet = {a,b,c}         # create a set
a in mySet              # check if item is in set
mySet.add(value)        # add item to set
mySet.remove(value)     # remove item to set
for item in mySet       # loop in set
```

### Comprehensions
```Python
squares = [i**2 for i in range(1,11)]                           # basic form
squares_by_four = [i**2 for i in range(1,11) if i**2 % 4 == 0]  # add conditional

squares_dict  {i: i**2 for i in range(1,11)}                    # store in dict
transpose = {value: for key, value in myDict.items()}           # swap key/value

sum(i**2 for i in range(1,11))                                  # in a function
counting = [j for i in range(1,11) for j in range(1,1+1)]       # nested for loops
```

### Advanced Containers
#### Named Tuples
- Named tuples makes code easier and less prone to bugs

```Python
import collections

# creating tuples
persontype = collections.namedtuple('person', ['firstname', 'lastname', 'birthday'])
michele = persontype("Michele", "Vallisneri", "July 15")
michele2 = persontype(
    firstname = "Michele",
    lastname = "Vallisneri",
    birthday = "July 15"
)

# indexing tuples
michele[0], michele[1], michele[2]
michele2.firstname, michele2.lastname, michele2.birthday
```

#### Dataclasses
- Dataclasses are another approach
    - Uses an OO programming approach
- Much more concise than normal classes with minimal boilerplate code
- Used for immutable records, rather than typical objects

```Python
from dataclasses import dataclass

@dataclass
class PersonClass:
    firstname: str
    lastname: str
    birthday: str = 'unknown'   # default value

michele = PersonClass('Michele', 'Vallisneri')

@dataclass
class PersonClass2:
    firstname: str
    lastname: str
    birthday: str = 'unknown'   # default value

    def fullname(self):
        return self.firstname + ' ' self.lastname

michele2 = PersonClass2('Michele', 'Vallisneri', 'Jan 1')
print(michele2.fullname())
```

#### Default Dicts
- Default dicts will provide a value if a key doesn't exist
- Useful for lists of things where not every possible key is guaranteed a value
    - Ex: listing famous people for each possible birthday

```Python
import collections

def default():
    return "I don't know"

questions = collections.defaultdict(default)

myDict = {"key", "value"}
myDict["key"]   # returns "value"
myDict["key2"]  # returns "I don't know"
```

## Anagrams
- 2 words are *anagrams* if their letters can be re-arranged into each other
    - Ex: "elvis" and "lives"
- We define a *signature* of a word as a sorted list of all its letters
    - Includes duplicates
    - Signature of "post" would be "opst"
    - Signature of "tree" would be "eert"
- The goal is to figure out all anagrams of a word
    - First we'll compute the signature
    - Then look up the signature in a dict
    - The dict will store all possible words that correspond to a signature

```Python
import collections

# use set instead of list to prevent duplicates
words = set()
for line in open("words.txt", "r"):
    words.append(line.strip().lower())

# alternative way using comprehension
words = sorted({line.strip().lower() for line in open('words.txt', 'r')})

# get signature
def signature(word):
    return ''.join(sorted(word))

# slow and inefficient way to find anagrams
def find_anagram(myWord):
    mySig = signature(myWord)

    for word in words:
        if mySig == signature(word):
            print(word)

# faster way using defaultdict
words_by_sig = collections.defaultdict(set)

for word in words:
    words_by_sig[signature(word)].add(word)

# we don't include keys with only one value since every word is an anagram of itself
anagrams_by_sig = {sig: wordset for sig, wordset in words_by_sig.items() if len(wordset) > 1}

def find_anagram_fast(myword):
    sig = signature(myword)

    try:
        return anagrams_by_sig[sig]
    except KeyError:
        return set()
```

## NumPy Arrays
- `numpy` is a popular package for data analysis
    - Fast, memory-efficient N-dimensional arrays
    - Supports large datasets
    - Arrays are homogeneous
- Python lists are heterogenous, which makes them slower
    - A Python variable is simply a label that refers to something in memory
    - A list is not necessarily a contiguous block in memory like other languages
- NumPy reserves contiguous spaces in memory to store all values side-by-side
    - Speeds it up
    - Each value is the same size, so they must be same type
- NumPy also introduces more detailed data types

### Creating NumPy Arrays
```Python
import numpy as np
import matplotlib.pyplot as plot

data = np.loadtxt('file.txt') # load array from TXT file

# info to print
print(data)         # preview of the data
print(data.ndim)    # number of dimensions
print(data.shape)   # actual dimensions
print(data.size)    # total number of entries
print(data.dtype)   # data type

# matplotlib can display 2D arrays of integers as images
plot.imshow(data)

# convert list to NumPy
from_list = np.array([1,2,3])
from_list = np.array([[1,2,3],[4,5,6],[7,8,9]])

# create empty array
zeroes = np.zeros(8, 'd') # 'd' is shorthand for np.float64
zeroes = np.zeros((8,8), np.float64)

# create empty array in the shape of existing one
empty = np.zeros_like(data)

# create true empty array (memory hasn't been cleaned)
np.empty(24, 'd')

# linear spaced array
linear = np.linspace(0,1,16) # values: 0, 0.067, 0.133, ..., 0.933, 1

# plot linear
plot.plot(linear, 'o')

# NumPy version of Python's range
arange = np.arange(0, 1.5, 0.1) # values between 0 and 1.5, with step size of 0.1

# random array
rand = np.random.random(size=(8,8))         # default values between 0-1
rand_int = np.random.randint(size=(8,8))    # random integers

# plot random numbers
plot.matshow(rand)

# saving NumPy arrays
np.save('random.npy', rand)     # NumPy special file
np.savetxt('random.txt', rand)  # readable ASCII
```

### Indexing
- Unlike normal Python lists, we can use multiple indices in brackets
- Mixing slicing and indexing reduces dimensionality of the array
    - Note that fixed index is not the same as a slice of 1
    - Fixed index reduces dimensionality
    - Slice of 1 will still preserve the dimension, it'll just be value of 1
- Slices of NumPy arrays will point to the same memory
    - Changes to slices will change the original
    - Python slices are copies, so changing list slice won't change original
    - 

```Python
# assume dimensions of array is (200,100,5)

array[100,50,3]             # same as list[100][50][3]
array[-50,-50,1]            # same as [150,50,1]
array[300,100,5]            # index error
array[1,1,1] = 5            # assign values

array[50:60,70:80,0:3]      # slicing
array[50:60,:,:]            # ':' for a full slice
array[50:60,...]            # shorthand for multiple full slices
array[::20,::20,:]          # specify step size
array[20,::20,0]            # we get a vector
array[50:100,30:70,:] = 5   # slicing to change multiple values

array < 50                  # returns Boolean array indicating if value is less than 50
array[array < 120] = 0      # fancy indexing where we use an array to index an array

array2 = array.copy()       # make true copy
```

### Math
- NumPy's efficiency makes it easy to perform math on large arrays
- We can also perform math on multiple arrays
    - Generally speaking, the array shapes need to match

```Python
import math
import numpy as np
import matplotlib.pyplot as plot

# 64 equally-spaced values between 0 and 5pi
x = np.linspace(0,5*,math.pi,64)

sinx = math.sin(x)  # ERROR
sinx = np.sin(x)    # correct way to get sine
cosx = np.cos(x)    # correct way to get cosine

# plotting math functions
plot.plot(x, sinx, label="sin(x)")
plot.plot(x, cosx, label="cos(x)")
plot.plot(x, np.log(1+x), label="log(x+1)")
plot.legend()
plot.show()

# multiple arrays
y = sinx * cosx
z = cosx**2 - sinx**2
w = sinx + 1.5 # "broad casting" applies scalar to all entries

array = array[:, np.newaxis] # adds a dimension of 1

# matrix/vector operations
a = np.array[0,1,2]
b = np.array[-1,-2,-3]

a @ b                       # Python dot product
np.dot(a,b)                 # np dot product

C = np.random.randn(3,3)
C @ a                       # matrix multiplication
```

### Records and Dates
#### Record
- Records are a special type of tuple that can store info about the fields
    - Provides an attribute `dtype` containing data types of all fields
    - Contains the data type and endianness (`<` = little endian)
- Setting the `dtype` correctly is very important
    - Remember that arrays are contiguous in memory
    - Having correct data types helps NumPy to allocate memory accordingly

```Python
# let 'record' be a record of (title, date, number)
record[0]           # returns the first tuple
record[0][0]        # access title via index
record[0]['title']  # access title via field name
record['title']     # lists all titles

# create a record
myRecord = np.zeros(5, dtype=[('title','U16'), ('date','M8[s]')])
```

#### Dates
```Python
# creating datetime objects
year = np.datetime64('2024')
date = np.datetime64('2024-01-08')
time = np.datetime64('2024-01-08 15:05')
time2 = np.datetime64('2024-01-08 08:00')

# datetime operations
time < time2 # comparison
time - time2 # subtraction, results in a timedelta64 object

times = np.array([time, time2])
np.diff(times) # return time difference between each pair of neighboring times
np.arange(date, np.datetime64('2024-01-31')) # returns dates between the 2
```

## Data Processing
### Missing Values
- NumPy numerical functions often don't work if any entries are NaN
- One easy method is to replace NaN entries with the dataset's mean
- Another method is interpolating
    - Use neighboring entries to estimate value

```Python
import numpy as np

# common functions
np.mean(array)
np.max(array)
np.min(array)

# check NaN status
np.isnan(array)         # returns Boolean area of whether a value is NaN
np.sum(np.isnan(array)) # returns number of NaN entries

# ignore NaN
np.nanmin(array)
np.nanmax(array)
np.nanmean(array)

# use fancy indexing to replace NaN with average values
array['field'][np.isnan(array['field'])] = np.nanmean(array['field'])

# interpolate data
x = np.array([0,1,4,5,7,8])
y = np.array([10,5,2,7,7.5,10])

xnew = np.linspace(0,8,9)
ynew = np.interp(xnew, xdata, ydata)
```

### Smoothing
- Data often has noise
    - Lots of rapid variations in the data
    - This can hide trends in the data
- One way to smooth is to replace values with an average of its neighbors
    - In NumPy, this is called `correlate`

```Python
import numpy as np
import matplotlib.pyplot as plot

# original data has extreme peaks
x = np.array([0,0,0,0,1,0,0,0,0,0,1,0,0,0])

# add a mask
mask = np.array([0.05,0.2,0.5,0.2,0.0.5])

# new data has smoother peaks
y = np.correlate(x, mask, 'valid') # 'valid' makes sure the ends don't suddenly drop

# This function uses normalizing for the smoothing. The 'window' is what we call
# the number of neighbors to use to calculate the mask
def smooth(array, window=10, mode='valid'):
    return np.correlate(array, np.ones(window)/window, mode)
```

## Pandas
- `pandas` is very fast since it's built on NumPy
- Extends NumPy with additional useful operations
    - Changes arrays to be more like tables with labels
    - Better indexing
    - More data formats
    - Handles missing data
    - DB operations
    - Plotting

### DataFrame and Series
- The 2 main data structures are DataFrame and Series
- DataFrame is like a table
    - Has rows and columns
    - Note that row number is not necessarily a 0-based index for the row
        - Could be like a SSN or employer ID
- Series is like a single column in the DataFrame
    - Also has an index
    - 2 Series with overlapping indices can be combined easily
- Pandas can import DataFrames from a variety of different files
    - CSV
    - JSON
    - HTML
    - SQL
    - ASCII
    - ... and more
- Each type's function has the naming format of:
    - Reading: `read_[format]`
    - Writing: `to_[format]`
    - Ex: `read_csv` & `to_csv`

```Python
import pandas as pd
"""nobels.csv preview:
1901	Chemistry	Jacobus Henricus van 't Hoff
1901	Literature	Sully Prudhomme
1901	Medicine	Emil Adolf von Behring
1901	Peace	    FrÃ©dÃ©ric Passy
1901	Peace	    Henry Dunant
"""

# if CSV file doesn't contain headers, add your own
columnNames = ['year','discipline','nobelist']
nobels = pd.read_csv("nobels.csv", names=columnNames)

nobels.info()       # get info about the data
nobels.head()       # get first 5 rows
nobels.tail()       # get last 5 rows

len(nobels)         # total number of entries
nobels.columns      # lists column names
nobels.dtypes       # lists data type for each column
nobels.index        # lists info about the row indexing (default is 0-based)

nobels['year']                                  # access column with brackets
nobels.discipline                               # access column with dot notation
nobels.discipline.values                        # get baseline NumPy array representation
nobels.discipline.unique()                      # get unique values
nobels.nobelist.value_counts()                  # count frequency of each unique entry
nobels[nobes.discipline == 'Physics']           # fancy indexing to filter DataFrame
nobels.query('discipline == "Chemistry"')       # built-in fast query
nobels[nobels.nobelist.str.contains('Curie')]   # partial query

# create DataFrame from NumPy array
discography = np.load('discography.npy')
discord_df = pd.DataFrame(disco)

# create DataFrame from dict
entry1 = ["name": "Tikki", "age": 17]
entry2 = ["name": "Mike", "age": 71]
entries = [entry1, entry2]
dict_df = pd.DataFrame(entries)

# create DataFrame from tuples
entry1 = ("Name1", 5)
entry2 = ("Name2", 6)
tuple_df = pd.DataFrame(
    [entry1, entry2],
    columns=['name', 'age']
)
```

### Indexing
- Some things to note about using `set_index`
    - Will use the column values as the index
    - Creates a new DataFrame, won't change original
    - Multiple indices are allowed (feature, not bug)
    - Indexing that index will return all corresponding entries
- Multi indexing is interesting
    - Adds layers (or dimensions) to each record
    - Think about merging cells in Excel

```Python
import pandas as pd

# if CSV file doesn't contain headers, add your own
columnNames = ['year','discipline','nobelist']
nobels = pd.read_csv("nobels.csv", names=columnNames)

nobels = nobels.set_index("year")                # changes indexes to column values
nobels.loc[1901]                                 # selects all records with index 1901
nobels.loc[1901, 'nobelist']                     # selects column name to get Series
nobels.loc[1914:1918]                            # slicing (inclusive of both ends)
nobels.iloc[0:10]                                # index-loc, uses NumPy indexing

nobels = nobels.set_index(['year','discipline']) # multi-indexing
nobels.index                                     # returns every possible combination of year/disc
nobels.index.get_level_values(0)                 # returns years as first layer
nobels.index.get_level_values(1)                 # returns years as second layer
nobels.loc[(2017, 'Physics')]                    # use tuples for indexing

# multi-index slicing
nobels.loc[(slice(1901,1910),'Chemistry'), :]
nobels.loc[(slice(None), ['Chemistry','Phyiscs']), :]

# alternate way with criteria
nobels[(nobels.year >= 1901) & (nobels.year <= 1910) & (nobels.disciopline == 'Chemistry')]

# alternate way with query
nobels.query('year >= 1901 and year <= 1910 and discipline == "Chemistry"')
```

### Plotting
```Python
import pandas as pd
import matplotlib.pyplot as plot
import numpy as np

# country data like life expectancy, fertility, and gdp
gapminder = pd.read_csv("gapminder.csv")

gapminder['log_gdp_per_day'] = np.log10(gapminder['gdp_per_capita'] / 365.25)

gapminder_by_year = gapminder.set_index('year').sort_index()
gapmindeR_by_country = gapminder.set_index('country').set_index()

# scatter
gapminder_by_year.loc[1960].plot.scatter('log_gdp_per_day','life_expectancy')
```

### Misc
```Python
import pandas as pd

both = pd.concat(df1, df2)    # combines 2 DataFrames into 1
both = both.assign(year=2020) # adds a column with the specified value for all
```
