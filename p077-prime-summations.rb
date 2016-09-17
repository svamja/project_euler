# PROBLEM STATEMENT

# It is possible to write ten as the sum of primes in exactly five different ways:

# 7 + 3
# 5 + 5
# 5 + 3 + 2
# 3 + 3 + 2 + 2
# 2 + 2 + 2 + 2 + 2

# What is the first value which can be written as the sum of primes in over five thousand different ways?


# Approach 

start_time = Time.now

# PROGRAM START #

require './primes.rb'

# upper_bound = 10

# seed_primes(100)

# primes = $divisor_primes

# p primes

# hash = {}

# (2..upper_bound).each do |i|
#     hash[i] = []
# end

# while true
#     break if primes.size == 0
#     prime = primes.shift
#     break if prime > upper_bound
#     hash[prime].push [prime]
#     puts "prime: #{prime}"
#     while true
#         hash.each do |key, comb|
#             break if key > prime
#             break if key+prime > upper_bound
#             puts "key: #{key}"
#             new_comb = []
#             comb.each do |c| 
#                 new_comb.push c + [prime]
#             end
#             hash[key+prime]  = hash[key+prime] + new_comb
#         end
#         break
#     end
# end

# (2..upper_bound).each do |number|
#     hash[number] = []
#     if primes.include? number
#         hash[number].push [number]
#     end
# end


# p hash


seed_primes(100)
$rec_count = 0

def rec_sum_count(lower_bound, number)
    # puts "begin: #{number}"
    $rec_count += 1
    raise "rec_sum_count overflow" if $rec_count > 1_000_000
    if number <= 1
        # puts "end: #{number} : 0"
        return 0
    end
    if $divisor_primes.include? number
        # puts "end: #{number} : 1"
        return 1
    end
    count = 0
    $divisor_primes.each do |prime|
        next if prime < lower_bound
        break if prime >= number - 1
        second_part = number - prime
        if $divisor_primes.include? second_part
            if second_part >= prime
                count += 1
            end
            next
        end
        prime_count = rec_sum_count(prime, second_part)
        # puts "#{prime} + #{second_part} : #{prime_count}"
        count += prime_count
    end
    # puts "end: #{number} : #{count}"
    return count
end

def rec_sum_print(prefix, lower_bound, number)
    # puts "begin: #{prefix} #{lower_bound} #{number}"
    $rec_count += 1
    raise "rec_sum_count overflow" if $rec_count > 100_000
    if number <= 1
        # puts "end: #{number} : 0"
        return
    end
    if $divisor_primes.include? number
        # puts "end: #{number} : 1"
        puts "#{prefix} #{number}"
        return
    end
    # count = 0
    $divisor_primes.each do |prime|
        next if prime < lower_bound
        break if prime >= number - 1
        second_part = number - prime
        if $divisor_primes.include? second_part
            if second_part >= prime
                puts "#{prefix} #{prime} #{second_part}"
            end
            next
        end
        # puts "calling #{prefix} #{prime} #{second_part}"
        rec_sum_print("#{prefix} #{prime} ", prime, second_part)
        # count += prime_count
    end
    # puts "end: #{prefix} #{lower_bound} #{number}"
end


# number =  ARGV[0].to_i
# puts "number: #{number}"
# sum_count = rec_sum_count(0, number)

# (20..40).each do |number|
#     sum_count = rec_sum_count(number)
#     puts "#{number} : #{sum_count}"
#     if sum_count > 5000
#         break
#     end
# end

# number = 40
# increment = 40
# while true
#     sum_count = rec_sum_count(0, number)
#     if sum_count > 5000
#         break
#     end
#     if sum_count < 5000
#         number += increment
#     end
# end

# number -= 40

sum_count = 0
number = 11

while true
    $rec_count = 0
    sum_count = rec_sum_count(0, number)
    puts "#{number}: #{sum_count}"
    if sum_count > 5000
        break
    end
    number += 1
end



# number =  ARGV[0].to_i
# rec_sum_print("", 0, number)
puts "recursion count : #{$rec_count}"

# PROGRAM END #

end_time = Time.now
diff_time = end_time - start_time

puts
puts "TECHNICAL"
puts
puts "Start time: #{start_time}"
puts "End time: #{end_time}"
puts "elapsed time: #{diff_time}"

