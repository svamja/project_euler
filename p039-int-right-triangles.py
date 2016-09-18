
max_perimeter = 1001

perimeters = [0] * (max_perimeter + 1)

ops = 0
ints = 0

# Index perimeters by number of int solutions

for side1 in xrange(1, max_perimeter):
    for side2 in xrange(side1+1, max_perimeter - side1 + 1):
        hypo_square = side1*side1 + side2*side2
        ops += 1
        hypo = hypo_square**0.5
        if hypo.is_integer():
            ints += 1
            p = int(hypo) + side1 + side2
            if p > max_perimeter: break
            perimeters[p] += 1

print ops
print ints
# print perimeters

# Get maximized perimeter

max_solutions = 0
max_perimeter = 0

for p in xrange(1, len(perimeters)):
    solutions = perimeters[p]
    if(solutions > max_solutions):
        max_solutions = solutions
        max_perimeter = p

print max_solutions
print max_perimeter




