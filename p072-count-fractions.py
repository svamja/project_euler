import time
start_time = time.time()

import euler
import sys

def get_factor_sieve(sieve_size):
    sieve = [0] * sieve_size
    for n in xrange(2, sieve_size):
        if sieve[n] == 0:
            for i in xrange(n*n, sieve_size, n):
                if sieve[i] == 0:
                    sieve[i] = n
    return sieve


n = int(sys.argv[1])

sieve = get_factor_sieve(n)

# print sieve

def make_totient_sieve():
    global sieve
    for i in xrange(2, len(sieve)):
        if sieve[i] == 0:
            sieve[i] = i - 1
        else:
            power = -1
            num = i
            while num % sieve[i] == 0:
                power += 1
                num /= sieve[i]
            sieve[i] = (sieve[i] ** power)*(sieve[i] - 1)
            if num > 1:
                sieve[i] *= sieve[num]

make_totient_sieve()

print sum(sieve)

end_time = time.time()
print "Time: ", round(end_time - start_time, 3)

