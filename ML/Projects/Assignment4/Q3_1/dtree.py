"""
Author: Yashoteja Prabhu
Email: yashoteja.prabhu@gmail.com
Date:   25-Mar-2016
"""

"""
This sample code demonstrates how to:
- load text data into python using pandas module
- preprocess textual categorical features
- build decision tree using training data
- predict scores over novel test data
"""

# Loading requisite libraries
import sys
import os
import re
import pandas as pd
import numpy as np
import pdb
import math
from sklearn.tree import DecisionTreeClassifier
from sklearn.preprocessing import LabelEncoder
from sklearn.preprocessing import OneHotEncoder

# This function encodes a symbolic categorical attribute (eg: female/male) as a set of numerical one-versus-all features (one-hot-encoding)
def one_hot_encode_categorical(Xtrn,Xval,Xtst):
	lenc = LabelEncoder()
	catvar = Xtrn.columns[Xtrn.dtypes==object]
	oenc = OneHotEncoder(categorical_features=(Xtrn.dtypes==object),sparse=False)

	# Convert from, say, male/female to 0/1 (refer online for more details)
	for var in catvar:
		lenc.fit( pd.concat( [Xtrn[var],Xval[var],Xtst[var]] ) )
		Xtrn[var] = lenc.transform(Xtrn[var])
		Xval[var] = lenc.transform(Xval[var])
		Xtst[var] = lenc.transform(Xtst[var])

	# one-hot-encoding of 0-(k-1) valued k-categorical attribute
	oenc.fit( pd.concat( [Xtrn,Xval,Xtst] ) )
	Xtrn = pd.DataFrame(oenc.transform(Xtrn))
	Xval = pd.DataFrame(oenc.transform(Xval))
	Xtst = pd.DataFrame(oenc.transform(Xtst))
	return (Xtrn,Xval,Xtst)

# Read training data and partition into features and target label
data = pd.read_csv("train.csv")
Xtrn = data.drop(data.columns[0], axis=1)
Ytrn = data.ix[:,0]
ytrn = Ytrn.tolist()
range_1 = range(0,73)
range_2 = range(73,146)
part1 = Xtrn.drop(Xtrn.columns[range_2],axis=1)
part2 = Xtrn.drop(Xtrn.columns[range_1],axis=1)
part1mat = part1.values
part2mat = part2.values
diff = part1mat - part2mat
#dotprod = np.dot(part1mat, part2mat, out=ndarray)
diffabsX = np.absolute(diff)

# Read validation data and partition into features and target label
datav = pd.read_csv("validation_1.csv")
Xval = datav.drop(datav.columns[0], axis=1)
Yval = datav.ix[:,0]

yval = Yval.tolist()
part1 = Xval.drop(Xval.columns[range_2],axis=1)
part2 = Xval.drop(Xval.columns[range_1],axis=1)
part1mat = part1.values
part2mat = part2.values
diff = part1mat - part2mat
diffabsV = np.absolute(diff)

# Read test data and partition into features and target label
datat = pd.read_csv("testfile.csv")
Xtst = datat.drop(datat.columns[0], axis=1)
Ytst = datat.ix[:,0]

ytst = Ytst.tolist()
part1 = Xtst.drop(Xtst.columns[range_2],axis=1)
part2 = Xtst.drop(Xtst.columns[range_1],axis=1)
part1mat = part1.values
part2mat = part2.values
diff = part1mat - part2mat
diffabsT = np.absolute(diff)

# convert a symbolic categorical attribute (eg: female/male) to set of numerical one-versus-all features (one-hot-encoding)
#Xtrn,Xval,Xtst = one_hot_encode_categorical(Xtrn,Xval,Xtst)


# Build a simple depth-5 decision tree with information gain split criterion
dtree = DecisionTreeClassifier(criterion="entropy",max_depth=5)
dtree.fit(diffabsX,ytrn)

# function score runs prediction on data, and outputs accuracy. 
# If you need predicted labels, use "predict" function
print "\n"

print "training accuracy: ",
print dtree.score(diffabsX,ytrn)

print "validation accuracy: ",																																																																																																																																																																						
print dtree.score(diffabsV,yval)

print "test accuracy: ",
print dtree.score(diffabsT,ytst)

