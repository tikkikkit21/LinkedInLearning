"""My Solution"""
def sort_words(sentence: str):
    wordList = sentence.strip().split(" ")
    sortedWords = sorted(wordList, key=str.casefold)
    return " ".join(sortedWords)

"""Instructor's Solution"""
def sort_words_solution(words):
    return ' '.join(sorted(words.split(), key=str.casefold))

"""Thoughts:
Our solutions are nearly identical, he just made everything one line. However, I
noticed that he didn't pass any argument into split(). After some research,
apparently the default action for split() with no arguments is to split for any
whitespace, which is good to know.
"""

"""Alternate Instructor's Solution"""
def sort_words_solution2(input):
    words = input.split()
    words = [w.lower() + w for w in words]
    words.sort()
    words = [w[len(w)//2:] for w in words]
    return ' '.join(words)

"""Thoughts:
This was a very creative and uniquer approach. The idea is to add the lowercased
word to the front of the original, sort like that, and then splice out the back
half for the output.
"""
