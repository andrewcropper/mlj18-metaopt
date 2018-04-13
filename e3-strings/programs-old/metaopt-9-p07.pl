true.

% learning f/2
% clauses: 1
% clauses: 2
% clauses: 3
% clauses: 4
% clauses: 5
% NEW BOUND: 104
% clauses: 6
% NEW BOUND: 99
f(A,B):-myreverse(A,C),f_1(C,B).
f_1(A,B):-f_2(A,C),f_4(C,B).
f_2(A,B):-f_3(A,C),f_3(C,B).
f_3(A,B):-tail(A,C),tail(C,B).
f_4(A,B):-f_5(A,C),myreverse(C,B).
f_5(A,B):-dropWhile(A,B,is_letter).
% program cost: 99
true.


