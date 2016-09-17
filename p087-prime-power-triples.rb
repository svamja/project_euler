# PROBLEM STATEMENT

# The smallest number expressible as the sum of a prime square, prime cube, and prime fourth power is 28.
# In fact, there are exactly four numbers below fifty that can be expressed in such a way:

# 28 = 2^2 + 2^3 + 2^4
# 33 = 3^2 + 2^3 + 2^4
# 49 = 5^2 + 2^3 + 2^4
# 47 = 2^2 + 3^3 + 2^4

# How many numbers below fifty million can be expressed as the sum of a prime square, prime cube, and prime fourth power?

# Approach 

# grab all possible numbers
# remove duplicates using shell
# cat p087_numbers.out | sort | uniq | wc

start_time = Time.now

# PROGRAM START #

require './primes.rb'
require 'tmpdir'

upper_bound = ARGV[0].to_i

puts "upper bound: #{upper_bound}"

seed_primes(Math::sqrt(upper_bound).to_i)

puts $divisor_primes[-1]

iteration_count = 0
count = 0
sys_temp_dir = Dir::tmpdir()
puts sys_temp_dir

f = File.open(sys_temp_dir + '/p087_numbers.out', 'w')

$divisor_primes.each do |c|
    # puts "c: #{c}"
    c_exp = c*c*c*c
    break if c_exp >= upper_bound
    c_remainder = upper_bound - c_exp
    $divisor_primes.each do |b|
        # puts "b: #{b}"
        b_exp = b*b*b
        break if b_exp >= c_remainder
        b_remainder = c_remainder - b_exp
        $divisor_primes.each do |a|
            iteration_count += 1
            # puts "a: #{a}"
            a_exp = a*a
            break if a_exp >= b_remainder
            num = a_exp + b_exp + c_exp
            f.puts num
            count += 1
        end
    end
end

puts "count: #{count}"
puts "iteration count : #{iteration_count}"

# PROGRAM END #

end_time = Time.now
diff_time = end_time - start_time

puts
puts "TECHNICAL"
puts
puts "Start time: #{start_time}"
puts "End time: #{end_time}"
puts "elapsed time: #{diff_time}"

