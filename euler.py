
# powers of 10 indexed
powers_10 = [ 10**exp for exp in xrange(0, 11) ]
# seed_divisors = [ 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 127, 131, 137, 139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199 ]
seed_divisors = [ 3, 5, 7, 11, 13, 17, 19, 23, 29 ]
seed_last = seed_divisors[-1]
prime_sieve = []

# return array of digits of a number
def num_to_digits(num):
    digits = []
    while num:
        digits.insert(0, num%10)
        num /= 10
    return digits

# convert array of digits to number
def digits_to_num(digits):
    digits_len = len(digits)
    num = 0
    for i in xrange(0, digits_len):
        num += digits[digits_len - i - 1] * powers_10[i]
    return num

# checks if a number is pandigital, ie all its digital are different and > 1
def is_pandigital(number):
    digits = get_digits(number)
    if 0 in digits: return False
    if len(digits) == len(set(digits)): return True
    return False

# checks if a number is pandigital, ie all its digital are different and > 1
def is_n_pandigital(number, number_length):
    digits = get_digits(number)
    if 0 in digits: return False
    for invalid_digit in xrange(9, number_length, -1):
        if invalid_digit in digits: return False
    if len(digits) == len(set(digits)): return True
    return False

def is_prime_candidate(number):
    global seed_divisors
    for divisor in seed_divisors:
        if number % divisor == 0: return False
    return True

def is_really_prime(number):
    upper_limit = (number ** 0.5 + 1) / 6
    n = seed_last/6
    while True:
        if number % (n*6 - 1) == 0:
            return False
        if number % (n*6 + 1) == 0:
            return False
        n += 1
        if n > upper_limit:
            break
    return True

def is_prime(number):
    if number <= seed_last:
        return number in seed_divisors
    if not is_prime_candidate(number):
        return False
    return is_really_prime(number)

def get_prime_sieve(sieve_size):
    prime_sieve = [True] * sieve_size;
    prime_sieve[0] = False
    prime_sieve[1] = False
    for n in xrange(2, sieve_size):
        if prime_sieve[n]:
            for i in xrange(n*n, sieve_size, n):
                prime_sieve[i] = False
    return prime_sieve

def get_primes(upper_limit):
    prime_sieve = get_prime_sieve(upper_limit)
    primes = [ number for number, is_prime in enumerate(prime_sieve) if is_prime  ]
    return primes




# Get all divisors, including 1 and n, of a number
def get_all_divisors(n):    
    return set(reduce(list.__add__, ([i, n//i] for i in range(1, int(n**0.5) + 1) if n % i == 0)))

cached_primes = get_primes(100)

def increase_prime_cache(upper_limit):
    global cached_primes
    for i in xrange(cached_primes[-1] + 1, upper_limit + 400):
        is_prime = True
        for prime in cached_primes:
            if i % prime == 0:
                is_prime = False
                break
        if is_prime:
            cached_primes.append(i)

# Get factors of a number, with powers
def get_factors(n):
    global cached_primes
    if cached_primes[-1]*cached_primes[-1] < n:
        increase_prime_cache(n/cached_primes[-1])
    #     cached_primes = get_primes(n/cached_primes[-1])
    factors = []
    num = n
    for prime in cached_primes:
        prime_power = 0
        while num % prime == 0:
            prime_power += 1
            num /= prime
        if prime_power > 0:
            factors.append([ prime, prime_power ])
        if num < prime:
            break
    if num > 1:
        factors.append([ num, 1 ])
    return factors

# Get factors of a number, without powers
def get_factors_without_powers(n):
    global cached_primes
    if cached_primes[-1]*cached_primes[-1] < n:
        increase_prime_cache(n/cached_primes[-1] + 1)
    factors = []
    num = n
    for prime in cached_primes:
        prime_power = 0
        while num % prime == 0:
            prime_power += 1
            num /= prime
        if prime_power > 0:
            factors.append(prime)
        if num < prime:
            break
    if num > 1:
        factors.append(num)
    return factors

def get_phi(n):
    factors = get_factors(n)
    phi = n
    for factor in factors:
        phi *= (factor[0] - 1)
        phi /= factor[0]
    return phi


