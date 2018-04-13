true.

% learning f/2
% clauses: 1
% NEW BOUND: 89
% clauses: 2
% NEW BOUND: 87
% clauses: 3
% NEW BOUND: 85
% NEW BOUND: 84
% clauses: 4
% NEW BOUND: 83
% NEW BOUND: 81
% clauses: 5
% NEW BOUND: 79
% NEW BOUND: 77
% NEW BOUND: 73
% clauses: 6
% NEW BOUND: 71
% NEW BOUND: 69
% NEW BOUND: 65
% NEW BOUND: 57
f(A,B):-f_1(A,C),f_5(C,B).
f_1(A,B):-f_2(A,C),f_2(C,B).
f_2(A,B):-f_3(A,C),f_3(C,B).
f_3(A,B):-f_4(A,C),f_4(C,B).
f_4(A,B):-tail(A,C),tail(C,B).
f_5(A,B):-dropWhile(A,B,not_number).
% program cost: 57
true.


