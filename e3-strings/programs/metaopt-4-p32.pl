true.

% learning f/2
% clauses: 1
% clauses: 2
% clauses: 3
% clauses: 4
% clauses: 5
% is better: 173
% is better: 94
% clauses: 6
% is better: 92
% is better: 81
f(A,B):-myreverse(A,C),f_1(C,B).
f_1(A,B):-f_2(A,C),myreverse(C,B).
f_2(A,B):-f_3(A,C),f_5(C,B).
f_3(A,B):-f_4(A,C),tail(C,B).
f_4(A,B):-dropWhile(A,B,is_number).
f_5(A,B):-takeWhile(A,B,is_letter).
true.


