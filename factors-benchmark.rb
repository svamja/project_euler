require './primes.rb'
require 'prime'

upper_bound = 100_000

puts "BUILT-IN LIBRARY"

start_time = Time.now
count = 0
(1..upper_bound).each do |n|
    factors = Prime.prime_division n
    count += factors.size
end
puts "Count: #{count}"
end_time = Time.now
diff_time = end_time - start_time
puts "elaplsed time: #{diff_time}"


puts "CUSTOM FUNCTION"

start_time = Time.now
count = 0
(1..upper_bound).each do |n|
    factors  = prime_factors(n)
    count += factors.size
end

puts "Count: #{count}"
puts "Number of is_prime calls : #{$is_prime_calls}"
puts "Number of is_prime iterations : #{$is_prime_iterations}"
end_time = Time.now
diff_time = end_time - start_time
puts "elaplsed time: #{diff_time}"

