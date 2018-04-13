rm -rf programs
mkdir programs
function metagol {
  k=$1
  swipl -q << % >> "programs/metagol-$k.pl"
  ['data/train-$k'].
  ['e-metagol'].
  learn.
%
}

function metagolo {
  k=$1
  swipl -q << % >> "programs/metagolo-$k.pl"
  ['data/train-$k'].
  ['e-metagolo'].
  learn.
%
}

function metaopt {
  k=$1
  swipl -q << % >> "programs/metaopt-$k.pl"
  ['data/train-$k'].
  ['e-metaopt'].
  learn.
%
}

function f {
  k=$1
  metagol $k
  metagolo $k
  metaopt $k
}

for k in `seq 20`
do
    f $k
done