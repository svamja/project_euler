import time
start_time = time.time()

# alternative by froycard
# performance is not great, but simpler to understand

import math, time

def gcd(a, b):
    return a if b == 0 else gcd(b, a % b)
acc=0
start=time.time()
d=12001
for m in range(d-1,0,-1):
    lo=int(math.floor(m/3.))
    hi=int(math.ceil(m/2.))
    for n in range(hi,lo,-1):
        if gcd(m,n)==1:
            if 1.0/3 < float(n)/m <.5:
                acc+=1

print(acc)
print(time.time()-start)


end_time = time.time()
print "Time: ", round(end_time - start_time, 3)

