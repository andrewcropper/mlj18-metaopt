true.

% learning f/2
% clauses: 1
% clauses: 2
% clauses: 3
% clauses: 4
% clauses: 5
% NEW BOUND: 2
% clauses: 6
f(A,B):-myreverse(A,C),f_1(C,B).
f_1(A,B):-f_2(A,C),myreverse(C,B).
f_2(A,B):-f_3(A,C),f_4(C,B).
f_3(A,B):-filter(A,B,is_letter).
f_4(A,B):-takeWhile(A,B,is_uppercase).
% program cost: 2
true.


