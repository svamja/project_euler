# PROBLEM STATEMENT

# The minimal path sum in the 5 by 5 matrix below, by starting in any cell in the left column and finishing in any cell in the right column, and only moving up, down, and right, is indicated in red and bold; the sum is equal to 994.

# ⎛⎝⎜⎜⎜⎜⎜⎜131201630537805673968036997322343427464975241039654221213718150111956331⎞⎠⎟⎟⎟⎟⎟⎟
# Find the minimal path sum, in matrix.txt (right click and "Save Link/Target As..."), a 31K text file containing a 80 by 80 matrix, from the left column to the right column.

# Approach 

start_time = Time.now

# PROGRAM START #

matrix = IO.readlines('./p082_matrix.txt')
matrix.map! do |row|
    row.chomp!
    row.split(',').map(&:to_i)
end

# matrix = [
#     [131, 673, 234, 103, 18],
#     [1, 1, 342, 965, 150],
#     [630, 1, 746, 422, 111],
#     [537, 1, 8999, 1, 1],
#     [805, 1, 55, 33, 22]
# ]

size = matrix.size

(size-2).downto(0) do |col|
    alt_column = []
    (0..size-1).each do |row|
        alt_column.push matrix[row][col]
        # for first row, simply add right side's value for now
        if row == 0 
            matrix[row][col] += matrix[row][col+1]
            next
        end
        # if the value above is lower than on the right, add that
        if matrix[row][col] + matrix[row-1][col] < matrix[row][col] + matrix[row][col+1]
            matrix[row][col] += matrix[row-1][col]
        else
            matrix[row][col] += matrix[row][col+1]
        end
    end
    (size-1).downto(0) do |row|
        # for last row, add right side's value
        if row == size-1
            alt_column[row] += matrix[row][col+1]
            next
        end
        # if the value below is lower than current, replace it
        if alt_column[row] + alt_column[row+1] < matrix[row][col]
            matrix[row][col] = alt_column[row] + alt_column[row+1]
            alt_column[row] = matrix[row][col]
        else
            alt_column[row] += matrix[row][col+1]
        end
    end
end

first_column = matrix.map { |row| row[0] }

puts first_column.min


# PROGRAM END #

end_time = Time.now
diff_time = end_time - start_time

puts
puts "TECHNICAL"
puts
puts "Start time: #{start_time}"
puts "End time: #{end_time}"
puts "elapsed time: #{diff_time}"

