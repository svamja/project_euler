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
    # print n, figurate_lens[n]
    # print figurates[n]
    # print 

all_sets = set([3, 4, 5, 6, 7, 8])
iteration_count = 0
candidates = 0
solutions = 0

def try_numbers(prev_sets, prev_numbers, current_set):

    global all_sets, iteration_count, candidates, solutions

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
        candidates += len(current_nums)
        for candidate_num in current_nums:
            candidate_sets = prev_sets[:]
            candidate_sets.append(current_set)
            candidate_nums = prev_numbers[:]
            candidate_nums.append(candidate_num)
            # print candidate_nums
            last_suffix = candidate_nums[-1] % 100
            first_prefix = candidate_nums[0] / 100
            if last_suffix == first_prefix:
                solutions += 1
                print "THATS THE SOLUTION"
                print candidate_nums
                print candidate_sets
                print sum(candidate_nums)


    for current_num in current_nums:
        for next_set in right_sets:
            next_prev_sets = prev_sets[:]
            next_prev_sets.append(current_set)
            next_prev_numbers = prev_numbers[:]
            next_prev_numbers.append(current_num)
            try_numbers(next_prev_sets, next_prev_numbers, next_set)


try_numbers([], [], 8)

print iteration_count
print candidates
print solutions


end_time = time.time()
print "Time: ", round(end_time - start_time, 3)



