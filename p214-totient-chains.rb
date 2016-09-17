# PROBLEM STATEMENT

# Let φ be Euler's totient function, i.e. for a natural number n, φ(n) is the number of k, 1 ≤ k ≤ n, for which gcd(k,n) = 1.

# By iterating φ, each positive integer generates a decreasing chain of numbers ending in 1.
# E.g. if we start with 5 the sequence 5,4,2,1 is generated.
# Here is a listing of all chains with length 4:

# 5,4,2,1
# 7,6,2,1
# 8,4,2,1
# 9,6,2,1
# 10,4,2,1
# 12,4,2,1
# 14,6,2,1
# 18,6,2,1
# Only two of these chains start with a prime, their sum is 12.

# What is the sum of all primes less than 40000000 which generate a chain of length 25?

start_time = Time.now

# PROGRAM START #

require './primes.rb'
require 'prime'

$n_powers = (0..16).map { |n| 2**n }

seed_primes(350)
# seed_primes(1000)

def base2(n)
    $n_powers.find_index(n)
end

def new_chain_size(n, prime_flag = false)
    # chain = [];
    num = n
    chain_size = 0
    if prime_flag
        num -= 1
        chain_size += 1
    end
    while(true)
        # chain.push num
        chain_size += 1
        num_base2 = base2(num)
        if num_base2
            chain_size += num_base2
            break
        end
        factors = Prime.prime_division num
        value = num
        factors.each do |factor|
            value *= factor[0] - 1
            value /= factor[0]
        end
        num = value
    end
    chain_size
end

def chain_size(n)
    chain_size = 1
    while n >= 2
        chain_size += 1
        n = phi(n)
    end
    chain_size
end

def chain_sum(chain_size)
    sum = 0
    n = 0
    # n_max = 2**chain_size
    while(true)
        n += 6
        break if n > 40_000_000
        # break if n > n_max
        if n % 120_000 == 0
            seed_primes(Math::sqrt(n).to_i + 20)
            puts n
        end
        if is_prime(n-1) and new_chain_size(n-1, true) == chain_size
            # n_max = n*3/2
            sum += n-1
        end
        if is_prime(n+1) and new_chain_size(n+1, true) == chain_size
            # n_max = n*3/2
            sum += n+1
        end
    end
    sum
end

sum = chain_sum(ARGV[0] ? ARGV[0].to_i : 8)
puts sum
file = File.open("test.txt", 'w')
file.puts sum

# print_chain(1459)

# 4 : 12
# 5 : 43
# 6 : 180
# 7 : 950
# 8 : 4161
# 9 : 19104
# 10: 93430
# 11 : 448984
# 12 : 2486894
# 13 : 11594594
# 14 : 59846083 [3s]
# 15 : 296977350 [13s]
# 16: 1523527844 [76s]
# 10s for 1m
# 

# 9 : 19104



# p next_chains(6)

# print_chain(ARGV[0].to_i)


# (2..200).each do |n|
#     puts "#{n} #{phi(n)}"
# end

# p chain
# puts chain_sum

# PROGRAM END #

end_time = Time.now
diff_time = end_time - start_time

puts
puts "TECHNICAL"
puts
puts "Number of is_prime calls : #{$is_prime_calls}"
puts "Number of is_prime iterations : #{$is_prime_iterations}"
puts "Start time: #{start_time}"
puts "End time: #{end_time}"
puts "elapsed time: #{diff_time}"

