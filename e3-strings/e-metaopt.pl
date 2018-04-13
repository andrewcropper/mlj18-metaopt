:-[experiment].
:-['../tree-costs'].

learn(K,Problem):-
  max_time(MaxTime),
  train_examples(K,Problem,Pos),
  Neg=[],
  catch(call_with_time_limit(MaxTime,(metagol:metaopt(Pos,Neg))),time_limit_exceeded,(writeln('% timeout'),metagol:get_best_program(G),metagol:pprint(G))).