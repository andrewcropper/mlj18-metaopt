true.

true.

% learning f/2
% clauses: 1
% clauses: 2
% clauses: 3
% is better: 54
% clauses: 4
% is better: 50
% is better: 18
% clauses: 5
% clauses: 6
f(A,B):-f_1(A,C),head(C,B).
f_1(A,B):-f_2(A,C),f_2(C,B).
f_2(A,B):-f_3(A,C),f_3(C,B).
f_3(A,B):-tail(A,C),tail(C,B).
true.


