import time
start_time = time.time()

import euler
diag_count = 1
diag_primes = 0

for i in xrange(2, 50000):
    exit_number = (2*i - 3)**2
    increment = 2*i- 2
    corners = [ exit_number + increment, exit_number + 2*increment, exit_number + 3*increment ]
    prime_count = sum([ 1 for x in corners if euler.is_prime(x) ])
    side_length = i*2 - 1
    diag_primes += prime_count
    diag_count += 4
    # print i, corners, side_length, '=', prime_count
    if diag_primes*10 < diag_count:
        print i, ':', side_length, ': ', diag_primes, '/', diag_count
        print exit_number + increment
        break

end_time = time.time()
print "Time: ", round(end_time - start_time, 3)

