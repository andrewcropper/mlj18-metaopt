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
    return 1.4826*np.median([abs(x - med) for x in xs])

def costs(m,mode):
    xs = []
    for k in range(1,max_k+1):
        filename = 'results/{0}-{1}-{2}.txt'.format(mode,m,k)
        (costs,times) = parse_file(filename)
        xs.append(np.median(costs))
    print '({0},{1}) +- (0,{2})'.format(m,np.median(xs),mad(xs))

def times(m,mode):
    xs = []
    for k in range(1,max_k+1):
        filename = 'results/{0}-{1}-{2}.txt'.format(mode,m,k)
        (costs,times) = parse_file(filename)
        xs.append(np.median(times))
    print '({0},{1}) +- (0,{2})'.format(m,np.median(xs),mad(xs))

print '##################################################'
print 'PROGRAM COSTS'
print '##################################################'
name='metagol'
print '%',name
print "\\addplot+[gray,mark=square*,mark options={color=gray},error bars/.cd,y dir=both,y explicit] coordinates {"
for m in range(1000,11000,1000):
    costs(m,name)
print "};"

name='metagolo'
print '%',name
print "\\addplot+[red,mark=triangle*,mark options={color=red},error bars/.cd,y dir=both,y explicit] coordinates {"
for m in range(1000,11000,1000):
    costs(m,name)
print "};"

name='metaopt'
print '%',name
print "\\addplot+[blue,mark=*,mark options={fill=blue},error bars/.cd,y dir=both,y explicit] coordinates {"
for m in range(1000,11000,1000):
    costs(m,name)
print "};"

name='optimal'
print '%',name
print "\\addplot+[black,mark=none,dashed,error bars/.cd,y dir=both,y explicit] coordinates {"
for m in range(1000,11000,1000):
    costs(m,name)
print "};"



print '##################################################'
print 'PROGRAM TIMES'
print '##################################################'
name='metagol'
print '%',name
print "\\addplot+[gray,mark=square*,mark options={color=gray},error bars/.cd,y dir=both,y explicit] coordinates {"
for m in range(1000,11000,1000):
    times(m,name)
print "};"

name='metagolo'
print '%',name
print "\\addplot+[red,mark=triangle*,mark options={color=red},error bars/.cd,y dir=both,y explicit] coordinates {"
for m in range(1000,11000,1000):
    times(m,name)
print "};"

name='metaopt'
print '%',name
print "\\addplot+[blue,mark=*,mark options={fill=blue},error bars/.cd,y dir=both,y explicit] coordinates {"
for m in range(1000,11000,1000):
    times(m,name)
print "};"

name='optimal'
print '%',name
print "\\addplot+[black,mark=none,dashed,error bars/.cd,y dir=both,y explicit] coordinates {"
for m in range(1000,11000,1000):
    times(m,name)
print "};"