trials=10
rm -rf 'programs'
mkdir 'programs'

function metagol {
  k=$1
  name=$2
  swipl -q << % >> "programs/metagol-$k-$name.pl"
  ['e-metagol'].
  learn($k,$name).
%
}

function metagolo {
  k=$1
  name=$2
  swipl -q << % >> "programs/metagolo-$k-$name.pl"
  ['e-metagolo'].
  learn($k,$name).
%
}

function metaopt {
  k=$1
  name=$2
  swipl -q << % >> "programs/metaopt-$k-$name.pl"
  ['e-metaopt'].
  learn($k,$name).
%
}

function f {
  k=$1
  for p in p01 p06 p07 p08 p11 p22c p25 p29 p30 p31 p32
  do
    echo $k $p
    metagol $k $p
    metaopt $k $p
    metagolo $k $p
  done
}

for k in `seq 10`
do
    f $k
done