true.

% learning f/2
% clauses: 1
% clauses: 2
% clauses: 3
% NEW BOUND: 66
% NEW BOUND: 56
% clauses: 4
% NEW BOUND: 54
% clauses: 5
% NEW BOUND: 52
% NEW BOUND: 50
% NEW BOUND: 48
% NEW BOUND: 45
% clauses: 6
% NEW BOUND: 40
% NEW BOUND: 35
% NEW BOUND: 30
f(A,B):-tail(A,C),f_1(C,B).
f_1(A,B):-f_2(A,C),dropLast(C,B).
f_2(A,B):-f_3(A,C),f_3(C,B).
f_3(A,B):-tail(A,C),f_4(C,B).
f_4(A,B):-f_5(A,C),f_5(C,B).
f_5(A,B):-tail(A,C),tail(C,B).
% program cost: 30
true.


