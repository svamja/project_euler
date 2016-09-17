def is_palindrome(str)
    i = 0
    j = str.size - 1
    if j == 0
        return true
    end
    while true
        return false if str[i] != str[j]
        i += 1
        j -= 1
        break if i > j
    end
    return true
end

puts Time.now

sum = 0

(1..1_000_000).step(2) do |n|
    if is_palindrome(n.to_s) && is_palindrome(n.to_s(2))
        puts n.to_s + ": " + n.to_s(2)
        sum += n
    end
end

puts sum

puts Time.now
