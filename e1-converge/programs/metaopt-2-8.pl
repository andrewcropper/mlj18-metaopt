true.

true.

% learning f/2
% clauses: 1
% clauses: 2
% clauses: 3
% is better: 2405
% timeout
f(A,B):-head(A,B),f_1(A,B).
f(A,B):-tail(A,C),f(C,B).
f_1(A,B):-tail(A,C),element(C,B).
true.


