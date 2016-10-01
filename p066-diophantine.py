import time
start_time = time.time()

squares = [ i*i for i in xrange(2, 105) ]

def get_fraction(seq):
    fraction = [ 1, 0 ]
    while len(seq) > 0:
        fraction = [ seq[-1] * fraction[0] + fraction[1], fraction[0] ]
        seq.pop()
    return fraction


max_x = 0

for s in xrange(2, 1001):

    if s in squares: 
        continue

    m = 0
    d = 1
    sqrt_int = int(s**0.5)
    a = sqrt_int

    seq = []
    count = 0
    for i in xrange(1, 600):
        seq.append(a)
        if a == 2*sqrt_int:
            break
        m = d*a - m
        d = (s - m*m)/d
        a = (sqrt_int + m) / d

    period = len(seq) - 1
    orig_seq = seq[:]
    seq.pop()
    last_fraction = get_fraction(seq)
    x = last_fraction[0]
    y = last_fraction[1]
    D = s
    check = x*x - D*y*y

    if check != 1:
        seq = orig_seq[:]
        last_fraction = get_fraction(seq)
        x = last_fraction[0]
        y = last_fraction[1]
        D = s
        check = x*x - D*y*y

    if check != 1:
        seq_len = len(orig_seq)
        seq = orig_seq[:] + orig_seq[1:seq_len-1]
        last_fraction = get_fraction(seq)
        x = last_fraction[0]
        y = last_fraction[1]
        D = s
        check = x*x - D*y*y
        
    # print s, period, last_fraction, check
    if check != 1:
        print "not found", s
    if x > max_x:
        max_x = x
        print s, period, last_fraction, check


end_time = time.time()
print "Time: ", round(end_time - start_time, 3)


