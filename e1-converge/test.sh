function metaopt {
  m=$1
  k=$2
  swipl << % >> "results/metaopt-$m-$k.txt"
  ['programs/metaopt-$m-$k'].
  ['data/test-5000-$k'].
  ['e-metaopt'].
  do_test.
%
}

function optimal {
  k=$1
  swipl << % >> "results/optimal-$k.txt"
  ['optimal'].
  ['data/test-5000-$k'].
  ['e-metaopt'].
  do_test.
%
}

function f {
  k=$1
  optimal $k
  for m in `seq 1 20`
  do
    metaopt $m $k
  done
}

f  $1