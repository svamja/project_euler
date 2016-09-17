# PROBLEM STATEMENT

# Let φ(n) be Euler's totient function.

# Let f(n)=(∑ni=1φ(ni)) mod (n+1).

# Let g(n)=∑ni=1f(i).

# g(100)=2007.

# Find g(5×108).

start_time = Time.now

# PROGRAM START #

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

def phi_factors(factors)
    phi_value = 1
    factors.each do |factor|
        base = factor[0]
        exp = factor[1]
        phi_value *= phi_prime(base, exp)
    end
    phi_value
end

def phi_mod(n, i)
    return 1 if n == 1
    return phi(n) if i == 1
    factors = Prime.prime_division(n)
    factors.map! { |f| [f[0], f[1]*i] }
    phi_pow = phi_factors(factors)

    return phi_pow % (n+1)
end

def f(n)
    if n % 2 == 0
        return 0
    end
    mod_sum = 0
    (1..n).each do |i|
        mod_sum += phi_mod(n, i)
    end
    mod_sum % (n+1)
end

def g(n)
    sum = 0
    (1..n).each do |i|
        sum += f(i)
    end
    sum
end

num = ARGV[0] ? ARGV[0].to_i : 100
puts g(num)

# f = File.open(ENV['HOME'] + '/tmp/p512_numbers.txt', 'w')
# (1..10).each do |i|
#     n = 11
#     p = phi(n**i)
#     puts "#{i} #{n}:#{phi(p)}"
# end

# f.close


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

