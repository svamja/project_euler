import euler

# check 9 digit pandigital primes .. none found. digits add up to 45!
# check 8 digit pandigital primes .. none found. digits add up to 36!
# check 7 digit pandigital primes

def get_pandigial_prime():
    for number in xrange(9999999, 1111111, -2):

        if not euler.is_prime_candidate(number): continue
        if not euler.is_n_pandigital(number, 7): continue
        if euler.is_really_prime(number):
            return number

print get_pandigial_prime()
