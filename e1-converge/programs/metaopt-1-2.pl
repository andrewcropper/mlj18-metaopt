true.

true.

% learning f/2
% clauses: 1
% clauses: 2
% is better: 42
% clauses: 3
% clauses: 4
% clauses: 5
% timeout
f(A,B):-head(A,B),f_1(A,B).
f_1(A,B):-tail(A,C),element(C,B).
true.


