true.

% learning f/2
% clauses: 1
% clauses: 2
% clauses: 3
% NEW BOUND: 50
% clauses: 4
% NEW BOUND: 48
% NEW BOUND: 39
% clauses: 5
% clauses: 6
f(A,B):-f_1(A,C),f_3(C,B).
f_1(A,B):-f_2(A,C),tail(C,B).
f_2(A,B):-dropWhile(A,B,is_number).
f_3(A,B):-takeWhile(A,B,is_letter).
% program cost: 39
true.


