$known_primes = []
$is_prime_calls = 0

# def is_prime(number)
#     $is_prime_calls  += 1
#     divider_stack = [19,17,13,11,7,5,3,2]
#     if number < 20
#         return true if divider_stack.include? number
#         return false
#     end
#     if number % 3 == 0 || number % 7 == 0 || number % 2 == 0 || number % 5 == 0
#         return false
#     end
#     $known_primes.each do |prime|
#         if number % prime == 0
#             return false
#         end
#     end
#     return true
# end

def is_prime(number)
    $is_prime_calls  += 1
    divider_stack = [19,17,13,11,7,5,3,2]
    if number < 20
        return true if divider_stack.include? number
        return false
    end
    num_sqrt = Math::sqrt(number).to_i + 1
    a = 0
    while a <= num_sqrt
        a = divider_stack.pop
        if number % a == 0
            return false
        end
        if divider_stack.length == 4
            (0..3).each { divider_stack.unshift(divider_stack[3]+10) }
        end
    end
    return true
end


def count_primes(up_limit)
    prime_bound = Math::sqrt(up_limit).to_i + 1
    count = 4 # 4 primes before 10
    (11..up_limit).step(2) do |number|
        next if(number % 5 == 0)
        if is_prime(number)
            count += 1
            if number <= prime_bound
                $known_primes.push(number)
            end
        end
    end
    count
end

$circular_primes = [2, 3, 5, 7]

def count_circular_primes(up_limit)
    prime_bound = Math::sqrt(up_limit).to_i + 1
    (11..up_limit).step(2) do |number|
        next if(number % 5 == 0)
        next if !is_prime(number)

        # if number <= prime_bound
        #     $known_primes.push(number)
        # end

        # check if circular prime
        is_circular = true
        number_circular = 0
        circulars = [number]
        while number_circular != number
            if number_circular == 0
                number_circular = number
            end
            number_digits = number_circular.to_s.split('')
            has_non_prime_digit = number_digits.any? { |d| d.to_i % 2 == 0 || d.to_i % 5 == 0 }
            if has_non_prime_digit
                is_circular = false
                break
            end
            number_digits.push(number_digits.shift) # rotate digit
            number_circular = number_digits.join.to_i # next circular number
            circulars.push(number_circular)
            if $circular_primes.include? number_circular
                is_circular = true
                break
            elsif number_circular < number
                is_circular = false
                break
            end
            if !is_prime(number_circular)
                is_circular = false
                break
            end
        end
        if is_circular
            $circular_primes += circulars
            $circular_primes.uniq!
        end
    end
end
puts Time.now

count_circular_primes(1_000_000)
count = $circular_primes.size
puts "number of circular primes: #{count}"

# count = count_primes(100)
# puts "number of primes: #{count}"

puts "is_prime calls: #{$is_prime_calls}"
# puts $known_primes.join(',')
puts $circular_primes.join(',')
puts Time.now

