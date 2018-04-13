true.

% learning f/2
% clauses: 1
% clauses: 2
% clauses: 3
% clauses: 4
% clauses: 5
% NEW BOUND: 37
% NEW BOUND: 28
% clauses: 6
% NEW BOUND: 26
f(A,B):-f_1(A,C),f_4(C,B).
f_1(A,B):-f_2(A,C),f_5(C,B).
f_2(A,B):-f_3(A,C),f_4(C,B).
f_3(A,B):-dropWhile(A,B,is_number).
f_4(A,B):-tail(A,C),tail(C,B).
f_5(A,B):-dropWhile(A,B,not_number).
% program cost: 26
true.


