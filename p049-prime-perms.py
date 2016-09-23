import euler
import time

start_time = time.time()

# Build Sieve of Primes upto 10,000
prime_sieve = [ True ] * 10000;
prime_sieve[0] = False
prime_sieve[1] = False

for n in xrange(2, 9999):
    if prime_sieve[n]:
        for i in xrange(n+n, 9999, n):
            prime_sieve[i] = False

# Get all 4 digit primes
primes = [ 1000 + number for number, is_prime in enumerate(prime_sieve[1000:9999]) if is_prime  ]


# Group primes of equal digits
prime_groups = dict()
for prime in primes:
    digits = euler.num_to_digits(prime)
    digits.sort()
    num = euler.digits_to_num(digits)
    if not num in prime_groups:
        prime_groups[num] = []
    prime_groups[num].append(prime)


# Get group of primes whose digits are same
# sort them, and then check if any 3 of them are in sequence
for group_num, group in prime_groups.items():
    group_len = len(group)
    if group_len < 3:
        continue
    group.sort()
    for i in xrange(0, group_len - 2):
        for j in xrange(i+1, group_len - 1):
            for k in xrange(j+1, group_len):
                if group[k] - group[j] == group[j] - group[i]:
                    print "found it: ", group[i], group[j], group[k]


end_time = time.time()
print "Time: ", round(end_time - start_time, 3)


