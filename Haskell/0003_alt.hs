module Main where

import Data.Numbers.Primes(primeFactors) {-- primes package--}
import Data.List (transpose)
import System.Environment 
import Control.Exception
import Data.Time

{- What is the largest prime factor of the number N ? -}

euler3 :: (Integral a, Show a) => a -> IO ()
euler3 n = print . maximum . primeFactors $ n

euler3b :: (Integral a, Show a) => a -> IO ()
euler3b n = print . pimfacs n $ (2:[3, 5..])
    where
        pimfacs n (i:xs)
            | i^2 > n       = n
            | mod n i == 0  = pimfacs (div n i) (i:xs)
            | otherwise     = pimfacs n (xs)

euler3c :: (Integral a, Show a) => a -> IO ()
euler3c n = print . pimfacs n $ 2
    where
        pimfacs n i
            | i^2 > n       = n
            | mod n i == 0  = pimfacs (div n i) i
            | otherwise     = pimfacs n (i+1)

main = run `catch` handler

run :: IO ()  
run = do
	args <- getArgs
	let params = map head $ transpose [argsi, defaults]
		where 
			argsi = [read x:: Integer| x <- take 1 args]
			defaults = [5999999999999999]

	let (n:_) = params
	
	putStr "\nParams: "; print params
	putStr "\nResult euler3: "; time $ euler3 n
	putStr "\nResult euler3b: "; time $ euler3b n
	putStr "\nResult euler3c: "; time $ euler3c n

handler :: SomeException -> IO ()  
handler e = putStrLn $ "Error. Usage: runhaskell 0003_alt.hs 600851475143"

time :: IO () -> IO ()
time a = do
	start <- getCurrentTime
	a
	stop   <- getCurrentTime
	let diff = diffUTCTime stop start
	putStr "Computation time: "
	print diff

