"""My Solution"""
import time
def schedule_function(expiry, function, *args):
    while time.time() < expiry:
        time.sleep(1)
    function(*args)

"""Instructor's Solution"""
import sched
def schedule_function_solution(event_time, function, *args):
    s = sched.scheduler(time.time, time.sleep)
    s.enterabs(event_time, 1, function, argument=args)
    print(f'{function.__name__}() scheduled for {time.asctime(time.localtime(event_time))}')
    s.run()

schedule_function_solution(time.time() + 1, print, 'howdy')

"""Thoughts:
He used a scheduler whereas I used native sleep. Scheduler has better config 
options and can also be non-blocking.
"""
