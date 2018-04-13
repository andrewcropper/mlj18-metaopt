true.

% learning f/2
% clauses: 1
% clauses: 2
% clauses: 3
% is better: 66
% is better: 56
% clauses: 4
% is better: 54
% is better: 53
% clauses: 5
% is better: 52
% is better: 50
% is better: 48
% is better: 45
% clauses: 6
% is better: 40
% is better: 35
% is better: 30
f(A,B):-tail(A,C),f_1(C,B).
f_1(A,B):-f_2(A,C),dropLast(C,B).
f_2(A,B):-f_3(A,C),f_3(C,B).
f_3(A,B):-tail(A,C),f_4(C,B).
f_4(A,B):-f_5(A,C),f_5(C,B).
f_5(A,B):-tail(A,C),tail(C,B).
true.


