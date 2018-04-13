true.

% learning f/2
% clauses: 1
% NEW BOUND: 73
% clauses: 2
% NEW BOUND: 71
% clauses: 3
% NEW BOUND: 69
% clauses: 4
% NEW BOUND: 67
% NEW BOUND: 65
% NEW BOUND: 53
% clauses: 5
% NEW BOUND: 33
% clauses: 6
f(A,B):-tail(A,C),f_1(C,B).
f_1(A,B):-f_2(A,C),f_2(C,B).
f_2(A,B):-f_3(A,C),f_3(C,B).
f_3(A,B):-f_4(A,C),f_4(C,B).
f_4(A,B):-tail(A,C),tail(C,B).
% program cost: 33
true.


