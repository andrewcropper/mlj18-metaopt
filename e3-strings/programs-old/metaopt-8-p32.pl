true.

% learning f/2
% clauses: 1
% clauses: 2
% clauses: 3
% clauses: 4
% NEW BOUND: 137
% NEW BOUND: 129
% clauses: 5
% NEW BOUND: 128
% NEW BOUND: 92
% clauses: 6
% NEW BOUND: 90
% NEW BOUND: 84
% NEW BOUND: 83
% NEW BOUND: 79
f(A,B):-myreverse(A,C),f_1(C,B).
f_1(A,B):-f_2(A,C),myreverse(C,B).
f_2(A,B):-f_3(A,C),f_5(C,B).
f_3(A,B):-f_4(A,C),tail(C,B).
f_4(A,B):-dropWhile(A,B,is_number).
f_5(A,B):-takeWhile(A,B,is_letter).
% program cost: 79
true.


