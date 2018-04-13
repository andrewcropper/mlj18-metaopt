true.

true.

% learning f/2
% clauses: 1
% clauses: 2
% clauses: 3
% is better: 2336
% clauses: 4
% is better: 1724
% is better: 1250
% clauses: 5
% timeout
f(A,B):-head(A,B),f_2(A,B).
f(A,B):-f_1(A,C),f(C,B).
f_1(A,B):-tail(A,C),tail(C,B).
f_2(A,B):-tail(A,C),element(C,B).
true.


