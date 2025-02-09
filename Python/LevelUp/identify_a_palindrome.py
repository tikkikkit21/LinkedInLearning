"""My Solution"""
def is_palindrome(sentence: str):
    sentence = sentence.replace(" ", "").upper()
    i = 0
    j = len(sentence) - 1
    while i < j:
        if sentence[i] == sentence[j]:
            i += 1
            j -= 1
        else:
            return False
    return True

"""Instructor's Solution"""
import re
def is_palindrome_solution(phrase):
    forwards = ''.join(re.findall(r'[a-z]+', phrase.lower()))
    backwards = forwards[::-1]
    return forwards == backwards

"""Thoughts:
I assumed that it was given that the phrase only contained a-z characters so I
didn't bother only parsing the letters. I also am not familiar with the ::
operator, but I can see how much easier it makes the solution.
"""
