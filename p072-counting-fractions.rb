# PROBLEM STATEMENT

# Consider the fraction, n/d, where n and d are positive integers. If n<d and HCF(n,d)=1, it is called a reduced proper fraction.
# If we list the set of reduced proper fractions for d ≤ 8 in ascending order of size, we get:
# 1/8, 1/7, 1/6, 1/5, 1/4, 2/7, 1/3, 3/8, 2/5, 3/7, 1/2, 4/7, 3/5, 5/8, 2/3, 5/7, 3/4, 4/5, 5/6, 6/7, 7/8
# It can be seen that there are 21 elements in this set.
# How many elements would be contained in the set of reduced proper fractions for d ≤ 1,000,000?

# Approach 1

# upper bound = u
# go thru n from 1 to u - 1
# if n is prime, all remaining fractions r = u - n are possible
# if n has factors axb
#   r - u/a - u/b + u/ab
# if n has factors axbxc
#   r - u/a - u/b - u/c + u/ab + u/ac + u/bc - u/abc


# Approach 2

# go thru d from 2 to u
# if d is prime all previous factors are possible, that is f = d-1
# if d has factors axb
#  possible factors = f - d/a - d/b + d/ab

# Approach 3

# for u ( = 8), get all primes upto u/2 ( = 4) 2, 3
# sum = 8*7/2 = 28
# for each prime, 
#   prime_multiples = pm = u/prime ( 8 / 2 = 4)
#   sum - (pm-1)*(pm-2)/2
# voila!

# Approach 4
# do above for only primes below sqrt(u)
# for primes from sqrt(u) to u/2, just take out sum - u/prime, that's it!

start_time = Time.now

# PROGRAM START #

require './primes.rb'
require './combinator.rb'

fractions_count = 0
upper_bound = 10_000

puts "Upper Bound: #{upper_bound}"

# Approach 2

# (2..upper_bound).each do |d|
#     factors, factors_exp = factorize(d)
#     n_count = 0
#     (1..d-1).each do |n|
#         has_common_factors = false
#         factors.each do |f|
#             if n % f == 0
#                 has_common_factors = true
#                 break
#             end
#         end
#         if has_common_factors
#             # puts "x #{n} / #{d}"
#         else
#             n_count +=1
#             fractions_count += 1
#             # puts "#{n} / #{d}"
#         end
#     end
#     # puts "#{d} : #{n_count}"
# end
# puts "Sum (Approach 2) : #{fractions_count}"

# Approach 3

# puts
# puts "Approach 3"
# puts
# get primes below upper_bound
# seed_primes(upper_bound/2)
# sum = upper_bound*(upper_bound-1)/2
# get all combinations of primes
# iteration_count = 0
# (1..$divisor_primes.size).each do |size| 
#     prime_combinations = combinations_array($divisor_primes, size)
#     prime_combinations.each do |prime_comb|
#         iteration_count += 1
#         prime_product = prime_comb.inject(:*)
#         factor_count = upper_bound/prime_product
#         fraction_count = factor_count*(factor_count-1)/2
#         if size % 2 == 1
#             sum -= fraction_count
#         else
#             sum += fraction_count
#         end
#     end
# end
# puts "approach 3 : #{sum}"
# puts "iteration count: #{iteration_count}"

# puts
# puts "Approach 3 Variation"
# puts

# seed_primes(upper_bound/2)
# sum = upper_bound*(upper_bound-1)/2
# iteration_count = 0

# (1..$divisor_primes.size).each do |size| 
#     i = 0
#     first_break = false
#     rec_combinations([], $divisor_primes, size) do |prime_comb|
#         i += 1
#         iteration_count += 1
#         # p prime_comb
#         prime_product = prime_comb.inject(:*)
#         # puts prime_product
#         factor_count = upper_bound/prime_product
#         fraction_count = factor_count*(factor_count-1)/2
#         if size % 2 == 1
#             sum -= fraction_count
#         else
#             sum += fraction_count
#         end
#         if prime_product > upper_bound
#             if i == 1
#                 first_break = true
#             end
#             "break"
#         end
#     end
#     if first_break
#         break
#     end
# end

# puts "Sum (Approach 3) : #{sum}"
# puts "iteration count: #{iteration_count}"
# puts "recursive calls : #{$rec_calls}"


puts
puts "Approach 4"
puts

seed_primes(upper_bound/2)

u_sqrt = Math::sqrt(upper_bound).to_i

sqrt_primes = $divisor_primes.select { |prime| prime <= u_sqrt }
rest_primes = $divisor_primes.select { |prime| prime > u_sqrt  && prime <= upper_bound/2 }

sum = upper_bound*(upper_bound-1)/2
iteration_count = 0

(1..sqrt_primes.size).each do |size| 
    i = 0
    first_break = false
    rec_combinations([], sqrt_primes, size) do |prime_comb|
        i += 1
        iteration_count += 1
        # p prime_comb
        prime_product = prime_comb.inject(:*)
        # puts prime_product
        factor_count = upper_bound/prime_product
        fraction_count = factor_count*(factor_count-1)/2
        if size % 2 == 1
            sum -= fraction_count
        else
            sum += fraction_count
        end
        if prime_product > upper_bound
            if i == 1
                first_break = true
            end
            "break"
        end
    end
    if first_break
        break
    end
end


rest_primes.each do |prime|
    factor_count = upper_bound/prime
    fraction_count = factor_count*(factor_count-1)/2
    sum -= fraction_count
    (1..sqrt_primes.size).each do |size|
        i = 0
        first_break = false
        rec_combinations([], sqrt_primes, size) do |prime_comb|
            i += 1
            iteration_count += 1
            # p prime_comb
            prime_product = prime_comb.inject(:*)
            # puts prime_product
            factor_count = upper_bound/(prime*prime_product)
            fraction_count = factor_count*(factor_count-1)/2
            if size % 2 == 1
                sum += fraction_count
            else
                sum -= fraction_count
            end
            if prime_product*prime > upper_bound
                if i == 1
                    first_break = true
                end
                "break"
            end
        end
        if first_break
            break
        end
    end
end

puts "Sum (Approach 4) : #{sum}"
puts "iteration count: #{iteration_count}"
puts "recursive calls : #{$rec_calls}"


# PROGRAM END #

end_time = Time.now
diff_time = end_time - start_time

puts
puts "TECHNICAL"
puts
puts "Start time: #{start_time}"
puts "End time: #{end_time}"
puts "elapsed time: #{diff_time}"

