true.

% learning f/2
% clauses: 1
% clauses: 2
% clauses: 3
% clauses: 4
% clauses: 5
% is better: 38
% clauses: 6
% is better: 36
% is better: 28
f(A,B):-tail(A,C),f_1(C,B).
f_1(A,B):-f_2(A,C),f_4(C,B).
f_2(A,B):-f_3(A,C),f_5(C,B).
f_3(A,B):-f_4(A,C),f_4(C,B).
f_4(A,B):-tail(A,C),tail(C,B).
f_5(A,B):-filter(A,B,is_number).
true.


