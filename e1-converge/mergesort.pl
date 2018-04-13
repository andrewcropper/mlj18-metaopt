merge_sort([],[]):-!.
merge_sort([X],[X]):-!.
merge_sort([A1,A2|A3],[B1,B2|B3]):-
  split([A1,A2|A3],L,R),
  merge_sort(L,SL),
  merge_sort(R,SR),
  merge(SL,SR,[B1,B2|B3]).

split([],[],[]).
split([X],[X],[]).
split([L,R|T],[L|LT],[R|RT]):-
  split(T,LT,RT).

merge([],RS,RS).
merge(LS,[],LS).
merge([L|LS],[R|RS],[L|T]):-L=<R,merge(LS,[R|RS],T).
merge([L|LS],[R|RS],[R|T]):-L>R,merge([L|LS],RS,T).