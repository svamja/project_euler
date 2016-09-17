# require './primes.rb'
require 'prime'
start_time = Time.now


# (1..1_000_000).each do |n|
#     is_prime(n)
# end

# seed_primes(1000)

count = 0
(1..1_000_000).each do |n|
    if Prime.prime? n
        count += 1
    end
end
puts "Number of Primes: #{count}"

end_time = Time.now
diff_time = end_time - start_time

puts
puts "TECHNICAL"
puts
puts "Number of is_prime calls : #{$is_prime_calls}"
puts "Number of is_prime iterations : #{$is_prime_iterations}"
puts "Start time: #{start_time}"
puts "Start time: #{end_time}"
puts "elaplsed time: #{diff_time}"

