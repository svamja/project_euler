
# returns digits of a number
def digits(num):
    digits = []
    while num:
        digits.append(num%10)
        num /= 10
    return digits

# checks if a number has repeated digits
def has_repeats(num):
    num_digits = digits(num)
    return len(num_digits) != len(set(num_digits))

# check if a product is 1 to 9 pandigital
def is_pandigital(num1, num2, product):
    # check if all digits of product are different
    product_digits = digits(product)
    # if len(product_digits) != len(set(product_digits)): return False
    # check if all digits of multipliers and products are different
    num1_digits = digits(num1)
    num2_digits = digits(num2)
    all_digits = num1_digits + num2_digits + product_digits
    all_len = len(all_digits)
    if all_len != 9: return False
    if all_len != len(set(all_digits)): return False
    if 0 in all_digits: return False
    return True


products = 0
pandigitals = []
pandigital_numbers = []

for num1 in xrange(2, 100):
    # if num1 > 10:
    #     if has_repeats(num1): continue
    for num2 in xrange(123, 10000/num1 + 1):
        # if has_repeats(num2): continue
        product = num1 * num2
        products += 1
        if is_pandigital(num1, num2, product):
            pandigitals.append([ num1, num2, product ])
            pandigital_numbers.append(product)


print pandigitals

print products
# print pandigitals
print len(pandigitals)

pandigital_set = set(pandigital_numbers)
print pandigital_set
print len(pandigital_set)

pandigital_sum = sum(pandigital_set)
print pandigital_sum


