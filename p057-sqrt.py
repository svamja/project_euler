import time
start_time = time.time()

numerator, denominator = 3, 2

count = 0

for n in xrange(2, 1001):
    denominator_new = numerator + denominator
    numerator_new = numerator + 2*denominator


    numerator = numerator_new
    denominator = denominator_new


    if len(str(numerator)) > len(str(denominator)):
        # print n, ":", numerator, "/", denominator
        count += 1


print count

end_time = time.time()
print "Time: ", round(end_time - start_time, 3)

