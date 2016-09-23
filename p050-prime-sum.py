import euler
import time

start_time = time.time()

# Build Sieve of Primes upto 10,000
SIEVE_SIZE = 1000000

prime_sieve = [ True ] * SIEVE_SIZE;
prime_sieve[0] = False
prime_sieve[1] = False


for n in xrange(2, SIEVE_SIZE):
    if prime_sieve[n]:
        for i in xrange(n+n, SIEVE_SIZE, n):
            prime_sieve[i] = False


# Get all primes
primes = [ number for number, is_prime in enumerate(prime_sieve) if is_prime  ]

primes_len = len(primes)

print "upper limit:", SIEVE_SIZE
print "number of primes:", primes_len
print "highest prime:", primes[primes_len-1]

# last_index = primes_len - 1
start_index = 0
end_index = 1
max_chain = 3
it_count = 0

for start_index in xrange(0, primes_len - max_chain):
    for chain_size in xrange(max_chain + 1, primes_len/2):
        it_count  += 1
        end_index = start_index + chain_size
        chain_sum = sum(primes[start_index:end_index])
        if chain_sum > SIEVE_SIZE:
            break
        if chain_sum in primes:
            max_chain = chain_size
            print "found", chain_sum

print it_count
print max_chain

end_time = time.time()
print "Time: ", round(end_time - start_time, 3)

quit()

UPPER_LIMIT = 1000

# check if number is prime for numbers upto 1 million
def is_prime(n):
    for divisor in primes:
        if n % divisor == 0: return False
        if divisor > 1000: break
    return True


# get index of prime, where consecutive sum is > 1 million

i = 0;
sum = 0

while True:
    if sum > 1000000: break
    sum += primes[i]
    i += 1

# work backwards :)

print i, primes[i], sum

while True:
    i -= 1
    sum -= primes[i]
    if is_prime(sum):
        print i, sum
    if i < 1:
        break

print i, primes[i], sum



