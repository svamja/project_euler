import time
start_time = time.time()

import euler

prime_sieve = euler.get_prime_sieve(100000)

end_time = time.time()
print "Time: ", round(end_time - start_time, 8)

