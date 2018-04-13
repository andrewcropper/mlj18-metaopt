true.

% learning f/2
% clauses: 1
% clauses: 2
% clauses: 3
% NEW BOUND: 2
% clauses: 4
% NEW BOUND: 1
% clauses: 5
% NEW BOUND: 0
% clauses: 6
f(A,B):-f_1(A,C),f_4(C,B).
f_1(A,B):-f_2(A,C),f_3(C,B).
f_2(A,B):-filter(A,B,is_letter).
f_3(A,B):-dropWhile(A,B,is_uppercase).
f_4(A,B):-dropWhile(A,B,not_uppercase).
% program cost: 0
true.


