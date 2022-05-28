import matplotlib.pyplot as plt
import numpy as np

data = {'a': np.arange(50),
        'c': np.random.randint(0,50,50),
        'd': np.random.randn(50)}
data['b'] = data['a'] + 10* np.random.randn(50)
data['d'] =np.abs(data['d'])*100
print(data)
plt.plot(data['a'],data['d'])
plt.show()

