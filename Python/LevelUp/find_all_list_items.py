"""My Solution"""
# I was very stuck on this problem and didn't know where to start

"""Instructor's Solution"""
def index_all(search_list, item):
    index_list = []
    for index, value in enumerate(search_list):
        if value == item:
            index_list.append([index])
        elif isinstance(search_list[index], list):
            for i in index_all(search_list[index], item):
                index_list.append([index] + i)
    return index_list

"""Thoughts:
This whole time, I was thinking about how to do it iteratively when I should've
also considered recursion.
"""
