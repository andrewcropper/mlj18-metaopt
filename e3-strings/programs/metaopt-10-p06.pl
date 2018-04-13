true.

% learning f/2
% clauses: 1
% is better: 94
% clauses: 2
% is better: 92
% clauses: 3
% is better: 90
% is better: 87
% clauses: 4
% is better: 86
% is better: 85
% clauses: 5
% is better: 84
% is better: 82
% is better: 78
% clauses: 6
% is better: 76
% is better: 74
% is better: 70
% is better: 62
f(A,B):-f_1(A,C),f_5(C,B).
f_1(A,B):-f_2(A,C),f_2(C,B).
f_2(A,B):-f_3(A,C),f_3(C,B).
f_3(A,B):-f_4(A,C),f_4(C,B).
f_4(A,B):-tail(A,C),tail(C,B).
f_5(A,B):-dropWhile(A,B,not_number).
true.


