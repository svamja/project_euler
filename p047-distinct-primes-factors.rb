start_time = Time.now

# START #

require './primes.rb'

# Approach 1 - Takes 9 seconds to reach 30K
# segment = []

# (11..10_000).each do |number|
#     factors, factors_exp = factorize(number)
#     factors_count = factors.size
#     if(factors_count == 4)
#         segment.push(number)
#         if(segment.size == 4)
#             break
#         end
#     else
#         segment = []
#     end
# end

# puts segment[0]

# segment.each do |number|
#     factors, factors_exp = factorize(number)
#     puts number
#     puts factors.join('x')
#     puts factors_exp.join(':')
# end


# Approach 2

# Assume at least one of the numbers has all 4 prime factors below 1000

# seed_primes(100)
# puts $divisor_primes.join(':')
# last_prime = $divisor_primes[-1]
# multipliers = []
# $divisor_primes.each do |prime|
#     multiplier = prime
#     while true
#         break if multiplier > last_prime
#         multipliers.push multiplier
#         multiplier *= prime
#     end
# end

# multipliers.sort!

# puts multipliers.join(':')
# puts multipliers.size

# Approach 3
# One of the number if multiple of 4
# Go through all the multiples of 4s

seed_primes(1000)

segment = []

(12 .. 400_000).step(4) do |number|
    factors_count = factors_count(number)
    next if(factors_count != 4)
    segment = []
    segment.push number
    i = 1
    while factors_count(number - i) == 4
        segment.unshift(number - i)
        i += 1
    end
    i = 1
    while factors_count(number + i) == 4
        segment.push(number + i)
        i += 1
    end

    if segment.size == 4
        puts segment.join(':')
        break
    end
end

segment.each do |number|
    factors, factors_exp = factorize(number)
    puts number
    puts factors.join('x')
    puts factors_exp.join(':')
end



# END #

end_time = Time.now
diff_time = end_time - start_time

puts
puts "TECHNICAL"
puts
puts "Start time: #{start_time}"
puts "End time: #{end_time}"
puts "elaplsed time: #{diff_time}"

