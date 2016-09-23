import time
start_time = time.time()

import euler


for digits_to_replace in xrange(1, 6):
    print "Digits to replace:", digits_to_replace
    for base_sum in xrange(0, 10):
        non_divisibles = 0
        for d in xrange(0, 10):
            digit_sum = d * digits_to_replace
            num_sum = base_sum + digit_sum
            mod_3 = num_sum % 3
            if mod_3 != 0:
                non_divisibles += 1
        print "non divisibles for ", base_sum, "=", non_divisibles


FAMILY_SIZE = 8

def is_prime_family(start_num, multiplier):
    family_size = 0
    for num in xrange(start_num, start_num + multiplier*9 + 1, multiplier):
        # print "checking", num
        if euler.is_really_prime(num):
            family_size += 1
    if family_size >= FAMILY_SIZE:
        return True
    return False

# D***D, DD***D
for d1 in xrange(0,10):
    for d2 in [ 1, 3, 7, 9]:
        if( (d1+d2) % 3 == 0):
            continue;
        prime_candidates = 0
        for d in xrange(0, 9):
            num = d1 * 10000 + d*1110 +     d2
            if euler.is_prime_candidate(num):
                prime_candidates += 1
        if prime_candidates >= FAMILY_SIZE:
            start_num = d1 * 10000 + 0*1110 + d2
            print "may be ", start_num, ":", prime_candidates
            if is_prime_family(start_num, 1110):
                print "Yes, it is"

# D*D**D pattern
d_multiple = 10110
for d1 in xrange(0,10):
    for d2 in xrange(0,10):
        for d3 in [ 1, 3, 7, 9]:
            if( (d1+d2+d3) % 3 == 0):
                continue;
            prime_candidates = 0
            for d in xrange(0, 9):
                num = d1 * 100000 + d*d_multiple + d2*1000 + d3
                if euler.is_prime_candidate(num):
                    prime_candidates += 1
            if prime_candidates >= FAMILY_SIZE:
                start_num = d1 * 100000 + d2*1000 + d3
                print "may be ", start_num, ":", prime_candidates
                if is_prime_family(start_num, d_multiple):
                    print "Yes, it is", start_num

# D**D*D pattern
d_multiple = 11010
for d1 in xrange(0,10):
    for d2 in xrange(0,10):
        for d3 in [ 1, 3, 7, 9]:
            if( (d1+d2+d3) % 3 == 0):
                continue;
            prime_candidates = 0
            for d in xrange(0, 9):
                num = d1 * 100000 + d*d_multiple + d2*100 + d3
                if euler.is_prime_candidate(num):
                    prime_candidates += 1
            if prime_candidates >= FAMILY_SIZE:
                start_num = d1 * 100000 + d2*100 + d3
                print "may be ", start_num, ":", prime_candidates
                if is_prime_family(start_num, d_multiple):
                    print "Yes, it is", start_num


# D*D*D*D pattern
d_multiple = 101010
for d1 in xrange(0,10):
    for d2 in xrange(0,10):
        for d3 in xrange(0,10):
            for d4 in [ 1, 3, 7, 9]:
                if( (d1+d2+d3+d4) % 3 == 0):
                    continue;
                prime_candidates = 0
                for d in xrange(0, 9):
                    num = d1 * 1000000 + d*d_multiple + d2*10000 + d3*100 + d4
                    if euler.is_prime_candidate(num):
                        prime_candidates += 1
                if prime_candidates >= FAMILY_SIZE:
                    start_num = d1 * 1000000+ d2*10000 + d3*100 + d4
                    # print "may be ", start_num, ":", prime_candidates
                    if is_prime_family(start_num, d_multiple):
                        print "Yes, it is", start_num


start_num = 20303
multiplier = 101010
family_size = 0
for num in xrange(start_num, start_num + multiplier*9 + 1, multiplier):
    if euler.is_really_prime(num):
        print "yes", num
        family_size += 1

print family_size


end_time = time.time()
print "Time: ", round(end_time - start_time, 3)

