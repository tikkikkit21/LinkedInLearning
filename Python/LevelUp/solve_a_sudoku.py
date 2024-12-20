"""My Solution"""

"""Instructor's Solution"""
from itertools import product

def solve_sudoku(puzzle):
    for (row, col) in product(range(0, 9), repeat=2):
        if puzzle[row][col] == 0:  # find an unassigned cell
            for num in range(1, 10):
                allowed = True  # check if num is allowed in row/col/box
                for i in range(0, 9):
                    if num in (puzzle[i][col], puzzle[row][i]):
                        allowed = False
                        break  # not allowed in row or col
                for (i, j) in product(range(0, 3), repeat=2):
                    if puzzle[row - row % 3 + i][col - col % 3 + j] == num:
                        allowed = False
                        break  # not allowed in box
                if allowed:
                    puzzle[row][col] = num
                    if trial := solve_sudoku(puzzle):
                        return trial
                    puzzle[row][col] = 0
            return False  # could not place a number in this cell
    return puzzle

"""Thoughts:
Instructor used a back tracking approach (DFS) to brute force it
"""
