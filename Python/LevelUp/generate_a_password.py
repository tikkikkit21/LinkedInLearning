"""My Solution"""
import random

# load words into dictionary
wordFile = open("wordlist.txt", "r")
wordDict = {}
for line in wordFile:
    [key, value] = line.strip().split("\t")
    wordDict[key] = value

def generate_passphrase(numWords: int):
    passphrase = []
    for _ in range(numWords):
        index = generate_number()
        passphrase.append(wordDict[index])
    return " ".join(passphrase)

def generate_number():
    result = ""
    for _ in range(5):
        result += str(random.randint(1, 6))
    return result

"""Instructor's Solution"""
import secrets

def generate_passphrase(num_words, wordlist_path='diceware.wordlist.asc'):
    with open(wordlist_path, 'r', encoding='utf-8') as file:
        lines = file.readlines()[2:7778]
        word_list = [line.split()[1] for line in lines]

    words = [secrets.choice(word_list) for i in range(num_words)]
    return ' '.join(words)

# commands used in solution video for reference
if __name__ == '__main__':
    print(generate_passphrase(7))
    print(generate_passphrase(7))

"""Thoughts:
He used a different approach where he used different means for the same end. He
also accounted for the PGP Signatures, I just manually removed them. One notable
thing is he used 'secrets' module instead of 'random' to generate numbers, which
is apparently more secure and should be used when doing things like generating
passphrases.
"""
