{- What is the largest prime factor of the number 600851475143 ? -}

main = print . factor 600851475143 $ 2
    where
        factor n i
            | i^2 > n       = n
            | mod n i == 0  = factor (div n i) i
            | otherwise     = factor n (i+1)

