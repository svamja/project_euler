import time

start_time = time.time()


square_doubles = []
odd_primes = [ 3, 5, 7 ]

for i in xrange(1, 100):
    square_doubles.append(2*i*i)

sqroot_index = 0
sqroot = 3

for num in xrange(9, 100001, 2):
    is_prime = True

    # check if prime / composite

    for odd_prime in odd_primes:
        if odd_prime > sqroot: break
        if num % odd_prime == 0:
            is_prime = False
            break

    # prime found, save it safely

    if is_prime:
        odd_primes.append(num)
        if odd_primes[sqroot_index+1]*odd_primes[sqroot_index+1] < num:
            sqroot_index += 1
            sqroot = odd_primes[sqroot_index+1]
        continue

    # composite number -> check conjecture
    match_found = False
    for square_double in square_doubles:
        num_diff = num - square_double
        if num_diff in odd_primes:
            match_found = True
            break

    if not match_found:
        print "invalid conjecture for ", num
        break


end_time = time.time()
print "Time: ", round(end_time - start_time, 3)

