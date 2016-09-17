# PROBLEM STATEMENT

# The Fibonacci sequence is defined by the recurrence relation:
# Fn = Fn−1 + Fn−2, where F1 = 1 and F2 = 1.
# It turns out that F541, which contains 113 digits, is the first Fibonacci number for which the last nine digits are 1-9 pandigital (contain all the digits 1 to 9, but not necessarily in order). And F2749, which contains 575 digits, is the first Fibonacci number for which the first nine digits are 1-9 pandigital.
# Given that Fk is the first Fibonacci number for which the first nine digits AND the last nine digits are 1-9 pandigital, find k.

start_time = Time.now

# PROGRAM START #

n1 = 1
n2 = 1
(3..1_000_000).each do |k|
    n3 = n1 + n2
    n1 = n2
    n2 = n3
    next if k < 100_000

    # first_9 = n3.to_s[0..8].split('')
    # first_9.delete("0")
    # first_9_size = first_9.uniq.size
    # if first_9_size == 9
    #     puts "#{k} : FIRST"
    #     last_9 = n3.to_s[-9..-1].split('')
    #     last_9.delete("0")
    #     last_9_size = last_9.uniq.size
    #     if last_9_size == 9
    #         puts "#{n3.to_s.size}"
    #         puts "#{k} : BOTH"
    #         break
    #     end
    # end

    last_9 = n3 % 1_000_000_000
    digits = []
    last_9_found = true
    (0..9).each do |i|
        last_digit = last_9 % 10
        last_9 /= 10
        if digits[last_digit]
            last_9_found = false
            break
        end
        digits[last_digit] = true
    end
    if last_9_found
        puts "#{k} : LAST"
        first_9 = n3.to_s[0..8].split('')
        first_9.delete("0")
        first_9_size = first_9.uniq.size
        if first_9_size == 9
            puts "#{n3.to_s.size}"
            puts "#{k} : BOTH"
            break
        end
    end


    if k%100_000 == 0
        puts "BENCHMARK: #{k}"
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

