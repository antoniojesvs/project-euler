{- There exists exactly one Pythagorean triplet a^2 + b^2 = c^2 for which a + b + c = 1000.
 - Find the product abc.
 -}

main = print . head $ [a*b*c | a <-[1..], b <-[a..1000-a], c <-[1000-a-b], a^2 + b^2 == c^2]
