import time


# it can be seen that all hexagonal are triangular.
# we will just walk through hexagonal and pentagonal numbers

start_time = time.time()

i_penta = 166
i_hexa = 144

while True:
    penta = (i_penta*(3*i_penta - 1))/2
    hexa = i_hexa*(2*i_hexa - 1)
    if penta == hexa:
        print i_penta, i_hexa, penta, hexa
        break
    if penta < hexa:
        i_penta += 1
        continue
    else:
        i_hexa += 1
        continue


end_time = time.time()
print "Time: ", round(end_time - start_time, 3)

