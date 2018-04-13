true.

% learning f/2
% clauses: 1
% clauses: 2
% clauses: 3
% NEW BOUND: 65
% NEW BOUND: 55
% clauses: 4
% NEW BOUND: 53
% NEW BOUND: 52
% clauses: 5
% NEW BOUND: 51
% NEW BOUND: 49
% NEW BOUND: 47
% NEW BOUND: 44
% clauses: 6
% NEW BOUND: 39
% NEW BOUND: 34
% NEW BOUND: 29
f(A,B):-tail(A,C),f_1(C,B).
f_1(A,B):-f_2(A,C),dropLast(C,B).
f_2(A,B):-f_3(A,C),f_3(C,B).
f_3(A,B):-tail(A,C),f_4(C,B).
f_4(A,B):-f_5(A,C),f_5(C,B).
f_5(A,B):-tail(A,C),tail(C,B).
% program cost: 29
true.


