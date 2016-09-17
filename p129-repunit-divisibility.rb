# PROBLEM STATEMENT

# A number consisting entirely of ones is called a repunit. We shall define R(k) to be a repunit of length k; for example, R(6) = 111111.

# Given that n is a positive integer and GCD(n, 10) = 1, it can be shown that there always exists a value, k, for which R(k) is divisible by n, and let A(n) be the least such value of k; for example, A(7) = 6 and A(41) = 5.

# The least value of n for which A(n) first exceeds ten is 17.

# Find the least value of n for which A(n) first exceeds one-million.

start_time = Time.now

# PROGRAM START #

require 'prime'

(2..7).each do |i|
    # num = ("1" * i).to_i
    # num = ("1" + "0" * i + "1").to_i
    num = ("90" * i + "91").to_i
    factors = Prime.prime_division num
    puts "#{i}   #{num}"
    p factors

    # m = ("90" * i + "91").to_i
    # num = m * 11
    # puts "#{i}  #{m} x 11 = #{num}"
end

# PROGRAM END #

end_time = Time.now
diff_time = end_time - start_time

puts
puts "TECHNICAL"
puts
puts "Start time: #{start_time}"
puts "End time: #{end_time}"
puts "elapsed time: #{diff_time}"

