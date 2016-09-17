# PROBLEM STATEMENT

# By starting at the top of the triangle below and moving to adjacent numbers on the row below, the maximum total from top to bottom is 23.

# 3
# 7 4
# 2 4 6
# 8 5 9 3

# That is, 3 + 7 + 4 + 9 = 23.

# Find the maximum total from top to bottom in triangle.txt (right click and 'Save Link/Target As...'), a 15K text file containing a triangle with one-hundred rows.

# NOTE: This is a much more difficult version of Problem 18. It is not possible to try every route to solve this problem, as there are 299 altogether! If you could check one trillion (1012) routes every second it would take over twenty billion years to check them all. There is an efficient algorithm to solve it. ;o)


# Approach

# We dont need path, just the total
# Go to last row, add up to prev row, whichever are bigger of the adjacent numbers
# Repeat till the top row


start_time = Time.now

# PROGRAM START #

triangle = IO.readlines("./p067_triangle.txt")
triangle.map! do |row|
    row.chomp!
    row.split(' ').map(&:to_i)
end

last_row = triangle.size - 1

last_row.downto(1) do |row|
    (0..row-1).each do |col|
        cell = triangle[row][col]
        next_cell = triangle[row][col+1]
        larger_cell = [ cell, next_cell ].max
        triangle[row-1][col] += larger_cell
    end
end

puts triangle[0][0]

# PROGRAM END #

end_time = Time.now
diff_time = end_time - start_time

puts
puts "TECHNICAL"
puts
puts "Start time: #{start_time}"
puts "End time: #{end_time}"
puts "elapsed time: #{diff_time}"

