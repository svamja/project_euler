
powers_10 = [ 10**exp for exp in xrange(0, 11) ]
seed_divisors = [ 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 127, 131, 137, 139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199 ]

# return array of digits of a number
def num_to_digits(num):
    digits = []
    while num:
        digits.insert(0, num%10)
        num /= 10
    return digits

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
    n = 199/6
    while True:
        if number % (n*6 - 1) == 0:
            return False
        if number % (n*6 + 1) == 0:
            return False
        n += 1
        if n > upper_limit:
            break
    return True

# Get all divisors, including 1 and n, of a number
def get_all_divisors(n):    
    return set(reduce(list.__add__, ([i, n//i] for i in range(1, int(n**0.5) + 1) if n % i == 0)))

