import numpy as np
from scipy import stats

max_k=20

def parse_file(filename):
    costs=[]
    times=[]
    with open(filename,'r') as f:
        for line in f:
            xs = line.strip().split(',')
            if len(xs) < 2:
                continue
            costs.append(float(xs[0]))
            times.append(float(xs[1]))
    return (costs,times)


def mad(xs):
    med = np.median(xs)
    return 1.4826 * np.median([abs(x - med) for x in xs])

def f(m,mode):
    all_costs = []
    all_times = []
    for k in range(1,max_k+1):
        filename = 'results/{0}-{1}-{2}.txt'.format(mode,m,k)
        (costs,times) = parse_file(filename)
        if costs != []:
            # all_costs.append(np.mean(costs))
            all_costs.append(np.median(costs))
            # all_costs.extend(costs)
        if times != []:
            # all_times.append(np.mean(times))
            all_times.append(np.median(times))
            # all_times.extend(times)

    # print '({0},{1}) +- (0,{2})'.format(m,np.mean(all_costs),stats.sem(all_costs))
    # print '({0},{1}) +- (0,{2})'.format(m,np.median(all_costs),1.2533*stats.sem(all_costs))
    print '({0},{1}) +- (0,{2})'.format(m,np.median(all_costs),mad(all_costs))

    # print '({0},{1}) +- (0,{2})'.format(m,np.mean(all_times),stats.sem(all_times))
    # print '({0},{1}) +- (0,{2})'.format(m,np.median(all_times),1.2533*stats.sem(all_times))

# for name in ['metagol','metagolo','metaopt', 'optimal']:
name='metagol'
print '%',name
print "\\addplot+[gray,mark=square*,mark options={color=gray},error bars/.cd,y dir=both,y explicit] coordinates {"
for m in range(2,16,2):
    f(m,name)
print "};"

name='metaopt'
print '%',name
print "\\addplot+[blue,mark=*,mark options={fill=blue},error bars/.cd,y dir=both,y explicit] coordinates {"
for m in range(2,16,2):
    f(m,name)
print "};"

