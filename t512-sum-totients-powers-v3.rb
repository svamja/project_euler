# PROBLEM STATEMENT

# Let φ(n) be Euler's totient function.
# Let f(n)=(∑ni=1φ(ni)) mod (n+1).
# Let g(n)=∑ni=1f(i).
# g(100)=2007.
# Find g(5×10^8).

start_time = Time.now

# PROGRAM START #

$prime_div_calls = 0

require './primes.rb'
require 'prime'

$phi_cache = {}

def phi(n)
    return 1 if n <= 2
    factors = Prime.prime_division(n)
    value = n
    factors.each do |factor|
        value *= factor[0] - 1
        value /= factor[0]
    end
    value
end

$phi_exp_1 = {}
$phi_exp_2 = {}

def phi_prime(base, exp)
    $phi_exp_1[base] ||= phi(base)
    $phi_exp_2[base] ||= phi(base*base)
    if exp == 1
        return $phi_exp_1[base]
    end
    if exp == 2
        return $phi_exp_2[base]
    end
    return $phi_exp_2[base] * (base ** (exp - 2))
end

def phi_pre_factored(n, factors)
    value = n
    factors.each do |factor|
        value *= factor[0] - 1
        value /= factor[0]
    end
    value
end

def phi_factors(factors)
    phi_value = 1
    factors.each do |factor|
        base = factor[0]
        exp = factor[1]
        phi_value *= phi_prime(base, exp)
    end
    phi_value
end

def exp_mod(base, exp, modulus)
    result = 1
    base = base % modulus
    while exp > 0
        if (exp%2 == 1)
            result = (result*base) % modulus
        end
        exp /= 2
        base = (base*base) % modulus
    end
    return result
end


def phi_prime_mod(base, exp, mod)
    $phi_exp_1[base] ||= phi(base)
    $phi_exp_2[base] ||= phi(base*base)
    if exp == 1
        return $phi_exp_1[base]
    end
    if exp == 2
        return $phi_exp_2[base]
    end
    phi_mod = $phi_exp_2[base]
    return $phi_exp_2[base] * exp_mod(base, exp - 2, mod)
    phi_mod
end

def phi_factors_mod(factors, mod)
    phi_value = 1
    factors.each do |factor|
        base = factor[0]
        exp = factor[1]
        phi_value *= phi_prime_mod(base, exp, mod)
        phi_value %= mod if phi_value > mod
    end
    phi_value
end

$factors_cache = {}

def phi_mod(n, i)
    return 1 if n == 1
    return phi(n) if i == 1
    # if !$factors_cache[n]
    #     $factors_cache[n] = Prime.prime_division(n)
    #     $prime_div_calls += 1
    # end
    # factors = $factors_cache[n].dup
    # factors.map! { |f| [f[0], f[1]*i] }
    # phi = phi_factors_mod(factors, n+1)
    factors = Prime.prime_division(n)
    if i == 2
        factors.map! { |f| [f[0], f[1]*2] }
        phi = phi_pre_factored(n*n, factors)
    else
        factors.map! { |f| [f[0], f[1]*i] }
        phi = phi_pre_factored(n**i, factors)
    end
    return phi % (n+1)
end

def f(n)
    if n % 2 == 0
        return 0
    end
    if n == 1
        return 1
    end
    if is_prime n
        return n - 1
    end
    phi_1 = phi_mod(n, 1)    
    phi_2 = phi_mod(n, 2)

    (phi_1*(n/2 + 1) + phi_2 * (n/2)) % (n+1)
end

def f_modified(n)
    if is_prime_sieve n
        return n - 1
    end
    factors = Prime.prime_division(n)
    $prime_div_calls += 1
    phi_1 = phi_pre_factored(n, factors)
    factors.map! { |f| [f[0], f[1]*2] }
    phi_2 = phi_pre_factored(n*n, factors)
    (phi_1*(n/2 + 1) + phi_2 * (n/2)) % (n+1)
end


def g(n)
    sum = 0
    (1..n).each do |i|
        sum += f(i)
    end
    sum
end

def g_subset(n1, n2)
    sum = 0
    if n1 % 2 == 0
        n1 += 1
    end
    if n1 == 1
        sum = 1
        n1 = 3
    end
    breakpoints = []
    rng_size = 100_000
    point = n1
    while point < n2
        breakpoints.push point
        point += rng_size
    end

    breakpoints.each do |lower_bound|
        upper_bound = lower_bound + rng_size - 1
        if upper_bound > n2
            upper_bound = n2
        end
        puts "#{lower_bound} .. #{upper_bound}"
        (lower_bound..upper_bound).step(2) do |i|
            sum += f_modified(i)
        end
    end
    # (n1..n2).step(2) do |i|
    #     sum += f_modified(i)
    # end
    sum
end

seed_primes(28300)

num = ARGV[0] ? ARGV[0].to_i : 100
num2 = ARGV[1] ? ARGV[1].to_i : num+1000

# sieve_setup(num2)

# sieve_factors_setup(num2)

# puts g_subset(num, num2)


# puts $sieve_bound

(num..num2).each do |n|
    next if n%2 == 0
    # next if is_prime_sieve n
    next if is_prime n
    # sieve_factors(n)
    Prime.prime_division n
    # $prime_div_calls += 1
end


# PROGRAM END #

end_time = Time.now
diff_time = end_time - start_time

puts
puts "TECHNICAL"
puts
puts "Number of is_prime calls : #{$is_prime_calls}"
puts "Number of is_prime iterations : #{$is_prime_iterations}"
puts "Number of prime_div_calls : #{$prime_div_calls}"
puts "Start time: #{start_time}"
puts "End time: #{end_time}"
puts "elapsed time: #{diff_time}"

