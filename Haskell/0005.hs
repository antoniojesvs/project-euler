{- What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20? -}

main = print . foldl1 lcm $ [1..20]