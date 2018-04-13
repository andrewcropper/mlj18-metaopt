rm -rf data
mkdir data

for k in `seq 1 20`
do
    swipl << % >> "data/test-5000-$k.pl"
    ['experiment'].
    gen_test_data(50,2000).
%
  for m in `seq 1 40`
  do
    swipl << % >> "data/train-$m-$k.pl"
    ['experiment'].
    gen_train_data($m).
%
  done
done