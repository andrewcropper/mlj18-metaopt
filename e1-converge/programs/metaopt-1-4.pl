true.

true.

% learning f/2
% clauses: 1
% clauses: 2
% clauses: 3
% is better: 2405
% clauses: 4
% is better: 1758
% is better: 516
% is better: 515
% clauses: 5
% timeout
f(A,B):-f_1(A,B),head(A,B).
f(A,B):-tail(A,C),f(C,B).
f_1(A,B):-tail(A,C),f_2(C,B).
f_2(A,B):-tail(A,C),head(C,B).
true.


