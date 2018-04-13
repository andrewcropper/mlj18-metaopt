rm -rf data
mkdir data
function f {
    k=$1
    echo $1
    swipl << % >> "data/train-$k.pl"
    ['experiment'].
    gen_train_data.
%

    for m in 1000 2000 3000 4000 5000 6000 7000 8000 9000 10000
    do
        swipl << % >> "data/test-$m-$k.pl"
        ['experiment'].
        gen_test_data($m).
%
    done
}

for k in `seq 20`
do
    f $k
done