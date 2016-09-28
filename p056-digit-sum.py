import time
start_time = time.time()

max_sum = 0

for a in xrange(80, 100):
    for b in xrange(80, 100):
        n  = a**b
        s = str(n)
        # my first lambda!
        digit_sum = reduce( (lambda x, y: int(x) + int(y)), s )
        if digit_sum > max_sum:
            max_sum = digit_sum 

print max_sum

end_time = time.time()
print "Time: ", round(end_time - start_time, 3)

