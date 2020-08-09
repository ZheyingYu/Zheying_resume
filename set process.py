
import os
import numpy as np

os.chdir(r'C:\prob project')
a=open('work.txt')
a1=a.readlines()
x=[]
y=[]
for k in a1:
    try:
        x.append(int(k))
    except ValueError:
        continue
###print(x)
###list all integers in the database and clean the data 'NA's
z={}

max_=max(x)
min_=min(x)
print("The maximum of the data set is "+str(max_))
print("The minimum of the data set is "+str(min_))
for k in x:
    y.append(int(k/30))
    if int(k/30) in z:
        z[k/30]+=1
    else:
        z.update({k/30:1})


###print("This is the original frequency "+str(z))

i=33
while True:
    if i<10:
        break
    else:
        try:
            y.remove(i)
        except ValueError:
            i-=1

###print("This is the frequency "+str(y))
frequency=[]
i=0
while i<10:
    frequency.append(y.count(i))
    i+=1

print("This is the frequency "+str(frequency))


m={}
i=0
j=len(y)
while i<j-1:
    p=(y[i],y[i+1])
    if p in m:
        m[p]+=1.0
    else:
        m.update({p:1.0})
    i+=1


###print("This is the frequency "+str(m))
observations=len(y)
##i=0
##j=1
##while i<10:
##    try:
##        p=str(m[i,0])
##    except KeyError:
##        p=str(0)
##    while j<10:
##        try:
##            p=str(p)+" "+str(m[i,j])
##            j+=1
##        except KeyError:
##            p=str(p)+" "+str(0)
##            j+=1
##    print(p)
##    i+=1
##    j=1



i=0
j=1
q=[]
print("This is the frequency matrix:")
while i<10:
    try:
        p=[float(m[i,0])]
    except KeyError:
        p=[0.0]
    while j<10:
        try:
            p.append(float(m[i,j]))
            j+=1
        except KeyError:
            p.append(0.0)
            j+=1
    q.append(p)
    print(p)
    i+=1
    j=1

m_f=[10569,7474,6280,4835,3506,2561,1839,1255,948,717]
i=0
r=[]
for k in q:
    r.append([])
    for m in k:
        r[i].append(m/m_f[i])
    i+=1
print("This is the transition matrix:")
print(str(r))
##print("This is q "+str(q))

A=np.matrix([[-30497,945,74,25,10,13,4,0,1],[1016,-34692,962,110,45,12,5,-1,3],[39,1131,-35934,870,97,30,14,5,4],[3,63,1067,-37109,642,92,26,9,-5],[-7,8,70,848,-38072,504,68,24,0],[-15,-10,1,48,666,-38687,337,56,1],[-19,-22,-18,-7,-50,469,-39086,224,34],[0,-50,-45,-51,-40,-2,302,-39527,137],[0,-180,-178,-179,-177,-162,-127,58,-39720]])
B=np.matrix([[-1],[-3],[-4],[-6],[-8],[-18],[-23],[-52],[-181]])
A_inverse=np.linalg.inv(A)
X=A_inverse*B
print(X)

Y=[0.2646568108001902, 0.18702287419010605, 0.15705714914645172, 0.12085442432734018, 0.087559133086414, 0.06396952818535119, 0.04593727596353736, 0.03135009544802973, 0.023681513647601522, 0.017911195204976256]
print("The stationary distribution is "+str(Y))

sum_states=float(sum(m_f))
m_f2=[]
for x in m_f:
    m_f2.append(x/sum_states)

print("The relative frequency based on the given data set is "+str(m_f2))

error=[]
i=0
while i<10:
    error.append(abs(Y[i]-m_f2[i]))
    i+=1

print("The corresponding error term is "+str(error))
while True:
    x=input("Give a guess number:>")
    i=0
    y=[0,0,0,0,1,0,0,0,0,0]
    while i<x:
        j=0
        z_=[0,0,0,0,0,0,0,0,0,0]
        while j<10:
            k=0
            while k<10:
                z_[j]+=y[k]*r[k][j]
                k+=1
            j+=1
        y=z_
        i+=1
    print(y)
    d=input("Good input 1 bad input 0:>")
    if d==1:
        break
    else:
        continue





