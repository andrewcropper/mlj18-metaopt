:-[experiment].

pos_cost(_Goal,1).
neg_cost(_Goal,1).

learn:-
  examples(Pos,Neg),
  max_time(MaxTime),
  catch(call_with_time_limit(MaxTime,(metagol:metagol(Pos,Neg))),time_limit_exceeded,(writeln('% timeout'),metagol:get_best_program(G),metagol:pprint(G))).