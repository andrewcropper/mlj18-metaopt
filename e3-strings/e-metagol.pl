:-[experiment].

pos_cost(_Goal,1).
neg_cost(_Goal,1).

learn(K,Problem):-
  max_time(MaxTime),
  train_examples(K,Problem,Pos),
  Neg=[],
  %% SWI
  catch(call_with_time_limit(MaxTime,(metagol:metagol(Pos,Neg))),time_limit_exceeded,(writeln('% timeout'),metagol:get_best_program(G),metagol:pprint(G))).