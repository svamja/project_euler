# PROBLEM STATEMENT

# A row measuring seven units in length has red blocks with a minimum length of three units placed on it, 
# such that any two red blocks (which are allowed to be different lengths) are separated by at least one black square. 
# There are exactly seventeen ways of doing this.
# []
# How many ways can a row measuring fifty units in length be filled?
# NOTE: Although the example above does not lend itself to the possibility, in general it is permitted to mix block sizes. 
# For example, on a row measuring eight units in length you could use red (3), black (1), and red (4).

start_time = Time.now

# PROGRAM START #

$r_count = 0

def r_combinations(start_color, len, is_recurse = true)
    $r_count += 1
    raise "r_combinations() overflow" if $r_count > 1_000_000
    # if len < 3
    #     raise "invalid length #{len}"
    # end
    if len <= 3
        # print "#{len}#{start_color}"
        return 1
    end
    if start_color == "b"
        combinations = 0
        (1..len-3).each do |b_count|
            # print "#{b_count}b>"
            remainder_count = r_combinations("r", len-b_count)
            combinations += remainder_count
            # if !is_recurse
            #     puts "(#{remainder_count})"
            # end
        end
        # print "#{len}b"
        # if !is_recurse
        #     puts
        # end
        combinations +=1 # full black
        return combinations
    else
        combinations = 0
        (3..len-1).each do |r_count|
            # print "#{r_count}r"
            remainder_count = r_combinations("b", len-r_count)
            combinations += remainder_count
            # if !is_recurse
            #     puts "(#{remainder_count})"
            # end
        end
        # print "#{len}r"
        # if !is_recurse
        #     puts
        # end
        combinations += 1 # full red
        return combinations
    end
end

# if ARGV[0]
#     n = ARGV[0].to_i
# else
#     n = 5
# end

# (5..20).each do |n|
#     count1 = r_combinations("r", n, false)
#     count2 = r_combinations("b", n, false)
#     count = count1 + count2
#     puts "#{n} :  #{count}"

# end

pp_count = r_combinations("r", 8, false) + r_combinations("b", 8, false)
p_count = r_combinations("r", 9, false) + r_combinations("b", 9, false)

(10 .. 50).each do |n|
    if n%3 == 0
        count = p_count + pp_count
    elsif n%6 < 3
        count = p_count + pp_count - 1
    else
        count = p_count + pp_count + 1
    end
    puts "#{n} : #{count}"
    pp_count = p_count
    p_count = count
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

