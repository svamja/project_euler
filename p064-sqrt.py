import time
start_time = time.time()

squares = [ i*i for i in xrange(2, 105) ]

odd_periods = 0

for s in xrange(2, 10001):

    if s in squares: 
        continue

    m = 0
    d = 1
    sqrt_int = int(s**0.5)
    a = sqrt_int

    seq = []
    count = 0
    for i in xrange(1, 250):
        # print m, d, a
        seq.append(a)
        if a == 2*sqrt_int:
            break
        m = d*a - m
        d = (s - m*m)/d
        a = (sqrt_int + m) / d

    period = len(seq) - 1
    if period % 2 == 1:
        odd_periods += 1

print odd_periods

end_time = time.time()
print "Time: ", round(end_time - start_time, 3)


