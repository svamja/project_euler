
# returns digits of a number
def digits(num):
    digits = []
    while num:
        digits.insert(0, num%10)
        num /= 10
    return digits

# checks if a number has repeated digits
def has_repeats(num):
    num_digits = digits(num)
    return len(num_digits) != len(set(num_digits))

# check if number has pandigitals
def pandigital_concat(num):
    # check if all digits of product are different
    all_digits = []
    all_len = 0
    all_set_len = 0
    n = 0
    while True:
        n += 1
        all_digits += digits(n*num)
        all_len = len(all_digits)
        all_set_len = len(set(all_digits))
        if 0 in all_digits: return False
        if all_len == 9 and all_len == all_set_len: return all_digits
    return False

pandigitals = []

for num in xrange(1, 20000):
    panconcat = pandigital_concat(num)
    if panconcat:
        pandigitals.append(panconcat)

print pandigitals

print max(pandigitals)


