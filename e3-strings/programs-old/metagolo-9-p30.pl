true.

% learning f/2
% clauses: 1
% clauses: 2
% clauses: 3
% NEW BOUND: 0
% clauses: 4
% clauses: 5
% clauses: 6
f(A,B):-f_1(A,C),f_2(C,B).
f_1(A,B):-dropWhile(A,B,not_letter).
f_2(A,B):-takeWhile(A,B,is_letter).
% program cost: 0
true.


