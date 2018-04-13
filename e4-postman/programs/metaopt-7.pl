% learning f/2
% clauses: 1
% clauses: 2
% clauses: 3
% clauses: 4
% clauses: 5
% is better: 132
% is better: 96
% is better: 94
% is better: 62
% is better: 58
% clauses: 6
f(A,B):-f_1(A,C),f_1(C,B).
f_1(A,B):-f_2(A,C),pman_go_to_start(C,B).
f_1(A,B):-f_2(A,C),f_1(C,B).
f_2(A,B):-find_next_recipient(A,C),give_letter(C,B).
f_2(A,B):-find_next_sender(A,C),bag_letter(C,B).
