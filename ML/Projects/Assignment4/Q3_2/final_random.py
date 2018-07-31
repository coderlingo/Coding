import pandas as pd
import numpy as np
import copy
from sklearn import svm
from sklearn import preprocessing 
from sklearn import grid_search
import time
import csv
import random

data = pd.read_csv("train.csv")
Xtrn = data.drop(data.columns[0], axis=1)
ytrn = data.ix[:,0]
#ytrn = Ytrn.tolist()


data = pd.read_csv("validation_1.csv")
Xval1 = data.drop(data.columns[0], axis=1)
yval1 = data.ix[:,0]
#yval1 = Yval1.tolist()

data = pd.read_csv("validation_2.csv")
Xval2 = data.drop(data.columns[0], axis=1)
yval2 = data.ix[:,0]
#yval2 = Yval2.tolist()

data = pd.read_csv("validation_3.csv")
Xval3 = data.drop(data.columns[0], axis=1)
yval3 = data.ix[:,0]
#yval3 = Yval3.tolist()


train_value=np.concatenate([ytrn,yval1,yval2,yval3],0)
train_data=np.concatenate([Xtrn,Xval1,Xval2,Xval3],0)
print len(train_data)
print len(train_value)
k=int(0.4*len(train_data))
random_data=random.sample(range(len(train_data)),k)
train_data=train_data[random_data,:]
train_value=train_value[random_data]



data = pd.read_csv("testfile.csv")
Xtst = data.drop(data.columns[0], axis=1)
Ytst = data.ix[:,0]
ytst = Ytst.tolist()


mms = preprocessing.MinMaxScaler()
X_train_transformed = mms.fit_transform(train_data)


clf = svm.SVC(C=5,gamma=0.09)

clf.fit(X_train_transformed,train_value)

print 'predict'
X_test = min_max_scaler.transform(Xtst)
label=clf.predict(X_test)
prediction_file = open("testlabelssvm.csv", "wb")
prediction_file_object = csv.writer(prediction_file)
prediction_file_object.writerow(["ID", "TARGET"])
count = 0
for label in TLabels:                                
	prediction_file_object.writerow([count,int(label)])
	count = count + 1
prediction_file.close()
        
        
