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

require 'prime'

$n_powers = (0..16).map { |n| 2**n }

def is_power2(n)
    $n_powers.include? n
end

def base2(n)
    $n_powers.find_index(n)
    # if index
    #     return index
    # end
    # -1
end

def phi(n)
    return 0 if n <= 1
    factors = Prime.prime_division(n)
    value = n
    factors.each do |factor|
        value *= factor[0] - 1
        value /= factor[0]
    end
    value
end

def print_chain(n)
    while n >= 1
        puts n
        p Prime.prime_division n
        break if base2(n)
        n = phi(n)
    end
end

def get_chain(n)
    chain = [];
    num = n
    chain_size = 0
    while(true)
        chain.push num
        chain_size += 1
        num_base2 = base2(num)
        if num_base2
            chain += $n_powers[0..num_base2-1].reverse
            chain_size += num_base2
            break
        end
        factors = Prime.prime_division(num)
        value = num
        factors.each do |factor|
            value *= factor[0] - 1
            value /= factor[0]
        end
        num = value
    end
    chain
end

def new_chain_size(n)
    # chain = [];
    num = n
    chain_size = 0
    while(true)
        # chain.push num
        chain_size += 1
        num_base2 = base2(num)
        if num_base2
            chain_size += num_base2
            break
        end
        factors = Prime.prime_division(num)
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

def print_chain_sizes()
    (3..30).each do |n|
        chain_size = new_chain_size(n)

        puts "#{n} #{chain_size}"
        # if chain_size == 6 and Prime.prime? n
        #     puts "#{n} #{phi_n}"
        # end
    end
end

def print_chains()
    (3..30).each do |n|
        chain = get_chain(n)
        p chain
    end
end

def print_chains_prime()
    chain = { 1 => [0, 1] }
    chain_sum = 0

    (1001..1050).step(2) do |n|
        # phi_n = phi(n)
        # chain_size = chain[phi_n][1] + 1
        # chain[n] = [phi_n, chain_size]
        # if chain_size == 6 and Prime.prime? n
        #     chain_sum += n
        #     puts "#{n} #{phi_n}"
        # end
        if Prime.prime? n
            chain = [];
            num = n
            chain.push num
            num -= 1
            chain_size = 1
            first_factors = -1
            while(true)
                chain.push num
                chain_size += 1
                break if num <= 2
                num_base2 = base2(num)
                if num_base2
                    chain_size += num_base2
                    break
                end
                factors = Prime.prime_division(num)
                if first_factors == -1
                    first_factors = factors
                end
                value = num
                factors.each do |factor|
                    value *= factor[0] - 1
                    value /= factor[0]
                end
                num = value
            end

            # p [chain, first_factors, chain_size]
            p [chain, chain_size]
            print_chain(n-1)
            puts
        end
    end
end

def next_chains(num)
    factors = Prime.prime_division num
    next_numbers = []
    # if factors[0][1] > 1
    #     factors.each do |factor_group|
    #         base = factor_group[0]
    #         next if base == 2
    #         factor_hash = factors.to_h
    #         new_base = base*2 + 1
    #         if factor_hash[new_base]
    #             factor_hash[new_base] += 1
    #         else
    #             factor_hash[new_base] = 1
    #         end
    #         new_num = 1
    #         factor_hash.each do |base, pow|
    #             new_num *= base**pow
    #         end
    #         next_numbers.push new_num
    #     end
    # end
    factors.push [1, 1]
    factors.each do |factor_group|
        base = factor_group[0]
        base_pow = factor_group[1]
        (1..base_pow).each do |i|
            p = (base**i + 1)
            if Prime.prime? p
                next_numbers.push num * p / base**(i-1)
            end
        end
    end
        # base2_pow = factors[0][1]
        # (1..base2_pow).each do |i|
        #     next_numbers.push num * (2**i + 1) / 2**(i-1)
        # end
    next_numbers
end

def chain_sum(chain_size)
    sum = 0
    max_num = 0
    n = 1
    iteration_count = 0
    chain_primes = []
    while(true)
        n += 2
        iteration_count += 1
        if iteration_count % 100_000 == 0
            puts iteration_count
        end
        next if !(Prime.prime? n)
        # n_size = new_chain_size(n)
        n_size = chain_size(n)
        if n_size == chain_size
            chain_primes.push n
            max_num = n if n > max_num
            sum += n
        end
        break if max_num > 0 and n > max_num*2
    end
    puts "#{max_num}"
    p chain_primes
    sum
end

# puts chain_sum(ARGV[0] ? ARGV[0].to_i : 8)

print_chain(1459)

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
puts "Start time: #{start_time}"
puts "End time: #{end_time}"
puts "elapsed time: #{diff_time}"

