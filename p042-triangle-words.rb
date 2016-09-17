start_time = Time.now

# START #

$triangle_numbers = []
$triangle_number_max = 0

def seed_triangle_numbers(bound)
    (1..bound).each do |n|
        term = n*(n+1)/2
        $triangle_numbers.push(term)
        $triangle_number_max = term
    end
end

seed_triangle_numbers(20)
puts $triangle_number_max

file = open('p042_words.txt', 'rb')
all_words = file.read
all_words.tr!('"', '')
words = all_words.split(',')
word_count = 0
word_sum_max = 0
triangle_word_count = 0

words.each do |word|
    word_count += 1
    word_sum = 0
    word.each_byte do |c|
        word_sum += c - 64
    end
    if $triangle_numbers.include? word_sum
        triangle_word_count += 1
    end
    word_sum_max = word_sum if word_sum_max < word_sum
end

puts "Total Words: #{word_count}"
puts "Max Word Sum: #{word_sum_max}"
puts "Total Triangle Words: #{triangle_word_count}"

# END #

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

