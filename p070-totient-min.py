import time
start_time = time.time()

import euler;
import sys;


# phi for only 2 primes, which may or may not be same
def simple_phi2(prime_factors):
    if(prime_factors[0] != prime_factors[1]):
        return (prime_factors[0] - 1) * (prime_factors[1] - 1)
    return prime_factors[0] * (prime_factors[0] - 1)


# assumption: solution is 6-digit
# assumption: solution is multiplication of two large primes
upper_limit = 10000000
prime_limit = 10000
primes = euler.get_primes(prime_limit)
prime_len = len(primes)
lower_limit = upper_limit/10

iterations = 0
candidates = []

# two prime

min_ratio = 2
solution = False

for i in xrange(-1, -prime_len, -1):
    prime_i = primes[i]
    if prime_i*prime_i < lower_limit:
        break
    for j in xrange(i, -prime_len, -1):
        prime_j = primes[j]
        num = prime_i * prime_j
        if num > upper_limit:
            continue
        if num < lower_limit:
            break
        iterations += 1
        phi = simple_phi2([ prime_i, prime_j ])
        ratio = num*1.0/phi
        if ratio > min_ratio:
            break
        num_digits = euler.num_to_digits(num)
        phi_digits = euler.num_to_digits(phi)
        num_digits.sort()
        phi_digits.sort()
        if num_digits == phi_digits:
            if ratio < min_ratio:
                solution = [ prime_i, prime_j, num, phi, ratio ]
                min_ratio = ratio


print "solution:", solution
print "answer:", solution[2]
print "iterations", iterations


end_time = time.time()
print "Time: ", round(end_time - start_time, 3)

