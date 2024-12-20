"""My Solution"""
import random
import time
def waiting_game():
    targetTime = random.randint(2, 4)
    input(f"Your target is {targetTime}s. Press ENTER to start: ")
    startTime = time.time()
    input(f"Press ENTER after {targetTime}s: ")
    endTime = time.time()
    elapsed = endTime - startTime
    
    if elapsed == targetTime:
        print(f"You are a legend, you got exactly {targetTime}s!")
    else:
        print(f"Elapsed time: {round(elapsed, 3)}s")
        diff = round(elapsed - targetTime, 3)
        if diff < 0:
            print(f"{-diff} too fast")
        else:
            print(f"{diff} too slow")

if __name__ == "__main__":
    waiting_game()

"""Instructor's Solution"""
import random
import time

def waiting_game():
    target = random.randint(2, 4)  # target seconds to wait
    print(f'\nYour target time is {target} seconds')

    input(' ---Press Enter to Begin--- ')
    start = time.perf_counter()

    input(f'\n...Press Enter again after {target} seconds...')
    elapsed = time.perf_counter() - start

    print(f'\nElapsed time: {elapsed :.3f} seconds')
    if elapsed == target:
        print('(Unbelievable! Perfect timing!)')
    elif elapsed < target:
        print(f'({target - elapsed :.3f} seconds too fast)')
    else:
        print(f'({elapsed - target :.3f} seconds too slow)')

"""Thoughts:
Pretty much the same logic. He used perf_counter, which I learned is a lot more
precise when it comes to counting short durations.
"""
