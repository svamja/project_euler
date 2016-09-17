# PROBLEM STATEMENT

# It is possible to show that the square root of two can be expressed as an infinite continued fraction.

# √ 2 = 1 + 1/(2 + 1/(2 + 1/(2 + ... ))) = 1.414213...

# By expanding this for the first four iterations, we get:

# 1 + 1/2 = 3/2 = 1.5
# 1 + 1/(2 + 1/2) = 7/5 = 1.4
# 1 + 1/(2 + 1/(2 + 1/2)) = 17/12 = 1.41666...
# 1 + 1/(2 + 1/(2 + 1/(2 + 1/2))) = 41/29 = 1.41379...

# The next three expansions are 99/70, 239/169, and 577/408, but the eighth expansion, 1393/985, is the first example where the number of digits in the numerator exceeds the number of digits in the denominator.
# In the first one-thousand expansions, how many fractions contain a numerator with more digits than denominator?

# Approach

# The series is y/x  ->  y+2x / y + x

start_time = Time.now

# PROGRAM START #

x = 2
y = 3
count = 0
(1..1000).each do |n|
    y_count = y.to_s.split('').size
    x_count = x.to_s.split('').size
    if y_count > x_count
        count += 1
        puts "#{n} : #{y} / #{x}"
    end
    x1 = x + y
    y1 = x1 + x
    x = x1
    y = y1
end

puts count
# PROGRAM END #

end_time = Time.now
diff_time = end_time - start_time

puts
puts "TECHNICAL"
puts
puts "Start time: #{start_time}"
puts "End time: #{end_time}"
puts "elapsed time: #{diff_time}"

