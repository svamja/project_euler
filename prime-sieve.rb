start_time = Time.now

$factors_sieve = []

def sieve_factors_setup(n)
    # source: http://www.drmaciver.com/2012/08/sieving-out-prime-factorizations/
    $factors_sieve = Array.new(n+1, 0)
    i = 2
    while i*i < n
        if $factors_sieve[i] == 0
            q = i
            (q..n).step(q) do |r|
                $factors_sieve[r] = i
            end
        end
        i += 1
    end
end

num = ARGV[0] ? ARGV[0].to_i : 100
sieve_factors_setup(num)

b = $factors_sieve.pack('S*')
File.binwrite(ENV['HOME'] + "/tmp/t2.bin", b)


end_time = Time.now
diff_time = end_time - start_time
puts
puts "elapsed time: #{diff_time}"
