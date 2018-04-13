true.

true.

% learning f/2
% clauses: 1
% clauses: 2
% clauses: 3
% is better: 107
% timeout
f(A,B):-tail(A,C),f_1(C,B).
f_1(A,B):-head(A,B),f_2(A,B).
f_2(A,B):-tail(A,C),element(C,B).
true.


