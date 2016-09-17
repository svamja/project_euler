# PROBLEM STATEMENT

# It can be seen that the number, 125874, and its double, 251748, contain exactly the same digits, but in a different order.
# Find the smallest positive integer, x, such that 2x, 3x, 4x, 5x, and 6x, contain the same digits.


# Approach

# Find the 6x number, lets say y
# y/6 = x 
# both has same number of digits, so the first digit must be 6,7,8 or 9
# since there are 6 different numbers made up of these digits, this is at least 6 digit number

start_time = Time.now

# PROGRAM START #

n = 100_000
iteration_count = 0
last_number = 0
digit_count = 6
next_stop = (1_000_000/6).to_i + 1

while true

    n += 1
    iteration_count += 1
    break if(iteration_count > 100_000)

    if n > next_stop
        # increase number of digits
        n = 10 ** digit_count
        digit_count += 1
        next_stop = (10 ** digit_count / 6).to_i + 1
        next
    end
    n_digits = n.to_s.split('')
    found = true
    6.downto(2) do |multiplier|
        nm = n*multiplier
        nm_digits = nm.to_s.split('')
        common_digits = n_digits & nm_digits
        if common_digits.size != digit_count
            found = false
            break
        end
    end
    if found

        puts "FOUND"
        break
    end
end

puts "number of iterations: #{iteration_count}"
puts "#{n} : #{n*3} : #{n*4} : #{n*5} : #{n*6}"

# PROGRAM END #

end_time = Time.now
diff_time = end_time - start_time

puts
puts "TECHNICAL"
puts
puts "Start time: #{start_time}"
puts "End time: #{end_time}"
puts "elapsed time: #{diff_time}"

