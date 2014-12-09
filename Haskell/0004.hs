{- Find the largest palindrome made from the product of two 3-digit numbers -}
 
main = print . maximum $ [x | y<-[100..999], z<-[y..999], let x=y*z, let s=show x, s==reverse s]


