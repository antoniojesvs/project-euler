% Find the sum of all the multiples of 3 or 5 below 1000.

gcd(X, X, X). % Greater common divisor
gcd(X, Y, G) :- 
  X < Y, 
  Y1 is Y - X, 
  gcd(X, Y1, G), !. 
gcd(X, Y, G) :- X > Y, gcd(Y, X, G).

lcm(X,Y,LCM):-gcd(X,Y,GCD), LCM is X*Y//GCD. % Least common multiple

sci(N, R) :- N1 is N + 1, R is (N * N1)//2. % Sum One to N

euler1(A, B, Limit) :-
  sci(Limit//A, SCI_A),
  sci(Limit//B, SCI_B),
  lcm(A, B, LCM_AB),
  sci(Limit//LCM_AB, SCI_LCM_AB),
  R is A*(SCI_A) + B*(SCI_B) - LCM_AB*(SCI_LCM_AB),
  writeln(R),!.

main :-
  euler1(3, 5, 1000).

:- initialization(main).