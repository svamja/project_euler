import time
start_time = time.time()

# genius solution by tkiley
# 200X faster than what I attempted and is elegant too!

ceil = 1000000
preRemovedForDenominator = [ 0 ] * (ceil + 1)
fractionCount = 0

for i in xrange(2, ceil + 1):
    fractionsToAdd = i - i/2 - i/3 - 1
    fractionCount = fractionCount + fractionsToAdd
    numeratorsToRemove = fractionsToAdd - preRemovedForDenominator[i]
    for j in xrange(i*2, ceil + 1, i):
        fractionCount = fractionCount - numeratorsToRemove
        preRemovedForDenominator[j] = preRemovedForDenominator[j] + numeratorsToRemove

print fractionCount



end_time = time.time()
print "Time: ", round(end_time - start_time, 3)

