true.

% learning f/2
% clauses: 1
% clauses: 2
% clauses: 3
% NEW BOUND: 38
% clauses: 4
% NEW BOUND: 26
% clauses: 5
% clauses: 6
f(A,B):-tail(A,C),f_1(C,B).
f_1(A,B):-tail(A,C),f_2(C,B).
f_2(A,B):-tail(A,C),f_3(C,B).
f_3(A,B):-takeWhile(A,B,is_letter).
% program cost: 26
true.


