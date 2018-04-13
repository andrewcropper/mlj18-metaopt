true.

% learning f/2
% clauses: 1
% clauses: 2
% is better: 1
% clauses: 3
% clauses: 4
% clauses: 5
% clauses: 6
f(A,B):-myreverse(A,C),f_1(C,B).
f_1(A,B):-myreverse(A,C),myreverse(C,B).
true.


