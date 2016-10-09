import time
start_time = time.time()

import euler

factor_sieve = [ [] ] * 12001

for i in xrange(1, 12001):
    factor_sieve[i] = euler.get_factors_without_powers(i)

def is_relative_prime(a, b):
    global factor_sieve
    a_factors = factor_sieve[a]
    b_factors = factor_sieve[b]
    for a_factor in a_factors:
        if a_factor in b_factors:
            return False
    return True


fraction_count = 0

for denominator in xrange(4, 12001):
    lower = denominator/3
    lower += 1
    upper = denominator/2
    if denominator % 2 != 0:
        upper += 1
    for numerator in xrange(lower, upper):
        is_fraction = is_relative_prime(numerator, denominator)
        if is_fraction:
            fraction_count += 1

print fraction_count

end_time = time.time()
print "Time: ", round(end_time - start_time, 3)

