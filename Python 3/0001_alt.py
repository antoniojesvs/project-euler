import time
import sys
from fractions import gcd

# Euler1: Find the sum of all the multiples of 'a' or 'b' below 'limit'.


def euler1(a, b, limit):
    def lcm(a, b):
        """ Least common multiple """
        return (a * b) // gcd(a, b)

    def sci(n):
        """ Sum of consecutive integers """
        return n * (n + 1) / 2

    lcm_ac = lcm(a, b)
    limit -= 1
    return (
        a * (sci(limit // a)) +
        b * (sci(limit // b)) -
        lcm_ac * (sci(limit // lcm_ac))
    )


def euler1b(a, b, limit):
    s1 = set(range(a, limit, a))
    s2 = set(range(b, limit, b))
    ss = s1.union(s2)
    return sum(ss)


def euler1c(a, b, limit):
    return sum(
        [x for x in range(min(a, b), limit) if x % a == 0 or x % b == 0]
    )


def main():
    # take input from the user
    try:
        a, b, limit = map(int, sys.argv[1:4])
    except ValueError:
        a, b, limit = [3, 5, 1000000]
    print ("\nParams:", a, b, limit)

    for func in [euler1, euler1b, euler1c]:
        start_time = time.time()
        print (
            "\nResult {version_name}: {result}".format(
                version_name=func.__name__,
                result=func(a, b, limit)
            )
        )
        print ("--- {} seconds ---".format(time.time() - start_time))

if __name__ == "__main__":
    main()
