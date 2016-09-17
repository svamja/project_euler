# PROBLEM STATEMENT


# Approach 


start_time = Time.now

# PROGRAM START #

file = open('./p042_words.txt', 'rb')
all_words = file.read
all_words.tr!('"', '')
words = all_words.split(',')

words.map! do |word|
    sort_word = word.split('').sort.join
    [sort_word, word]
end

words.sort!

anagrams = []

prev_word = [""]
anagram = []
words.each do |word|
    if prev_word[0] == word[0]
        anagram.push prev_word[1]
    else
        if anagram.size > 0
            anagram.push prev_word[1]
            anagrams.push anagram
        end
        anagram = []
    end
    prev_word = word
end

anagrams.map! do |anagram|
    size = anagram[0].size
    [size, anagram]
end

anagrams.sort!


iteration_count = 0

ranges = []
(2..15).each do |size|
    lower_bound = Math::sqrt(10**(size-1)).to_i - 1
    upper_bound = Math::sqrt(10**size).to_i + 1
    ranges[size] = (lower_bound..upper_bound)
end

anagrams.each do |anagram|
    anagram_words = anagram[1]
    size = anagram[0]
    range = ranges[size]
    range.each do |n|
        square = n*n
        square_digits = square.to_s.split('')
        next if square_digits.size < size
        break if square_digits.size > size
        iteration_count += 1
        word1 = anagram_words[0]
        word2 = anagram_words[1]
        word1_letters = word1.split('')
        hash = Hash[word1_letters.zip square_digits]
        # reverse hash to check no two letters map to same digit
        hash2 = Hash[hash.to_a.map { |kv| kv.reverse }]
        next if hash2.size < hash.size
        word2_letters = word2.split('')
        word2_digits = word2_letters.map { |letter| hash[letter] }
        next if word2_digits[0] == "0"
        number2 = word2_digits.join.to_i
        root2 = Math::sqrt(number2)
        if(root2 % 1 == 0)
            puts "#{word1} : #{word2} : #{square} : #{number2}"
        end
    end
end

puts "iteration count: #{iteration_count}"

# PROGRAM END #

end_time = Time.now
diff_time = end_time - start_time

puts
puts "TECHNICAL"
puts
puts "Start time: #{start_time}"
puts "End time: #{end_time}"
puts "elapsed time: #{diff_time}"

