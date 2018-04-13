true.

% learning f/2
% clauses: 1
% clauses: 2
% NEW BOUND: 35
% NEW BOUND: 28
% NEW BOUND: 17
% NEW BOUND: 16
% clauses: 3
% clauses: 4
% clauses: 5
% clauses: 6
f(A,B):-myreverse(A,C),f_1(C,B).
f_1(A,B):-dropWhile(A,B,is_uppercase).
% program cost: 16
true.


