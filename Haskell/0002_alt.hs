module Main where

import Data.List (transpose)
import Data.Numbers.Fibonacci {-- fibonacci package --}
import System.Environment 
import Control.Exception
import Data.Time

{- By considering the terms in the Fibonacci sequence whose values do not exceed N, 
   find the sum of the even-valued terms.-}

euler2 :: (Integral a, Show a) => a -> IO ()
euler2 n = print . sum . filter even . takeWhile (< n) $ fibs
	where
		fibs = 1 : 1 : zipWith (+) fibs (tail fibs)
		-- fibs = 0 : scanl (+) 1 fibs

euler2b :: (Integral a, Show a) => a -> IO ()
euler2b n = print (ficont 1 1)
	where
		ficont a b 
			| b > n = 0
			| mod b 2 == 0 = b + ficont b (a+b)
		ficont a b = ficont b (a+b)

euler2c :: (Integral a, Show a) => a -> IO ()
euler2c n = print . sum . filter even . takeWhile (n >) . map fib $ [1..]

main = run `catch` handler

run :: IO ()  
run = do
	args <- getArgs
	let params = map head $ transpose [argsi, defaults]
		where 
			argsi = [read x:: Integer| x <- take 1 args]
			defaults = [10^100]

	let (n:_) = params
	
	putStr "\nParams: "; print params
	putStr "\nResult euler2: "; time $ euler2 n
	putStr "\nResult euler2b: "; time $ euler2b n
	putStr "\nResult euler2c: "; time $ euler2c n

handler :: SomeException -> IO ()  
handler e = putStrLn $ "Error. Usage: runhaskell 0002_alt.hs 4000000"

time :: IO () -> IO ()
time a = do
	start <- getCurrentTime
	a
	stop   <- getCurrentTime
	let diff = diffUTCTime stop start
	putStr "Computation time: "
	print diff

