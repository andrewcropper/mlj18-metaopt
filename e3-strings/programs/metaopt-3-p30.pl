true.

% learning f/2
% clauses: 1
% clauses: 2
% clauses: 3
% is better: 39
% clauses: 4
% is better: 37
% is better: 32
% clauses: 5
% clauses: 6
f(A,B):-f_1(A,C),f_3(C,B).
f_1(A,B):-f_2(A,C),tail(C,B).
f_2(A,B):-dropWhile(A,B,is_number).
f_3(A,B):-takeWhile(A,B,is_letter).
true.


