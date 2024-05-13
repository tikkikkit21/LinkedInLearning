"""My Solution"""
import re
def count_unique(path):
    file = open(path, "r", encoding="utf-8").read()
    words = re.findall(r"[0-9a-zA-z-']+", file)
    words = [word.lower() for word in words]
    print("Total Words:", len(words))

    frequencies = {word: words.count(word) for word in words}
    freq_sorted = sorted(frequencies.items(), key=lambda item: item[1], reverse=True)

    print("20 Most Freq Words:")
    for word in freq_sorted[:20]:
        print(f"{word[0]}: {word[1]}")

"""Instructor's Solution"""
import collections
def count_words(path):
    with open(path, 'r', encoding='utf-8') as file:
        all_words = re.findall(r"[0-9a-zA-Z-']+", file.read())
        all_words = [word.upper() for word in all_words]
        print(f'\nTotal Words: {len(all_words)}')

        word_counts = collections.Counter(all_words)

        print('\nTop 20 Words:')
        for word in word_counts.most_common(20):
            print(f'{word[0]}\t{word[1]}')

"""Thoughts:
Similar idea in terms of processing the file, but different ways of finding
highest frequencies. Using the collections module was WAY faster as opposed to
using basic comprehensions.
"""
