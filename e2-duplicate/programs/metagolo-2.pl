true.

true.

% learning f/2
% clauses: 1
% clauses: 2
% clauses: 3
% is better: 1
% clauses: 4
% clauses: 5
% clauses: 6
f(A,B):-tail(A,C),f(C,B).
f(A,B):-head(A,B),f_1(A,B).
f_1(A,B):-tail(A,C),element(C,B).
true.


