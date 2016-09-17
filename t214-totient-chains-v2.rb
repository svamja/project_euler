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

# global variables

$n_powers = (0..26).map { |n| 2**n }
$n_primes = $n_powers.map { |n| Prime.prime?(n+1) ? n+1 : -1 }
$primes = []
Prime.each do |p|
    $primes.push p
    break if p > 10_000
end

# functions

def is_power2(n)
    $n_powers.include? n
end

def base2(n)
    $n_powers.find_index(n)
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

def get_prime_products(exp)
    products = []
    rec_get_prime_products(exp, [], exp, 1, products)
    products.sort
end

def rec_get_prime_products(total_exp, used_exps, remaining_exp, current_product, products)
    # p [total_exp, used_exps, remaining_exp, current_product, products]
    least_exp = used_exps.min
    if remaining_exp == 0
        products.push current_product
    end
    (1..remaining_exp).each do |e|
        next if(used_exps.include? e)
        next if least_exp and e > least_exp
        exp_prime = $n_primes[e]
        next if(exp_prime == -1)
        r = remaining_exp - e + 1
        products.push current_product*exp_prime*(2**r)
        rec_get_prime_products(total_exp, used_exps + [e], r - 1, current_product*exp_prime, products)
    end
    if total_exp == remaining_exp
        products.push 2**(total_exp+1)
    end
end

def analyze(n)
    factors = Prime.prime_division(n)
    exp = factors[0][1]
    numbers = []
    if Prime.prime? n+1
        numbers.push n+1
    end

    (0..exp).each do |e|
        if(e == 0)
            r = exp - e
            numbers.push $n_primes[e]*(2**r)
            next
        end
        if $n_primes[e] != -1
            r = exp - e + 1
            numbers.push $n_primes[e]*(2**r)
            # numbers.push n*$n_primes[e]
        end
    end
    p numbers
end

def get_by_phi(phi_val)
    numbers = []
    (phi_val..phi_val*10).each do |n|
        phi_n = phi(n)
        if phi_n == phi_val
            numbers.push n            
        end
    end
    numbers
end

def factors_to_product(factors)
    product = 1
    factors.each do |key, value|
        product *= key**value
    end
    product
end

def rec_division(remainder, prime, current_result, results)
    # p [remainder, prime, current_result, results]
    new_remainder = remainder.dup
    if current_result[prime]
        current_result[prime] += 1
        new_remainder[prime] ||= 0
        new_remainder[prime] -= 1
    else
        k = prime - 1
        k_factors = Prime.prime_division(k).to_h
        k_factors.each do |base, exp|
            new_remainder[base] ||= 0
            new_remainder[base] -= exp
        end
        current_result[prime] = 1
    end
    new_remainder.delete_if { |k, v| v == 0 }
    if new_remainder.size == 0
        results.push current_result
        if !current_result[2]
            results.push current_result.merge({2 => 1})
        end
    elsif new_remainder.values.all? { |x| x > 0 }
        $primes.each do |new_prime|
            break if new_prime > prime
            rec_division(new_remainder, new_prime, current_result.dup, results)
        end
    end
end

def composite_prime_products(num)
    return [] if num % 2 == 1
    factors = Prime.prime_division(num).to_h
    results = []
    $primes.each do |prime|
        # next if prime <= 2
        next if prime > num*num
        rec_division(factors, prime, {}, results)
    end
    products = results.map do |factors|
        product = 1
        factors.each do |base, exp|
            product *= base**exp
        end
        product
    end
    products
end

def hunt_chain_size(chain_size)
    chain_primes = []
    chain_sum = 0

    (1..chain_size-2).each do |exp|
        puts "exp: #{exp}"
        numbers = [2**exp]
        diff = chain_size - exp
        (0..diff-3).each do |j|
            puts "j: #{j} : #{numbers.size}"
            # p numbers
            next_numbers = []
            numbers.each do |num|
                next_set = composite_prime_products(num)
                if $n_powers.include? next_set[0]
                    next_set.shift
                end
                next_numbers += next_set
            end
            numbers = next_numbers
        end
        numbers.each do |num|
            next if num % 2 == 1
            if Prime.prime? num+1
                chain_primes.push num+1
                chain_sum += num+1
            end
        end
    end
    p chain_sum
end


# program

# p $primes
chain_size = ARGV[0].to_i if ARGV[0]
chain_size ||= 6
puts chain_size
hunt_chain_size(chain_size)


# PROGRAM END #

end_time = Time.now
diff_time = end_time - start_time

puts
puts "TECHNICAL"
puts
puts "Start time: #{start_time}"
puts "End time: #{end_time}"
puts "elapsed time: #{diff_time}"

