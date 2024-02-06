"""My Solution"""
import random
def roll_dice(*die):
    table = {}
    min = 0
    max = 0
    for dice in die:
        min += 1
        max += dice
    
    for i in range(min, max + 1):
        table[str(i)] = 0
    for _ in range(1000000):
        outcome = 0
        for dice in die:
            outcome += random.randint(1, dice)
        table[str(outcome)] += 1
    
    total = sum(table.values())
    for key in table.keys():
        table[key] = table[key] / total
    return table

"""Instructor's Solution"""
from random import randint
from collections import Counter

def roll_dice(*dice, num_trials=1_000_000):
    counts = Counter()
    for _ in range(num_trials):
        counts[sum((randint(1, sides) for sides in dice))] += 1

    print('\nOUTCOME\tPROBABILITY')
    for outcome in range(len(dice), sum(dice) + 1):
        print(f'{outcome}\t{counts[outcome] * 100 / num_trials :0.2f}%')

"""Thoughts:
His solution was a lot more compact as well as prettifying the output. I also
need to look into the for loop inside bracket notation (line 33). I've seen this
quite a few times now and it'll be good to know what it does.
"""
