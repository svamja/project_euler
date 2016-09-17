# PROBLEM STATEMENT

# In the following equation x, y, and n are positive integers.
# 1/x + 1/y = 1/n
# For n = 4 there are exactly three distinct solutions:
# []
# What is the least value of n for which the number of distinct solutions exceeds one-thousand?

# Approach

# 1/x + 1/y = 1/n
# n = (x*y) / (x + y) 

# Approach 2

# 1/y = 1/n - 1/x
# 1/y = (x - n) / xn
# y = xn / (x-n)
# as x grows y -> n
# stop x when y < n + 1
# n + 1 = xn / (x -n)
# nx - n^2 + x - n = xn
# n^2 + n - x = 0
# x = n^2 + n -> upper limit

# Approach 3

# get factors of n
# multiply factor exponents add 1

start_time = Time.now

# PROGRAM START #

require './primes.rb'

iteration_count = 0
max_count = 0

# [420, 840, 2520, 27720, 360360, 720720].each do |n|
# (27720..277200).step(27720) do |n|
(27720..360360).step(30) do |n|
    # solution_count = 0
    # (n+1.. 2*n).each do |x|
    #     iteration_count += 1
    #     # y = x*n.to_f/(x-n)
    #     # puts "#{n} : #{x} #{y}"
    #     if (x*n) % (x-n) == 0
    #         y = x*n/(x-n)
    #         solution_count += 1
    #     end
    # end
    # puts "#{n} : #{solution_count}"
    # if solution_count > 1000
    #     puts "#{n} : #{solution_count}"
    #     break
    # end

    # method 2
    factors, factors_exp = factorize(n)
    if factors_exp.size > 0
        exp_product = factors_exp.map { |e| e*2+1 }.inject(:*)
        exp_product /= 2
    else
        exp_product = 1
    end
    count = exp_product + 1
    if count > max_count
        puts "#{n} : #{count}"
        max_count = count
    end
    if count > 1000
        break
    end
    # p factors_exp
end

puts "iteration count : #{iteration_count}"

primes = [2,3,5,7,11,13,17,19,23]

min_number = 999_999_999
product_limit = 998
iteration_count = 0
possible_numbers = []

while true
    iteration_count +=1
    break if iteration_count > 10_000
    indexes = Array.new(primes.size, 0)
    exponents = Array.new(primes.size, 1)
    factors = Array.new(primes.size, 1)
    pointer = 0
    while true
        iteration_count +=1
        break if iteration_count > 10_000
        least_factor = 999_999_999
        primes.each_with_index do |prime, i|
            if factors[i]*prime < least_factor
                least_factor = factors[i]*prime
                pointer = i
            end
        end

        indexes[pointer] += 1
        exponents[pointer] = 2*indexes[pointer] + 1
        factors[pointer] *= primes[pointer]
        exp_product = exponents.reduce(:*)
        if exp_product > 100
            product = factors.reduce(:*)
            possible_numbers.push product
            if exp_product > 3000
                break
            end
        else
            pointer += 1
            pointer = 0 if pointer >= primes.size
        end
    end

    if product < min_number
        min_number = product
    end

    break
end

p possible_numbers


# PROGRAM END #

end_time = Time.now
diff_time = end_time - start_time

puts
puts "TECHNICAL"
puts
puts "Start time: #{start_time}"
puts "End time: #{end_time}"
puts "elapsed time: #{diff_time}"

