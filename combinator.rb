def do_something(c)
    p c
end

def combinations_array(a, n)
    if n == a.size
        return [a]
    end
    if n == 1
        combinations = []
        a.each { |n| combinations.push([n]) }
        return combinations
    end
    if n < 1 || n > a.size
        raise "invalid arguments for combinations()"
    end

    upper_bound = a.size - n
    combinations = []
    (0..upper_bound).each do |i|
        first_element = a[i]
        remaining_elements = a[i+1..-1]
        remaining_combinations = combinations_array(remaining_elements, n-1)
        remaining_combinations.each do |combination|
            combination.unshift(first_element)
            combinations.push(combination)
        end
    end
    return combinations
end


def combinations(a, n, &block)
    if n == a.size
        yield [a]
        return
    end
    if n == 1
        a.each do |n|
            value = yield [n]
            if value == "break"
                break
            end
        end
        return
    end
    if n < 1 || n > a.size
        raise "invalid arguments for combinations()"
    end

    upper_bound = a.size - n
    (0..upper_bound).each do |i|
        first_element = a[i]
        remaining_elements = a[i+1..-1]
        remaining_combinations = combinations(remaining_elements, n-1)
        remaining_combinations.each do |combination|
            combination.unshift(first_element)
            combinations.push(combination)
        end
    end
    return combinations
end

$rec_calls = 0

def rec_combinations(offset, a, n, &block)
    $rec_calls += 1
    if $rec_calls > 100_000
        return
    end
    if n == a.size
        value = yield offset + a
        return value
    end

    if n == 1
        return_value = ""
        i = 0
        a.each do |n|
            value = yield offset + [n]
            if value == "break"
                if i == 0
                    return_value = "break"
                end
                break
            end
            i += 1
        end
        return return_value
    end

    upper_bound = a.size - n
    return_break = false
    (0..upper_bound).each do |i|
        return_value = rec_combinations(offset + [a[i]], a[i+1..-1], n-1, &block)
        if return_value == "break"
            if i == 0
                return_break = true
            end
            break
        end
    end
    if return_break
        return "break"
    end
end
