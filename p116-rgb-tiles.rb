# PROBLEM STATEMENT

# A row of five black square tiles is to have a number of its tiles replaced with coloured oblong tiles chosen 
# from red (length two), green (length three), or blue (length four).

# If red tiles are chosen there are exactly seven ways this can be done.

# If green tiles are chosen there are three ways.

# And if blue tiles are chosen there are two ways.

# Assuming that colours cannot be mixed there are 7 + 3 + 2 = 12 ways of replacing the black tiles in a row measuring 
# five units in length.
# How many different ways can the black tiles in a row measuring fifty units in length be replaced if colours 
# cannot be mixed and at least one coloured tile must be used?

start_time = Time.now

# PROGRAM START #

def ncr(n, r)
    a = 1
    b = 1
    (1..r).each do |k|
        a *= n
        b *= k
        n -= 1
    end
    ncr = a/b
end

def combinations(row_size, tile_size, tile_count)
    return 0 if tile_size*tile_count > row_size
    return 1 if tile_size*tile_count == row_size
    black_slots = tile_count + 1
    black_count = row_size - tile_size*tile_count
    combinations = ncr(black_slots + black_count - 1, black_slots - 1)
end


row_size = 50
total_combinations = 0

(2..4).each do |tile_size|
    (1..row_size/tile_size).each do |tile_count|
        combinations = combinations(row_size, tile_size, tile_count)
        total_combinations += combinations
    end
end

puts total_combinations



# PROGRAM END #

end_time = Time.now
diff_time = end_time - start_time

puts
puts "TECHNICAL"
puts
puts "Start time: #{start_time}"
puts "End time: #{end_time}"
puts "elapsed time: #{diff_time}"

