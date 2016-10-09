import time
start_time = time.time()
import sys

sieve_size = int(sys.argv[1])

# solution by user ne0
# it is really beautiful, and also it is nearly as fast as what i tried

print sieve_size - 1

sieve = [ 0 ] * sieve_size

for i in xrange(2, sieve_size):
    sieve[i] = i

for i in xrange(2, sieve_size):
    if sieve[i] == i:
        for j in xrange(i, sieve_size, i):
            sieve[j] *= (i - 1)
            sieve[j] /= i

print sum(sieve)

end_time = time.time()
print "Time: ", round(end_time - start_time, 3)

