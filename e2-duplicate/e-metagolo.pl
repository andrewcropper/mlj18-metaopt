:-[experiment].

pos_cost(Goal,Cost):-
    (functor(Goal,_,2) -> Cost=1; Cost=0).
neg_cost(Goal,Cost):-
    (functor(Goal,_,2) -> Cost=1; Cost=0).

learn:-
  examples(Pos,Neg),
  max_time(MaxTime),
  catch(call_with_time_limit(MaxTime,(metagol:metaopt(Pos,Neg))),time_limit_exceeded,(writeln('% timeout'),metagol:get_best_program(G),metagol:pprint(G))).