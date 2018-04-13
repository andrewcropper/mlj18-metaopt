true.

% learning f/2
% clauses: 1
% clauses: 2
f(A,B):-myreverse(A,C),f_1(C,B).
f_1(A,B):-myreverse(A,C),myreverse(C,B).
true.


