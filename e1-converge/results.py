import numpy as np
from scipy import stats

max_k=10
max_m=20
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
    return 1.4826*np.median([abs(x - med) for x in xs])

def f(m,mode,flag):
    all_costs = []
    all_times = []
    for k in range(1,max_k+1):
        if mode == 'metaopt':
            filename = 'results/{0}-{1}-{2}.txt'.format(mode,m,k)
        else:
            filename = 'results/{0}-{1}.txt'.format(mode,k)
        (costs,times) = parse_file(filename)
        if costs != []:
            all_costs.append(np.median(costs))
        if times != []:
            all_times.append(np.median(times))
    if flag:
        print '({0},{1}) +- (0,{2})'.format(m*2,np.median(all_costs),mad(all_costs))
    else:
        print '({0},{1}) +- (0,{2})'.format(m*2,np.median(all_times),mad(all_times))

# PRINT COSTS
name ='metaopt'
print '%',name
print "\\addplot+[blue,mark=*,mark options={fill=blue},error bars/.cd,y dir=both,y explicit] coordinates {"
for m in range(1,max_m+1):
    f(m,name,True)
print "};"

name ='optimal'
print '%',name
print "\\addplot+[black,mark=none,dashed,error bars/.cd,y dir=both,y explicit] coordinates {"
for m in range(1,max_m+1):
    f(m,name,True)
print "};"

# PRINT TIMES
name ='metaopt'
print '%',name
print "\\addplot+[blue,mark=*,mark options={fill=blue},error bars/.cd,y dir=both,y explicit] coordinates {"
for m in range(1,max_m+1):
    f(m,name,False)
print "};"

name ='optimal'
print '%',name
print "\\addplot+[black,mark=none,dashed,error bars/.cd,y dir=both,y explicit] coordinates {"
for m in range(1,max_m+1):
    f(m,name,False)
print "};"