import time
start_time = time.time()

import euler;

upper_limit = 1000000
primes = euler.get_primes(upper_limit)

print "size of primes", len(primes)

product = 1

for prime in primes:
    product *= prime
    if product > upper_limit:
        break
    totient = len(filter(lambda x: x > prime and x < product, primes)) + 1
    print prime, product, totient, product/totient

end_time = time.time()
print "Time: ", round(end_time - start_time, 3)

