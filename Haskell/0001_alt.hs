module Main where

import qualified Data.List.Ordered as LO {-- data-ordlist package --}
import qualified Data.Set as Set
import Data.List
import System.Environment 
import Control.Exception
import Data.Time

{- Find the sum of all the multiples of 'a' or 'b' below 'limit' -}

euler1 :: (Integral a, Show a) => a -> a -> a -> IO ()
euler1 a b limit = print $ sumStep a limit + sumStep b limit - sumStep (lcm a b) limit
	where
		sumStep s n = s * sumOnetoN (n `div` s)
		sumOnetoN n = n * (n+1) `div` 2

euler1b :: (Integral a, Show a) => a -> a -> a -> IO ()
euler1b a b limit = print . sum . takeWhile (limit >=) $ LO.union [a,(a+a)..] [b,(b+b)..]

euler1c :: (Integral a, Show a) => a -> a -> a -> IO ()
euler1c a b limit = print . sum . Set.elems $ Set.union aa bb
	where
		aa = Set.fromList [a,(a+a)..limit]
		bb = Set.fromList [b,(b+b)..limit]

euler1d :: (Integral a, Show a) => a -> a -> a -> IO ()
euler1d a b limit = print . sum $ [x | x <- [3..limit], mod x a == 0 || mod x b == 0]

euler1e :: (Integral a, Show a) => a -> a -> a -> IO ()
euler1e a b limit = print . sum  $ union [a,(a+a)..limit] [b,(b+b)..limit]

main = run `catch` handler

run :: IO ()  
run = do
	args <- getArgs
	let params = map head $ transpose [argsi, defaults]
		where 
			argsi = [read x:: Integer| x <- take 3 args]
			defaults = [3, 5, 1000000]
	let (a:b:limit:_) = params
	
	putStr "\nParams: "; print params
	putStr "\nResult euler1: "; time $ euler1 a b (limit - 1)
	putStr "\nResult euler1b: "; time $ euler1b a b (limit - 1)
	putStr "\nResult euler1c: "; time $ euler1c a b (limit - 1)
	putStr "\nResult euler1d: "; time $ euler1d a b (limit - 1) 
	--putStr "\nResult euler1e: "; time $ euler1e a b (limit - 1) -- Very slow

handler :: SomeException -> IO ()  
handler e = putStrLn $ "Error. Usage: runhaskell 0001_alt.hs 3 5 1000"

time :: IO () -> IO ()
time a = do
    start <- getCurrentTime
    a
    stop   <- getCurrentTime
    let diff = diffUTCTime stop start
    putStr "Computation time: "
    print diff

