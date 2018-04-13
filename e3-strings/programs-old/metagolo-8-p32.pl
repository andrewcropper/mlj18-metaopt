true.

% learning f/2
% clauses: 1
% clauses: 2
% clauses: 3
% clauses: 4
% NEW BOUND: 4
% NEW BOUND: 3
% clauses: 5
% NEW BOUND: 2
% clauses: 6
% NEW BOUND: 1
f(A,B):-f_1(A,C),tail(C,B).
f_1(A,B):-f_2(A,C),f_5(C,B).
f_2(A,B):-f_3(A,C),f_4(C,B).
f_3(A,B):-dropWhile(A,B,not_letter).
f_4(A,B):-dropWhile(A,B,not_number).
f_5(A,B):-filter(A,B,is_uppercase).
% program cost: 1
true.


