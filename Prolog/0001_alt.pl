% Find the sum of all the multiples of 'a' or 'b' below 'Limit'.


% Fastest version

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


% Alternative version b
euler1b(A, B, End):-
  parSum(A, End, A, Total1),
  parSum(B, End, B, A, Total2),
  Total is Total2 + Total1,
  writeln(Total).
parSum(N, Limit, _, 0) :- N >= Limit, !.
parSum(Start, Limit, N, Total) :-
  Next is Start + N,
  parSum(Next, Limit, N, SemiTotal),
  Total is SemiTotal + Start, !.
parSum(N, Limit, _, _, 0) :- N >= Limit, !.
parSum(Start, Limit, N, A, Total) :-
  not(divisibleA(Start, A)), !,
  Next is Start + N,
  parSum(Next, Limit, N, A, SemiTotal),
  Total is SemiTotal + Start, !.
parSum(Start, Limit, N, A, Total) :-
  Next is Start + N,
  parSum(Next, Limit, N, A, Total).

divisibleA(N, A) :-
    N mod A =:= 0.


% Alternative version c
euler1c(A, B, Limit) :- 
  setof(X, euler1_p(X, A, B, Limit), L),   
  sumlist(L, R),
  writeln(R).
  
euler1_p(N, A, B, Limit) :- 
  between(1, Limit, N), 
  divisibleAorB(N, A, B).

divisibleAorB(N, A, _) :-
  N mod A =:= 0, !.
divisibleAorB(N, _, B) :-
  N mod B =:= 0.


% Alternative version d
euler1d(A, B, End):-
  sum(End, A, B, Total),
  writeln(Total).
sum(0, _, _, 0) :- !. 
sum(Start, A, B, Total) :-
  divisibleAorB(Start, A, B), !,
  Next is Start - 1,
  sum(Next, A, B, SemiTotal),
  Total is SemiTotal + Start, !.
sum(Start, A, B, Total) :-
  Next is Start - 1,
  sum(Next, A, B, Total).


% Alternative version e
euler1e(A, B, Limit) :- 
  euler1e(1, A, B, Limit, L),
  sumlist(L, X),
  writeln(X).

euler1e(Limit, _, _, Limit, [ ]) :- !.
euler1e(N, A, B, Limit, [N|Ls]) :-
  N < Limit,
  euler1_p(N, A, B, Limit),
  N1 is N + 1,
  euler1e(N1, A, B, Limit, Ls), !.
euler1e(N, A, B, Limit, L) :-
  N < Limit,
  N1 is N + 1,
  euler1e(N1, A, B, Limit, L).


% Alternative version f
euler1f(A, B, Limit) :- 
  listToN(A, Limit, A, LA),
  listToN(B, Limit, B, LB),
  union(LA, LB, L),
  sumlist(L, X),
  writeln(X).

listToN(N, Limit, _, []) :- N >= Limit, !.
listToN(N, Limit, A, [N|L]) :- 
  N1 is N + A,
  listToN(N1, Limit, A, L).



main :-
  nl, A is 3, B is 5, Limit is 1000000,

  set_prolog_flag(gc_margin, 0),
  set_prolog_flag(gc, false),
  write("Result euler1: "), time(euler1(A, B, Limit)), nl,
  write("Result euler1b: "), time(euler1b(A, B, Limit)), nl,
  write("Result euler1c: "), time(euler1c(A, B, Limit)), nl,
  write("Result euler1d: "), time(euler1d(A, B, Limit)), nl,
  write("Result euler1e: "), time(euler1e(A, B, Limit)), nl,
  %write("Result euler1f: "), time(euler1f(A, B, Limit)), nl, % Very slow
  clear,
  nl.

clear :-
  set_prolog_flag(gc, true), trim_stacks, set_prolog_flag(gc, false).


:- initialization(main).
