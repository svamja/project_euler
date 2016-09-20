import time

start_time = time.time()

divisor = 10000000000

mod_sum = 0

for n in xrange(1, 1000):
    mod_power = 1
    for k in xrange(0, n):
        mod_power *= n
        mod_power %= divisor
    mod_sum += mod_power
    mod_sum %= divisor

print mod_sum

end_time = time.time()
print "Time: ", round(end_time - start_time, 3)

