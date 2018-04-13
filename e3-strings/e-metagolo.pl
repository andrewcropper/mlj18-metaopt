:-[experiment].

pos_cost(Goal,Cost):-
    (functor(Goal,_,2) -> Cost=1; Cost=0).
neg_cost(Goal,Cost):-
    (functor(Goal,_,2) -> Cost=1; Cost=0).

learn(K,Problem):-
  max_time(MaxTime),
  train_examples(K,Problem,Pos),
  Neg=[],
  %% SWI
  catch(call_with_time_limit(MaxTime,(metagol:metaopt(Pos,Neg))),time_limit_exceeded,(writeln('% timeout'),metagol:get_best_program(G),metagol:pprint(G))).