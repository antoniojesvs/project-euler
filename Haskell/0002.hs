{- By considering the terms in the Fibonacci sequence whose values do not exceed four million, 
   find the sum of the even-valued terms.-}

main = print (fibosum 0 1)
	where
		fibosum a b
			| b > 4000000 = 0
			| mod b 2 == 0 = b + fibosum b (a+b)
		fibosum a b = fibosum b (a+b)