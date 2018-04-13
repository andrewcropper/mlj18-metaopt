true.

% learning f/2
% clauses: 1
% clauses: 2
% clauses: 3
% clauses: 4
% clauses: 5
% NEW BOUND: 62
% NEW BOUND: 58
% clauses: 6
% NEW BOUND: 41
% NEW BOUND: 36
f(A,B):-f_1(A,C),f_5(C,B).
f_1(A,B):-f_2(A,C),f_2(C,B).
f_2(A,B):-tail(A,C),f_3(C,B).
f_3(A,B):-f_4(A,C),f_4(C,B).
f_4(A,B):-tail(A,C),tail(C,B).
f_5(A,B):-takeWhile(A,B,is_letter).
% program cost: 36
true.


