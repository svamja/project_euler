$divisor_primes = [2, 3, 5, 7]
$divisor_bound = 10
$divisor_bound_square = 100
$is_prime_calls = 0
$is_prime_iterations = 0

$sieve_primes = []
$sieve_bound = 0

def is_prime_sieve(n)
    if n > $sieve_bound
        return is_prime(n)
    end
    $sieve_primes[n]
end

def sieve_setup(n)
    $sieve_primes = (0..n).map{|i| true}
    $sieve_primes[0] = false
    $sieve_primes[1] = false
    i = 0
    while i*i <= n
        if $sieve_primes[i]
            j = i*i
            while j <= n
                $sieve_primes[j] = false
                j += i
            end
        end
        i += 1
    end
    $sieve_bound = n
end

$factors_sieve

def sieve_factors_setup(n)
    # source: http://www.drmaciver.com/2012/08/sieving-out-prime-factorizations/
    $factors_sieve = (0..n).to_a.map { |x| [] }
    (2..n).each do |i|
        if $factors_sieve[i].size == 0
            q = i
            while q < n
                (q..n).step(q) do |r|
                    $factors_sieve[r].push(i)
                end
                q *= i
            end
        end
    end
end

def sieve_factors(n)
    if !$factors_sieve[n]
        return Prime.prime_division n
    end
    if $factors_sieve[n].size == 1
        return [$factors_sieve[n][0], 1]
    end
    factors = {}
    prev_factor = -1
    $factors_sieve[n].each do |factor|
        if factor != prev_factor
            factors[factor] = 1
        else
            factors[factor] += 1
        end
    end
    factors.to_a
end

def is_prime(number)
    $is_prime_calls  += 1

    if number <= $divisor_bound
        return true if $divisor_primes.include? number
        return false
    end

    $divisor_primes.each do |divisor|
        if number % divisor == 0
            return false
        end
    end
    if number <= $divisor_bound_square
        return true
    end

    $is_prime_iterations += 1
    upper_bound = Math::sqrt(number).to_i + 1
    lower_bound = $divisor_bound

    if lower_bound % 2 == 0
        lower_bound += 1
    end

    (lower_bound..upper_bound).step(2) do |divisor|
        if number % divisor == 0
            return false
        end
    end

    return true
end

def prime_factors(number)
    if number <= $divisor_bound
        return [[number, 1]] if $divisor_primes.include? number
    end

    factors = {}
    dividend = number
    $divisor_primes.each do |divisor|
        while dividend % divisor == 0
            factors[divisor] ||= 0
            factors[divisor] += 1
            dividend /= divisor
        end
        break if dividend < divisor
    end
    if dividend == 1
        return factors.to_a
    end
    if number > $divisor_bound
        seed_primes(number*5/4)
        return prime_factors(number)
    end
    raise "invalid state of prime_factors #{number}"
end



def seed_primes(upper_bound)

    return if(upper_bound <= $divisor_bound)

    lower_bound = $divisor_bound+1
    
    if lower_bound % 2 == 0
        lower_bound += 1
    end

    (lower_bound..upper_bound).step(2) do |number|
        if is_prime(number)
            $divisor_primes.push(number)
            $divisor_bound = number
            $divisor_bound_square = number*number
        end
    end

end


def factorize(number)
    return [],[] if number <= 2
    divider_stack = [2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,49]
    num_half = number/2
    factors = []
    factors_exp = []
    i = -1
    divisor = divider_stack.shift
    while divisor <= num_half
        if number % divisor == 0
            if factors[i] == divisor
                factors_exp[i] += 1
            else
                i += 1
                factors[i] = divisor
                factors_exp[i] = 1
            end
            number = number / divisor
            next
        end
        divisor = divider_stack.shift
        if divider_stack.length == 8
            (0..7).each { |j| divider_stack.push(divider_stack[j]+30) }
        end
    end
    return factors, factors_exp
end


def factors_count(number)
    return 0 if number <= 1

    if number <= $divisor_bound
        return 1 if $divisor_primes.include? number
    end

    dividend = number
    last_dividend = dividend
    count = 0
    $divisor_primes.each do |divisor|
        while dividend % divisor == 0
            dividend = dividend / divisor
        end
        if dividend != last_dividend
            count += 1
        end
        break if dividend == 1
        last_dividend = dividend
    end

    if dividend != 1
        if last_dividend < $divisor_bound_square
            # its a prime
            count += 1
        else
            raise "incomplete prime set"
        end
    end

    return count

end

