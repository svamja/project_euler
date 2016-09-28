import time
start_time = time.time()

denominator = 1000000
numerator = denominator*3/7

right_fraction = 3.0/7.0
print right_fraction

best_fraction = 2.0/7.0
best_pair = [ 2, 7 ]

iterations = 0

while True:
    iterations += 1
    if iterations > 40000:
        break
    current_fraction = numerator*1.0/denominator
    if current_fraction >= right_fraction:
        numerator -= 1
    else:
        if current_fraction > best_fraction:
            best_fraction = current_fraction
            best_pair = [ numerator, denominator ]
            print best_pair
        denominator -= 1


end_time = time.time()
print "Time: ", round(end_time - start_time, 3)

