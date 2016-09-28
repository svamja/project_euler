import time
start_time = time.time()

pow_10_upper = 1
digit_powers = [  1 ] * 10
count = 1

for n in xrange(1, 50):
    pow_10_lower = pow_10_upper
    pow_10_upper *= 10
    for digit in xrange(2, 10):
        digit_powers[digit] *= digit
        if digit_powers[digit] > pow_10_lower:
            count += 1
    if digit_powers[9] < pow_10_lower:
        print n, digit_powers[9]
        break

print count

end_time = time.time()
print "Time: ", round(end_time - start_time, 8)

