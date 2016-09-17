# PROBLEM STATEMENT

# The cube, 41063625 (345^3), can be permuted to produce two other cubes: 56623104 (384^3) and 66430125 (405^3). 
# In fact, 41063625 is the smallest cube which has exactly three permutations of its digits which are also cube.
# Find the smallest cube for which exactly five permutations of its digits are cube.

# Approach

# 101 to 999 -> cube -> sort digits -> put all in array -> sort the array, also multisort original cuberoots
# count occurence of same strings -> filter count == 5 -> get back the cubes
# get the min of the cubes

start_time = Time.now

# PROGRAM START #

lower_bound = 101
upper_bound = 9999

cube_strings = []

(lower_bound .. upper_bound).each do |n|
    cube = n*n*n
    cube_string = cube.to_s.split('').sort.join
    cube_strings.push cube_string
end

cube_strings.sort!

prev_string = ""
count = 0
filtered_strings = []

cube_strings.each do |cube_string|
    count += 1
    if cube_string != prev_string
        if count == 5
            filtered_strings.push prev_string
        end
        count = 0
    end
    prev_string = cube_string
end

(lower_bound .. upper_bound).each do |n|
    cube = n*n*n
    cube_string = cube.to_s.split('').sort.join
    if filtered_strings.include? cube_string
        puts n
        puts cube
        break
    end
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

