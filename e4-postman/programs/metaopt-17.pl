% learning f/2
% clauses: 1
% clauses: 2
% clauses: 3
% clauses: 4
% clauses: 5
% is better: 144
% is better: 122
% is better: 118
% is better: 76
% is better: 72
% clauses: 6
% timeout
f(A,B):-f_1(A,C),f_1(C,B).
f_1(A,B):-f_2(A,C),pman_go_to_start(C,B).
f_1(A,B):-f_2(A,C),f_1(C,B).
f_2(A,B):-find_next_recipient(A,C),give_letter(C,B).
f_2(A,B):-find_next_sender(A,C),bag_letter(C,B).
