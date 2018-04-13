true.

% learning f/2
% clauses: 1
% clauses: 2
% clauses: 3
% clauses: 4
% clauses: 5
f(A,B):-f_1(A,C),f_2(C,B).
f_1(A,B):-f_2(A,C),tail(C,B).
f_2(A,B):-takeWhile(A,B,is_letter).
f_2(A,B):-f_3(A,C),tail(C,B).
f_3(A,B):-dropWhile(A,B,not_space).
true.


