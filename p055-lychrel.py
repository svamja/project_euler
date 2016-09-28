import time
start_time = time.time()


def reverse(num):
    rev = 0
    while num:
        rev *= 10
        d = num % 10
        rev += d
        num /= 10
    return rev


def lychrel_cycles(num):
    rev = reverse(num)
    for i in xrange(0, 50):
        sum = num + rev
        num = sum
        rev = reverse(num)
        if rev == num:
            return i
    return 1000

lychrel_numbers = 0
for num in xrange(1, 10000):
    cycles = lychrel_cycles(num)
    if cycles > 100:
        lychrel_numbers += 1

print lychrel_numbers

# print lychrel_cycles(10677)


end_time = time.time()
print "Time: ", round(end_time - start_time, 3)

