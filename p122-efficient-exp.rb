# PROBLEM STATEMENT

# The most naive way of computing n15 requires fourteen multiplications:

# n × n × ... × n = n15

# But using a "binary" method you can compute it in six multiplications:

# n × n = n2
# n2 × n2 = n4
# n4 × n4 = n8
# n8 × n4 = n12
# n12 × n2 = n14
# n14 × n = n15

# However it is yet possible to compute it in only five multiplications:

# n × n = n2
# n2 × n = n3
# n3 × n3 = n6
# n6 × n6 = n12
# n12 × n3 = n15

# We shall define m(k) to be the minimum number of multiplications to compute nk; for example m(15) = 5.

# For 1 ≤ k ≤ 200, find ∑ m(k).


start_time = Time.now

# PROGRAM START #


min_steps = {}
min_steps[2] = 1

last_sets = [ { 2 => 1 } ]

(2..6).each do |step|
    puts "step #{step}"
    new_sets = []
    last_sets.each do |set|
        numbers = set.keys
        # new_numbers = []
        numbers.each do |number|
            # new_numbers.push number + 1
            new_number = number + 1
            if !set[new_number]
                new_set = set.dup
                # new_set[new_number] = [number, 1]
                new_set[new_number] = 1
                new_sets.push new_set
            end
            if !min_steps[new_number]
                min_steps[new_number] = step
            end
        end
        numbers.each do |number1|
            numbers.each do |number2|
                new_number = number1 + number2
                if !set[new_number]
                    new_set = set.dup
                    # new_set[new_number] = [number1, number2]
                    new_set[new_number] = 1
                    new_sets.push new_set
                end
                if !min_steps[new_number]
                    min_steps[new_number] = step
                end
            end
        end
    end

    # clean up duplicate sets
    set_numbers = []
    new_sets.delete_if do |set|
        numbers = set.keys.sort.join(':')
        if set_numbers.include? numbers
            true
        else
            set_numbers.push numbers
            false
        end
    end

    puts "set size: #{new_sets.size}"

    last_sets = new_sets

end

p min_steps.to_a.sort

# Approach 2 

min_steps = { 2 => 1, 3 => 2, 4 => 2 }

(5..50).each do |num|
    n_min = 999
    min_steps.keys.sort.each do |divisor|
        # puts "divisor: #{divisor}"
        next if divisor%2 == 0 && divisor > 3
        break if divisor > num/2 && num > 5
        n = num
        div_add = min_steps[divisor]
        steps = 0
        while n > 1
            # puts "n : #{n}"
            if min_steps[n]
                # puts "found lying around"
                steps += min_steps[n]
                break
            end
            if n%divisor != 0
                # puts "not divisible: "
                if n%divisor == 1
                    steps += 1
                else
                    steps += min_steps[n%divisor]
                end
            end
            steps += min_steps[divisor]
            n /= divisor
        end
        # puts "steps : #{steps}"
        if steps < n_min
            n_min = steps
        end
    end
    min_steps[num] = n_min
end

puts
p min_steps.to_a.sort

# PROGRAM END #

end_time = Time.now
diff_time = end_time - start_time

puts
puts "TECHNICAL"
puts
puts "Start time: #{start_time}"
puts "End time: #{end_time}"
puts "elapsed time: #{diff_time}"

