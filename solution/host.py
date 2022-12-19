import qsharp
from HostPython import BB84WithoutEve
from HostPython import BB84WithEve
import numpy as np


print('************************')
print('BB84 without Eve')
print('************************')
a = list(np.random.choice([0, 1], size=(16,), p=[1./2, 1./2]))
b = list(np.random.choice([0, 1], size=(16,), p=[1./2, 1./2]))
c = list(np.random.choice([0, 1], size=(16,), p=[1./2, 1./2]))
d = []
for i in range(16):
    if b[i]==c[i]:
        d.append(1)
    else:
        d.append(0)

print('I am Alice and I am generating a and b bit string')
print('string a: '+''.join(str(x) for x in a))
print('string b: '+''.join(str(x) for x in b))
print()
print('I am Bob and I am generating a and c bit string')
print('string c: '+''.join(str(x) for x in c))
print('BB84 protocol is starting')
print()
print('Bob\'s secret is ' +str(BB84WithoutEve.simulate(a=a, b=b, c=c, d=d)))
print('Alice\'s secret is ' + ''.join(str(x) for x in [i for i,j in zip(a, d) if j]))
print('\n')



print('************************')
print('BB84 with Eve')
print('************************')
a = list(np.random.choice([0, 1], size=(16,), p=[1./2, 1./2]))
b = list(np.random.choice([0, 1], size=(16,), p=[1./2, 1./2]))
c = list(np.random.choice([0, 1], size=(16,), p=[1./2, 1./2]))
d = []
for i in range(16):
    if b[i]==c[i]:
        d.append(1)
    else:
        d.append(0)
e = list(np.random.choice([0, 1], size=(16,), p=[1./2, 1./2]))
print('I am Alice and I am generating a and b bit string')
print('string a: '+''.join(str(x) for x in a))
print('string b: '+''.join(str(x) for x in b))
print()
print('I am Bob and I am generating c bit string')
print('string c: '+''.join(str(x) for x in c))
print()
print('I am Bob and I am generating e bit string')
print('string c: '+''.join(str(x) for x in e))
print('BB84 protocol is starting')
print()

print('Bob\'s secret is ' +str(BB84WithEve.simulate(a=a, b=b, c=c, d=d, e=e)))
print('Alice\'s secret is ' + ''.join(str(x) for x in [i for i,j in zip(a, d) if j]))