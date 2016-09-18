# A perfect number is a number for which the sum of its proper divisors is exactly equal 
# to the number. For example, the sum of the proper divisors of 28 
# would be 1 + 2 + 4 + 7 + 14 = 28, which means that 28 is a perfect number.

# A number n is called deficient if the sum of its proper divisors is less than n 
# and it is called abundant if this sum exceeds n.

# As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the smallest number 
# that can be written as the sum of two abundant numbers is 24. By mathematical analysis, 
# it can be shown that all integers greater than 28123 can be written as the sum of 
# two abundant numbers. However, this upper limit cannot be reduced any further 
# by analysis even though it is known that the greatest number that cannot be expressed 
# as the sum of two abundant numbers is less than this limit.

# Find the sum of all the positive integers which cannot be written as the 
# sum of two abundant numbers.

def factors(n):    
    return set(reduce(list.__add__, ([i, n//i] for i in range(1, int(n**0.5) + 1) if n % i == 0)))



# gather abundant numbers
abundant_numbers = [];
max_number = 28124
for num in xrange(1, max_number):
    divisors = factors(num)
    divisor_sum = sum(divisors) - num
    if divisor_sum > num:
        abundant_numbers.append(num)

# maintain bits (booleans) of numbers if they can not be written as sum of two abundant numbers
# initialize all as yes = cannot be written as sum
non_sums = [1] * max_number

# strike out numbers that can be written as sum of two abundant numbers
for i in xrange(0, len(abundant_numbers)):
    for j in xrange(i, len(abundant_numbers)):
        abundant_sum = abundant_numbers[i] + abundant_numbers[j]
        if abundant_sum >= max_number:
            break
        non_sums[abundant_sum] = 0

# print abundant_numbers
print len(abundant_numbers)
print len(non_sums)
print sum(non_sums) 

# sum these numbers
numbers_sum = 0
for num in xrange(1, len(non_sums) - 1):
    if non_sums[num]:
        numbers_sum += num

# print output
print numbers_sum


