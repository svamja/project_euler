import time
start_time = time.time()

e_list = [ 2 ]
for i in xrange(1, 35):
    e_list += [ 1, 2*i, 1 ]

prev_numerator = 1
prev_denominator = 0

numerator = 2
denominator = 1

for i in xrange(1, 101):
    new_numerator = e_list[i]*numerator + prev_numerator
    new_denominator = e_list[i]*denominator + prev_denominator
    print i, numerator, denominator
    prev_numerator, prev_denominator = numerator, denominator
    numerator, denominator = new_numerator, new_denominator


print prev_numerator
print reduce(lambda x,y: int(x) + int(y), str(prev_numerator))


end_time = time.time()
print "Time: ", round(end_time - start_time, 8)

