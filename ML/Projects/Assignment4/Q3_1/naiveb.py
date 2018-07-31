# Loading requisite libraries
import sys
import os
import re
import pandas as pd
import numpy as np
import pdb
import math
import numpy as np
from sklearn.naive_bayes import BernoulliNB

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

# Read test data and partition into features and target label
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

gnb = BernoulliNB()

train = gnb.fit(mainMatX, ytrn)
Y = train.predict(mainMatV)

resultv = Yval - Y
accuracy_val = float(30000 - np.count_nonzero(resultv))/30000
print accuracy_val

Y = train.predict(mainMatX)

resultv = Ytrn - Y
accuracy_val = float(50000 - np.count_nonzero(resultv))/50000
print accuracy_val







