require './primes.rb'
require 'prime'

upper_bound = 10_000_000

# puts "BUILT-IN LIBRARY"

# start_time = Time.now
# count = 0
# (1..upper_bound).each do |n|
#     if Prime.prime? n
#         count += 1
#     end
# end
# puts "Number of Primes: #{count}"
# end_time = Time.now
# diff_time = end_time - start_time
# puts "elaplsed time: #{diff_time}"


puts "CUSTOM FUNCTION"

start_time = Time.now
seed_primes(100)
count = 2
n = 0

while(true)
    n += 6
    if n % 6000 == 0
        seed_primes(Math::sqrt(n).to_i + 100)
        if n%600000 == 0
            puts n
        end
    end
    if is_prime(n-1)
        count += 1
    end
    if is_prime(n+1)
        count += 1
    end
    break if n > upper_bound
end


puts "Number of Primes: #{count}"
puts "Number of is_prime calls : #{$is_prime_calls}"
puts "Number of is_prime iterations : #{$is_prime_iterations}"
end_time = Time.now
diff_time = end_time - start_time
puts "elaplsed time: #{diff_time}"

