true.

% learning f/2
% clauses: 1
% clauses: 2
% NEW BOUND: 3
% NEW BOUND: 1
% clauses: 3
% clauses: 4
% clauses: 5
% clauses: 6
f(A,B):-myreverse(A,C),f_1(C,B).
f_1(A,B):-filter(A,B,is_letter).
% program cost: 1
true.


