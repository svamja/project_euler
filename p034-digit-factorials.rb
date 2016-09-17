
digit_factorials = [1, 1, 2, 6, 24, 120, 720, 5040, 40320, 362880]

digits = [1, 1, 0, 0, 0, 0, 0, 0]

iteration_count = 0
n = 0
sum_of_factorions = 0

# Go through each number
while n < 9999999
    
    iteration_count += 1

    n = 0
    factorial_sum = 0
    not_possible = false

    digits.each_with_index do |digit, index| 
        n += digit * 10 ** index
    end

    digit_count = n.to_s.size
    carry = false

    # Go through each digit of the number
    digits.each_with_index do |digit, index| 
        if index >= digit_count
            break
        end
        digit_factorial = digit_factorials[digit]
        if digit_factorial > n
            not_possible = true
            break
        end
        factorial_sum += digit_factorial
    end

    # Skip ahead, if high digit found
    if not_possible
        carry = false
        digits.each_with_index do |digit, index| 
            if carry
                digits[index] += 1
                if digits[index] >= 10
                    digits[index] = 0
                    carry = true
                else
                    carry = false
                end
            end
            digit_factorial = digit_factorials[digit]
            if digit_factorial > n
                (0..index).each do |i|
                    digits[i] = 0
                end
                carry = true
            end
        end
    # else, increment, if possible
    else
        carry = true
        digits.each_with_index do |digit, index| 
            if carry == true
                digits[index] += 1
                if digits[index] >= 10
                    digits[index] = 0
                else
                    carry = false
                end
            end
        end
    end

    # if not_possible
    #     puts "#{n} : Not Possible"
    # else
    #     puts "#{n} : #{factorial_sum}"
    # end

    if n == factorial_sum
        sum_of_factorions += factorial_sum
        puts "#{n} : #{factorial_sum}"
    end

    # break

end

puts "iteration count: #{iteration_count}"
puts "Last number: #{n}"
puts "sum of factorions: #{sum_of_factorions}"
