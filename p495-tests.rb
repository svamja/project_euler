# PROBLEM STATEMENT

start_time = Time.now

# PROGRAM START #

# get all combinations

# k1 = 2
# k2 = 4

# sum = 0
# (0..k1).each do |i1|
#     (0..k2).each do |i2|
#         next if i1 > i2
#         if k1 % 2 == 0 and k2 % 2 == 0
#             sum += (k1 - i1 + 1) * (k2 - i2 + 1) / 2 
#         else
#             sum += (k1 - i1 + 1) * (k2 - i2 + 1) / 2 - 1
#         end
#     end
# end

# puts sum


def get_sets(nums)
    set = []
    if nums.size == 1
        (0..nums[0]).each do |k|
            set.push k
        end
    elsif nums.size == 2
        (0..nums[0]).each do |i0|
            break if i0 > nums[0]/2
            (i0..nums[1]).each do |i1|
                break if nums[0] % 2 ==0 and i0 == nums[0]/2 and i1 > nums[1]/2
                set.push [i0, i1]
            end
        end
    end
    set
end

def get_count(balls, box_count = 2)
    count = 0
    if balls.size != 2 or box_count != 2
        return 0
    end
    (0..balls[0]).each do |i0|
        break if i0 > balls[0]/2
        (0..balls[1]).each do |i1|
            break if balls[0] % 2 ==0 and i0 == balls[0]/2 and i1 > balls[1]/2
            count += 1
        end
    end
    count
end

puts
(1..5).each do |k1|
    (k1..10).each do |k2|
        count = get_count([k1, k2])
        puts "k1: #{k1} k2: #{k2} count: #{count}"
    end
    puts
end



# sets = get_sets([2, 4])
# p sets
# puts sets.size

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

