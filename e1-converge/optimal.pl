f(A,B):-mergesort(A,C),f_1(C,B).
f_1(A,B):-head(A,B),tail(A,D),head(D,B).
f_1(A,B):-tail(A,C),f_1(C,B).