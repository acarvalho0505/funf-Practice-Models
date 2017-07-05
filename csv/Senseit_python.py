
# coding: utf-8

# In[ ]:

from numpy import *
import pandas as pd
import matplotlib.pyplot as plt
data  = pd.read_csv("../Downloads/senseit_3_5.csv")
location = data[data['Sensor'] == 0]
GPS = data[data['Sensor'] == 1]
Sensor2  = data[data['Sensor'] == 2]
Sensor3 = data[data['Sensor'] == 3]
Sensor4 = data[data['Sensor'] ==4]
all_data = []
print(GPS)
for line in GPS:
    print(line)
    if -33.912778< line['Column2'] < -33.911994 and 18.418049 < line['Column3'] < 18.419229:
        all_data.append("Yes")
    else:
        all_data.append("No")
        
GPS["Foundry"] = all_data
print(len(all_data))

