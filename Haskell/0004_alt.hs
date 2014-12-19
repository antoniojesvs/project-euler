module Main where

import Data.List.Ordered (mergeAllBy) {-- data-ordlist package --}
import Data.List (transpose)
import Data.Ord
import Control.Applicative
import System.Environment 
import Control.Exception
import Data.Time

{- Find the largest palindrome made from the product of two N-digit numbers -}

euler4 :: Integer -> IO ()
euler4 n = print $ getBigger [map (x *) xs | x <- xs] 
    where
        getBigger = head . filter isPalindrome . mergeAllBy (comparing negate)
        xs = [end,(end - 1)..ini]
        (end, ini) = ((10^n) - 1, 10^(n-1))
        isPalindrome = (==) <*> reverse <$> show

euler4b :: Integer -> IO ()
euler4b n = print . maximum $ [x | y<-[ini..end], z<-[y..end], let x=y*z, let s=show x, s==reverse s]
    where
        (end, ini) = ((10^n) - 1, 10^(n-1))

main = run `catch` handler

run :: IO ()  
run = do
    args <- getArgs
    let argsi = [read x:: Integer| x <- take 1 args]
        defaults = [3]
        params = map head $ transpose [argsi, defaults]
        (n:_) = params
    
    putStr "\nParams: "; print params
    putStr "\nResult euler4: "; time $ euler4 n
    putStr "\nResult euler4b: "; time $ euler4b n

handler :: SomeException -> IO ()  
handler e = putStrLn $ "Error. Usage: runhaskell 0004_alt.hs 3"

time :: IO () -> IO ()
time a = do
    start <- getCurrentTime
    a
    stop   <- getCurrentTime
    let diff = diffUTCTime stop start
    putStr "Computation time: "
    print diff

