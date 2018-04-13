true.

true.

% learning f/2
% clauses: 1
% clauses: 2
% clauses: 3
% is better: 315
% clauses: 4
% is better: 292
% timeout
f(A,B):-tail(A,C),f_1(C,B).
f_1(A,B):-head(A,B),f_2(A,B).
f_1(A,B):-tail(A,C),f_1(C,B).
f_2(A,B):-tail(A,C),element(C,B).
true.


