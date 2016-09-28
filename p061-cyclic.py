import time
start_time = time.time()

# sets of 4-digit nums

figurates = [ [] ] * 9
figurate_lens = [ 0 ] * 9


figurates[3] = [ n*(n+1)/2 for n in xrange(1,200) ]
figurates[4] = [ n*n for n in xrange(1,100) ]
figurates[5] = [ n*(3*n - 1)/2 for n in xrange(1,100) ]
figurates[6] = [ n*(2*n - 1) for n in xrange(1,100) ]
figurates[7] = [ n*(5*n -3)/2 for n in xrange(1,100) ]
figurates[8] = [ n*(3*n -2) for n in xrange(1,100) ]

four_digit_filter = lambda x: x >= 1000 and x <= 9999

for n in xrange(3, 9):
    figurates[n] = filter(four_digit_filter, figurates[n])
    figurate_lens[n] = len(figurates[n])
    print n, figurate_lens[n]
    print figurates[n]
    print 








end_time = time.time()
print "Time: ", round(end_time - start_time, 3)



