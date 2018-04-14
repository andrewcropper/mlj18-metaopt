function metaopt {
  m=$1
  k=$2
  swipl -q << % >> "programs/metaopt-$m-$k.pl"
  ['data/train-$m-$k'].
  ['e-metaopt'].
  learn.
%
}

function f {
    k=$1
    for m in `seq 1 20`
    do
        metaopt $m $k
    done
}

for k in `seq 20`
do
    f $k
done