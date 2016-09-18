# return array of digits of a number
# this gives the digits in reverse direction.. last first
def get_digits(num):
    digits = []
    while num:
        digits.append(num%10)
        num /= 10
    return digits

# return digit at the fraction created by pasting integers together
# 0.1234567891011121314151617181920212223242526...

def digit_at(index):
    fraction_length = 0
    next_power = 10
    current_int = 0
    current_size = 1
    while True:
        current_int += 1
        if current_int == next_power:
            current_size += 1
            next_power *= 10
        fraction_length += current_size
        if fraction_length >= index:
            break
    digits = get_digits(current_int)
    return digits[fraction_length - index]


indexes = [ 10**exp for exp in xrange(0, 7) ]

digits = [ digit_at(index) for index in indexes ]

print digits

answer = 1
for digit in digits:
    answer *= digit

print answer










