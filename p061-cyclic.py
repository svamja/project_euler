import time
start_time = time.time()

# Create Array of Figurates of Four Digits

figurates = [ [] ] * 9
figurates[3] = [ n*(n+1)/2 for n in xrange(1,200) ]
figurates[4] = [ n*n for n in xrange(1,100) ]
figurates[5] = [ n*(3*n - 1)/2 for n in xrange(1,100) ]
figurates[6] = [ n*(2*n - 1) for n in xrange(1,100) ]
figurates[7] = [ n*(5*n -3)/2 for n in xrange(1,100) ]
figurates[8] = [ n*(3*n -2) for n in xrange(1,100) ]

four_digit_filter = lambda x: x >= 1000 and x <= 9999

for n in xrange(3, 9):
    figurates[n] = filter(four_digit_filter, figurates[n])


# Prepare

all_sets = set([3, 4, 5, 6, 7, 8])
iteration_count = 0
solutions = 0

# Try a number out of current set of figurates that "links" with previous set of numbers
# ie, last nums suffix = current set's num prefix
# if this set happens to be the last one, check it also matches with first one
# otherwise, just push current matching numbers to sets and call this function again.

def try_numbers(prev_sets, prev_numbers, current_set):

    global all_sets, iteration_count, solutions

    iteration_count += 1
    if iteration_count > 100000:
        print "stack overflow"
        quit()

    right_sets = all_sets - set([current_set]) - set(prev_sets)
    current_nums = []
    if len(prev_numbers) > 0:
        left_num = prev_numbers[-1]
        curr_prefix = left_num % 100
        for num in figurates[current_set]:
            if num / 100 == curr_prefix:
                current_nums.append(num)
    else:
        current_nums = figurates[current_set]
    if len(current_nums) == 0:
        return []

    if len(right_sets) == 0:
        for candidate_num in current_nums:
            candidate_sets = prev_sets[:]
            candidate_sets.append(current_set)
            candidate_nums = prev_numbers[:]
            candidate_nums.append(candidate_num)
            last_suffix = candidate_nums[-1] % 100
            first_prefix = candidate_nums[0] / 100
            if last_suffix == first_prefix:
                solutions += 1
                print sum(candidate_nums)


    for current_num in current_nums:
        for next_set in right_sets:
            next_prev_sets = prev_sets[:]
            next_prev_sets.append(current_set)
            next_prev_numbers = prev_numbers[:]
            next_prev_numbers.append(current_num)
            try_numbers(next_prev_sets, next_prev_numbers, next_set)


# first call starting with set of 8, there are no prev sets yet
try_numbers([], [], 8)

print "number of solutions found: ", solutions
print "number of iterations: ", iteration_count


end_time = time.time()
print "Time: ", round(end_time - start_time, 6)



