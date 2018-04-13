true.

% learning f/2
% clauses: 1
% NEW BOUND: 93
% clauses: 2
% NEW BOUND: 91
% clauses: 3
% NEW BOUND: 89
% NEW BOUND: 86
% clauses: 4
% NEW BOUND: 85
% NEW BOUND: 84
% clauses: 5
% NEW BOUND: 83
% NEW BOUND: 81
% NEW BOUND: 77
% clauses: 6
% NEW BOUND: 75
% NEW BOUND: 73
% NEW BOUND: 69
% NEW BOUND: 61
% NEW BOUND: 48
f(A,B):-f_1(A,C),f_3(C,B).
f_1(A,B):-f_2(A,C),f_3(C,B).
f_2(A,B):-dropWhile(A,B,is_letter).
f_3(A,B):-f_4(A,C),f_4(C,B).
f_4(A,B):-f_5(A,C),f_5(C,B).
f_5(A,B):-tail(A,C),tail(C,B).
% program cost: 48
true.


