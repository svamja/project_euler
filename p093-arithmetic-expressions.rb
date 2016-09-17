# PROBLEM STATEMENT

# By using each of the digits from the set, {1, 2, 3, 4}, exactly once, and making use of the four arithmetic operations (+, −, *, /) and brackets/parentheses, it is possible to form different positive integer targets.

# For example,

# 8 = (4 * (1 + 3)) / 2
# 14 = 4 * (3 + 1 / 2)
# 19 = 4 * (2 + 3) − 1
# 36 = 3 * 4 * (2 + 1)

# Note that concatenations of the digits, like 12 + 34, are not allowed.

# Using the set, {1, 2, 3, 4}, it is possible to obtain thirty-one different target numbers of which 36 is the maximum, and each of the numbers 1 to 28 can be obtained before encountering the first non-expressible number.

# Find the set of four distinct digits, a < b < c < d, for which the longest set of consecutive positive integers, 1 to n, can be obtained, giving your answer as a string: abcd.

# Approach 


start_time = Time.now

# PROGRAM START #

require './combinator.rb'

digits = (1..4).to_a
$operators = [ :+, :-, :*, :/ ]

def rec_results(left_digit, right_digits, &block)
    if left_digit == -1
        size = right_digits.size
        (0..size-1).each do |i|
            new_left_digit = right_digits[i]
            new_right_digits = right_digits.dup
            new_right_digits.slice!(i)
            rec_results(new_left_digit, new_right_digits, &block)
        end
        return
    end

    if right_digits.size == 1
        $operators.each do |operator|
            yield left_digit.to_f.send(operator, right_digits[0])
        end
        return
    end

    size = right_digits.size
    (0..size-1).each do |i|
        first_digit = right_digits[i]
        new_right_digits = right_digits.dup
        new_right_digits.slice!(i)
        $operators.each do |operator|
            new_left_digit = left_digit.to_f.send(operator, first_digit)
            rec_results(new_left_digit, new_right_digits, &block)
        end
    end

end

# integers = []

# rec_results(-1, [1, 2, 3, 4]) do |result|
#     if result > 0 && result % 1 == 0
#         integers.push result.to_i
#     end
# end

# integers.sort!
# integers.uniq!
# p integers

max_series = 0

rec_combinations([], [1, 2, 3, 4, 5, 6, 7, 8, 9], 4) do |digits|
    integers = []
    rec_results(-1, digits) do |result|
        if result > 0 && result % 1 == 0
            integers.push result.to_i
        end
    end
    integers.sort!
    integers.uniq!
    next if integers[0] != 1
    i = 1
    while i < integers.size and integers[i] - integers[i-1] == 1
        i += 1
    end
    if i > max_series
        p digits
        puts i
        max_series = i
    end
end

# PROGRAM END #

end_time = Time.now
diff_time = end_time - start_time

puts
puts "TECHNICAL"
puts
puts "Start time: #{start_time}"
puts "End time: #{end_time}"
puts "elapsed time: #{diff_time}"

