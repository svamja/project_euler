import time
start_time = time.time()

ncr = [ 1, 2, 1 ]

upper_limit = 1000000

count = 0

for n in xrange(3, 101):
    ncr_new = ncr[:]
    for i in xrange(0, n - 1):
        ncr_new[i + 1] = ncr[i] + ncr[i+1]
        if ncr_new[i + 1] > upper_limit:
            count += 1
            ncr_new[i + 1] = upper_limit + 1
    ncr_new.append(1)
    ncr = ncr_new


print n, ncr

print count



end_time = time.time()
print "Time: ", round(end_time - start_time, 3)

