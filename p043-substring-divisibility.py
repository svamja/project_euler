import euler
import time

start_time = time.time()

# 10 Digits

def has_uniq_digits(number):
    digits = euler.num_to_digits(number)
    return len(digits) == len(set(digits))

# Last 3 digits divisible by 17

primes = [ 17, 13, 11, 7, 5, 3, 2 ]
lists = []

for prime in primes:
    current_list = []
    for i in xrange(9/prime - 1, 1001/prime + 1):
        prime_multiple = i*prime
        if prime_multiple < 10 or prime_multiple > 999: continue
        current_list.append(prime_multiple)
    lists.append(current_list)

# build trailer

trailers = lists[0]

for trailer_len in range(3, 9):
    right_subs = trailers
    trailers = []
    left_index = trailer_len - 2

    for right_sub in right_subs:
        common_sub = right_sub/euler.powers_10[trailer_len - 2]
        for left_sub in lists[left_index]:
            if left_sub % 100 == common_sub:
                combined_number =  (left_sub/100)*(euler.powers_10[trailer_len]) + right_sub
                trailers.append(combined_number)
    for num in trailers[:]:
        if not has_uniq_digits(num):
            trailers.remove(num)
    print trailers

# attach leading digits

answer_numbers = []

for trailer in trailers:
    digits = euler.num_to_digits(trailer)
    if len(digits) == 8:
        # attach 0 at the start
        digits.insert(0, 0)
        if len(digits) != len(set(digits)):
            continue
    # get remaining digit
    sorted_digits = digits[:]
    sorted_digits.sort()
    for i in xrange(0, 8):
        if sorted_digits[i + 1] - sorted_digits[i] > 1:
            missing_digit = sorted_digits[i] + 1
            break
    digits.insert(0, missing_digit)
    answer_numbers.append(euler.digits_to_num(digits))

print answer_numbers

answer_sum = sum(answer_numbers)

print answer_sum


end_time = time.time()
print "Time: ", round(end_time - start_time, 3)

