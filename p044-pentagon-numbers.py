import time

start_time = time.time()

def pentagon(n):
    return n*(3*n - 1)/2

p_seeds = [ 0 ]

DIV_COUNT = 999
IT_COUNT = 1099

for i in xrange(1, DIV_COUNT):
    p_seeds.append(pentagon(i))

for i_num in xrange(1000, IT_COUNT):
    p_num = pentagon(i_num)
    i_firsts = set()
    i_seconds = set()
    diffs = []
    for i_distance in xrange(1, DIV_COUNT):
        divisor = i_distance*3
        subtractor = p_seeds[i_distance]
        if(p_num - subtractor < divisor): break
        if((p_num - subtractor) % divisor == 0):
            i_diff  =  i_num;
            i_first = (p_num - subtractor) / divisor;
            i_second = i_first + i_distance
            i_firsts.add(i_first)
            i_seconds.add(i_second)
            diffs.append([ i_diff, i_distance, i_first, i_second ])
    if len(i_firsts):
        for i_second in i_seconds:
            if i_second in i_firsts:
                print "bingo", i_num, i_second
                print diffs


end_time = time.time()
print "Time: ", round(end_time - start_time, 3)

