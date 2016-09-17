require './primes.rb'
start_time = Time.now

seed_primes(1000)

# Right truncatable primes by number of digits
rt_primes = []
rt_primes[1] = [2, 3, 5, 7]

# Right truncatable primes by number of digits
lt_primes = []
lt_primes[1] = [2, 3, 5, 7]

# Truncatable primes
t_primes = []

lt_digits = [1, 2,3,5,7,9]
rt_digits = [1, 3,5,7,9]

common_primes = []

# Build primes by growing number of digits
(2..10).each do |num_digits|

    # Build up Right Truncatable Primes List
    rt_primes[num_digits] = []
    rt_primes[num_digits - 1].each do |rt_prime_base|
        rt_digits.each do |right_digit|
            # number = (rt_prime_base.to_s + right_digit.to_s).to_i
            number = rt_prime_base*10 + right_digit
            if is_prime(number)
                rt_primes[num_digits].push(number)
            end
        end
    end
    puts "RT => " + rt_primes[num_digits].join(':')

    # Build up Left Truncatable Primes List
    lt_primes[num_digits] = []
    lt_primes[num_digits - 1].each do |lt_prime_base|
        lt_digits.each do |left_digit|
            number = (left_digit.to_s + lt_prime_base.to_s).to_i
            if is_prime(number)
                lt_primes[num_digits].push(number)
            end
        end
    end
    puts "LT => " + lt_primes[num_digits].join(':')

    # The Common Set of Primes are Truncatable
    common_primes = rt_primes[num_digits] & lt_primes[num_digits]
    puts "Common => #{common_primes}"

    t_primes = t_primes + common_primes

    break if(rt_primes[num_digits].size == 0 || lt_primes[num_digits].size == 0)

end

t_sum = t_primes.inject(:+)

puts "Total Truncatable Primes: " + t_primes.size.to_s
puts t_primes.join(':')
puts "Sum of Truncatable Primes: #{t_sum}"

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

