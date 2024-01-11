import collections

words = sorted({line.strip().lower() for line in open('words.txt', 'r')})

def signature(word):
    return ''.join(sorted(word))

words_by_sig = collections.defaultdict(set)
for word in words:
    words_by_sig[signature(word)].add(word)

anagrams_by_sig = {sig: wordset for sig, wordset in words_by_sig.items() if len(wordset) > 1}

palindromes = []
for wordset in anagrams_by_sig.values():
    for w1 in wordset:
        for w2 in wordset:
            if w1 >= w2 and w1 == w2[::-1]:
                palindromes.append((w1, w2))

print(palindromes)
