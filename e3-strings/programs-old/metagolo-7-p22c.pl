true.

% learning f/2
% clauses: 1
% clauses: 2
% clauses: 3
% clauses: 4
% NEW BOUND: 1
% clauses: 5
% NEW BOUND: 0
% clauses: 6
f(A,B):-f_1(A,C),f_1(C,B).
f_1(A,B):-f_2(A,C),f_3(C,B).
f_2(A,B):-takeWhile(A,B,is_letter).
f_2(A,B):-dropWhile(A,B,not_space).
f_3(A,B):-dropWhile(A,B,not_letter).
% program cost: 0
true.


