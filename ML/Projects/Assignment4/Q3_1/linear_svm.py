
# Loading requisite libraries
import sys
import os
import re
import pandas as pd
import numpy as np
import pdb
import math
import numpy as np
from sklearn import svm

# Read training data and partition into features and target label
data = pd.read_csv("train.csv")
Xtrn = data.drop(data.columns[0], axis=1)
Ytrn = data.ix[:,0]
Xtrn = (Xtrn - Xtrn.mean()) / (Xtrn.max() - Xtrn.min())
ytrn = Ytrn.tolist()
range_1 = range(0,73)
range_2 = range(73,146)
part1 = Xtrn.drop(Xtrn.columns[range_2],axis=1)
part2 = Xtrn.drop(Xtrn.columns[range_1],axis=1)
part1mat = part1.values
part2mat = part2.values
diff = part1mat - part2mat
dotprod = np.multiply(part1mat, part2mat)
diffabsX = np.absolute(diff)
mainMatX = np.hstack((diffabsX,dotprod))


# Read validation data and partition into features and target label
data = pd.read_csv("validation_3.csv")
Xval = data.drop(data.columns[0], axis=1)
Xval = (Xval- Xval.mean()) / (Xval.max() - Xval.min())
Yval = data.ix[:,0]
yval = Yval.tolist()
part1 = Xval.drop(Xval.columns[range_2],axis=1)
part2 = Xval.drop(Xval.columns[range_1],axis=1)
part1mat = part1.values
part2mat = part2.values
diff = part1mat - part2mat
dotprod = np.multiply(part1mat, part2mat)
diffabsV = np.absolute(diff)
mainMatV = np.hstack((diffabsV,dotprod))

#Read test data
data = pd.read_csv("testfile.csv")
Xtst = data.drop(data.columns[0], axis=1)
Xtst = (Xtst- Xtst.mean()) / (Xtst.max() - Xtst.min())
Ytst = data.ix[:,0]
ytst = Ytst.tolist()

part1 = Xtst.drop(Xtst.columns[range_2],axis=1)
part2 = Xtst.drop(Xtst.columns[range_1],axis=1)
part1mat = part1.values
part2mat = part2.values
diff = part1mat - part2mat
dotprod = np.multiply(part1mat, part2mat)
diffabsT = np.absolute(diff)
mainMatT = np.hstack((diffabsT,dotprod))


clf = svm.LinearSVC()


# linear kernel computation

clf.fit(mainMatX, ytrn)
Yv = clf.predict(mainMatV)
Yt = clf.predict(mainMatT)
resultv = yval - Yv
accuracy_val = float(30000 - np.count_nonzero(resultv))/30000



cols = ['TARGET']
ans_vector = pd.DataFrame(columns=cols)
for i in range(len(Yt)):
	d = {'TARGET':Yt[i]}
	dat = pd.DataFrame(d, index=[i])
	ans_vector = ans_vector.append(dat)

print accuracy_val
ans_vector.to_csv('result.csv')


















