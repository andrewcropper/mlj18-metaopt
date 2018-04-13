true.

true.

% learning f/2
% clauses: 1
% clauses: 2
% clauses: 3
% is better: 5346
% clauses: 4
% timeout
f(A,B):-tail(A,C),f(C,B).
f(A,B):-head(A,B),f_1(A,B).
f_1(A,B):-tail(A,C),element(C,B).
true.


