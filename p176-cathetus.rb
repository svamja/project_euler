$primes = [2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83,89,97,101]

$prime_logs = $primes.map { |p| Math::log(p) }

def get_divisors(num)
    d = [1]
    for i in 2..num/2
        d.push i if num % i == 0
    end
    d.push num
    return d
end

def get_products_r(n)
    n_div = get_divisors(n)
    p_list = []
    for f1 in n_div
        next if f1 == 1
        f2 = n/f1
        next if f2 < f1
        p_list.push [f1,f2]
        f2_list = get_products_r(f2)
        for f2_tail in f2_list
            p_list.push [f1]+f2_tail
        end
    end
    return p_list
end

def get_products(n)
    p_list = [[1,n]] + get_products_r(n)
    p_list.map! { |x| x.sort! { |a,b| b <=> a } }
    p_list.uniq!
    return p_list
end

def get_powers(n)
    m = 2*n + 1
    p_list = []
    # considering even
    m_div = get_divisors(m)
    for k in m_div
        a = k+2
        b = m/k
        if b == 1
            p_list.push [a]
            break
        end
        b_list = get_products(b)
        for bp in b_list
            p_list.push [a] + bp
        end
    end
    # considering odd
    m_list = get_products(m)
    for mp in m_list
        p_list.push [1] + mp
    end
    return p_list
end

def get_lowest_cati(n)
    p_list = get_powers(n)
    l_list = []
    l_min = 999_999_999
    i_min = 0
    for i in 0..p_list.length-1
        pw_list = p_list[i]
        log_sum = 0
        for j in 0..pw_list.length-1
            log_sum += (pw_list[j]-1)*$prime_logs[j]
        end
        l_list[i] = log_sum
        if log_sum < l_min
            l_min = log_sum
            i_min = i
        end
    end
    min_num = 1
    for j in 0..(p_list[i_min].length-1)
        min_num *= $primes[j]**((p_list[i_min][j]-1)/2)
    end
    return min_num
end

puts "time 1 = #{Time.now}"

puts get_lowest_cati(47547).inspect

puts "time 2 = #{Time.now}"
