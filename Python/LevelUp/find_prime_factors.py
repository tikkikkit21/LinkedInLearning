"""My Solution"""
primes = [2, 3, 5, 7, 11, 13, 17, 19, 23]
def get_prime_factors(num: int):
    factors = []
    prime_index = 0
    while num != 1:
        for i in range(prime_index, len(primes)):
            if num % primes[i] == 0:
                num /= primes[i]
                factors.append(primes[i])
                prime_index = i
                break
    return factors

"""Instructor's Solution"""
def get_prime_factors_solution(number):
    factors = []
    divisor = 2
    while divisor <= number:
        if number % divisor == 0:
            factors.append(divisor)
            number = number // divisor
        else:
            divisor += 1
    return factors

"""Thoughts:
I think that we had the same logic in mind, just implemented a little
differently. What I didn't account for is the fact that I don't have to
explicitly store the prime numbers for division, since dividing by a prime over
and over again means the composite factors are already dealt with (ex: dividing
by 2 over and over again ensures 4 won't be a considered factor).

Mine is slightly more efficient since I don't have any unecessary iterations.
However, it's limited by how many prime factors I put in my list. The
instructor's can infinitely scale, but it'll probably slow down for large
numbers where the difference between 2 prime factors is greater
"""
