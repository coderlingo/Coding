# Loading requisite libraries
import sys
import os
import re
import pandas as pd
import numpy as np
import pdb
import math
import copy
import matplotlib.pyplot as plt
from matplotlib.cbook import Null
from __builtin__ import str
from _ast import Str

tree=[]#list of th nodes of the tree
tree1=[]
tree_after_process=[]
node_count=0    #number of nodes in the tree
root={}
count=0
test_count=0
plot_acc=[]
plot_count=[]
tree_plot=[]
plot_acc_test = []
plot_acc_train = []
tree_nodes1=[]
plot_acc_val=[]
# ------Read training data and partition into features and target label
data = pd.read_csv("train.csv")
Ytrn = data["Survived"]
Xtrn=data.replace("female",1)
Xtrn=Xtrn.replace("male",0)


#----MEDIAN
median_age=np.median(Xtrn["Age"])
if median_age==0.0:
    median_age=1
median_sibsp=np.median(Xtrn["SibSp"])
if median_sibsp==0.0:
    median_sibsp=1
median_parch=np.median(Xtrn["Parch"])
if median_parch==0.0:
    median_parch=1
median_ticket=np.median(Xtrn["Ticket"])
if median_ticket==0.0:
    median_ticket=1
median_fare=np.median(Xtrn["Fare"])
if median_fare==0.0:
    median_fare=1
median_cabin_b=np.median(Xtrn["Cabin_b"])
if median_cabin_b==0.0:
    median_cabin_b=1


#-----MASKING
mask_age = (Xtrn["Age"] < median_age).astype(int)
Xtrn["Age"]=mask_age;

mask_sibsp = (Xtrn["SibSp"] < median_sibsp).astype(int)
Xtrn["SibSp"]=mask_sibsp;

mask_parch = (Xtrn["Parch"] < median_parch).astype(int)
Xtrn["Parch"]=mask_parch;

mask_ticket = (Xtrn["Ticket"] < median_ticket).astype(int)
Xtrn["Ticket"]=mask_ticket;

mask_fare = (Xtrn["Fare"] < median_fare).astype(int)
Xtrn["Fare"]=mask_fare;

mask_Cabin_b = (Xtrn["Cabin_b"] < median_cabin_b).astype(int)
Xtrn["Cabin_b"]=mask_Cabin_b;

#---CREATING ATTRIBUTE LIST 
at_List=["Pclass","Sex","Age","SibSp","Parch","Ticket","Fare","Embarked","Cabin_a","Cabin_b"]

#---CREATING LIST OF LISTS OF ATTRIBUTES
at_values=[Xtrn.Pclass.unique(),Xtrn.Sex.unique(),Xtrn.Age.unique(),Xtrn.SibSp.unique(),Xtrn.Parch.unique(),Xtrn.Ticket.unique(),Xtrn.Fare.unique(),Xtrn.Embarked.unique(),Xtrn.Cabin_a.unique(),Xtrn.Cabin_b.unique()]

#---CREATING LIST OF NUMBER OF ATTRIBUTE VALUES OF EACH ATTRIBUTE
at_count=[len(Xtrn.Pclass.unique()),len(Xtrn.Sex.unique()),len(Xtrn.Age.unique()),len(Xtrn.SibSp.unique()),len(Xtrn.Parch.unique()),len(Xtrn.Ticket.unique()),len(Xtrn.Fare.unique()),len(Xtrn.Embarked.unique()),len(Xtrn.Cabin_a.unique()),len(Xtrn.Cabin_b.unique())]
data = pd.read_csv("validation.csv")
Yval = data["Survived"]
#print data
XVal=data.replace("female",1)
XVal=XVal.replace("male",0)


#----MEDIAN
median_age=np.median(XVal["Age"])
if median_age==0.0:
    median_age=1
median_sibsp=np.median(XVal["SibSp"])
if median_sibsp==0.0:
    median_sibsp=1
median_parch=np.median(XVal["Parch"])
if median_parch==0.0:
    median_parch=1
median_ticket=np.median(XVal["Ticket"])
if median_ticket==0.0:
    median_ticket=1
median_fare=np.median(XVal["Fare"])
if median_fare==0.0:
    median_fare=1
median_cabin_b=np.median(XVal["Cabin_b"])
if median_cabin_b==0.0:
    median_cabin_b=1


#-----MASKING
mask_age = (XVal["Age"] < median_age).astype(int)
XVal["Age"]=mask_age;

mask_sibsp = (XVal["SibSp"] < median_sibsp).astype(int)
XVal["SibSp"]=mask_sibsp;

mask_parch = (XVal["Parch"] < median_parch).astype(int)
XVal["Parch"]=mask_parch;

mask_ticket = (XVal["Ticket"] < median_ticket).astype(int)
XVal["Ticket"]=mask_ticket;

mask_fare = (XVal["Fare"] < median_fare).astype(int)
XVal["Fare"]=mask_fare;

mask_Cabin_b = (XVal["Cabin_b"] < median_cabin_b).astype(int)
XVal["Cabin_b"]=mask_Cabin_b;



# Read test data and partition into features and target label
data = pd.read_csv("test.csv")
Ytst = data["Survived"]

Xtst=data.replace("female",1)
Xtst=Xtst.replace("male",0)


#----MEDIAN
median_age=np.median(Xtst["Age"])
if median_age==0.0:
    median_age=1
median_sibsp=np.median(Xtst["SibSp"])
if median_sibsp==0.0:
    median_sibsp=1
median_parch=np.median(Xtst["Parch"])
if median_parch==0.0:
    median_parch=1
median_ticket=np.median(Xtst["Ticket"])
if median_ticket==0.0:
    median_ticket=1
median_fare=np.median(Xtst["Fare"])
if median_fare==0.0:
    median_fare=1
median_cabin_b=np.median(Xtst["Cabin_b"])
if median_cabin_b==0.0:
    median_cabin_b=1


#-----MASKING
mask_age = (Xtst["Age"] < median_age).astype(int)
Xtst["Age"]=mask_age;

mask_sibsp = (Xtst["SibSp"] < median_sibsp).astype(int)
Xtst["SibSp"]=mask_sibsp;

mask_parch = (Xtst["Parch"] < median_parch).astype(int)
Xtst["Parch"]=mask_parch;

mask_ticket = (Xtst["Ticket"] < median_ticket).astype(int)
Xtst["Ticket"]=mask_ticket;

mask_fare = (Xtst["Fare"] < median_fare).astype(int)
Xtst["Fare"]=mask_fare;

mask_Cabin_b = (Xtst["Cabin_b"] < median_cabin_b).astype(int)
Xtst["Cabin_b"]=mask_Cabin_b;


def testing(data,node):
    global test_count
    #print str(data.shape)
    #print str(node)
    if node['leaf']==1:
        maj_class=node['majority_class']
        test_count=test_count+(data['Survived'] ==maj_class).sum()
    else:
        child_list=node['children']
        attribute=node['disc_attribute']
        for value in child_list:
            new_node=tree[value]
            label=new_node['label']
            #print 'attribute'+attribute
            #print label
            row=data.loc[data[attribute] == label]
            testing(row,new_node)
            
def testing_pruning(data,node):
    global test_count
    #print str(data.shape)
    #print str(node)
    if node['leaf']==1:
        maj_class=node['majority_class']
        test_count=test_count+(data['Survived'] ==maj_class).sum()
    else:
        child_list=node['children']
        attribute=node['disc_attribute']
        for value in child_list:
            new_node=tree_nodes1[value]
            label=new_node['label']
            #print 'attribute'+attribute
            #print label
            row=data.loc[data[attribute] == label]
            testing_pruning(row,new_node)

def testing_plot(data,node):
    global test_count
    #print str(data.shape)
    #print str(node)
    if node['leaf']==1:
        maj_class=node['majority_class']
        test_count=test_count+(data['Survived'] ==maj_class).sum()
    else:
        child_list=node['children']
        attribute=node['disc_attribute']
        for value in child_list:
            new_node=tree_plot[value]
            label=new_node['label']
            #print 'attribute'+attribute
            #print label
            #print 'attribute:'+attribute
            #print 'label '+str(label)
            row=data.loc[data[attribute] == label]
            testing_plot(row,new_node)    
        
#----FUNCTION TO CALCULATE THE ENTROPY
def Entropy(val_list):
    sum_val=sum(val_list)
    add=0
    #print sum_val
    for val in val_list:
     #   print val
        a= val/float(sum_val)
        add=add-((val/float(sum_val))*(math.log(a)/math.log(2)))
    #print add
    return     add
    
#---TO CALCULATE THE GAIN
def gain(data,val,entropy):
    indx=at_List.index(val)
    value_list=at_values[indx]
    count=len(data)
    x=0
    #print 'data'+str(data.shape)
    for value in value_list:
        #print  'value'+str(value)
        count_val=(data[val]==value).sum()
        rows1=data.loc[data[val] == value]
        S_positive=(rows1['Survived'] ==1).sum()
        S_negetive=(rows1['Survived'] ==0).sum()
        if(S_positive!=0 and S_negetive!=0):
            par=[S_positive,S_negetive]
            ent=Entropy(par)
            x=x+(count_val/float(count))*ent
    #print 'entropy'+str(x)       
    return entropy-x


    
#------select attribute from the list of attributes
def selectAttribute(data,attribute_list):
    S_positive=(data['Survived']==1).sum()
    S_negetive=(data['Survived']==0).sum()
    if len(attribute_list)==0:
        val=-2
        return val
    if (S_positive==0 or S_negetive==0):
        if S_negetive!=0:
            return 0
        else:
            return 1
    #print data.shape
    par=[S_positive,S_negetive]
    entropy=Entropy(par)
    max_gain=0
    for val in attribute_list:
        #print 'val' + str(val)
        gain_Value=gain(data,val,entropy)
        if gain_Value>max_gain:
            max_gain=gain_Value
            gain_attribute=val
    if max_gain==0:
        gain_attribute=-1
    return gain_attribute

#---BUILD TREE
def buildTree():
        global node_count
        global count
        global tree
        global tree_after_process
        #------LOOP FOR CLEARING THE QUEUE

        for node in tree :
            if node['leaf']==0:
                data=node['data'] 
                (m,n)=data.shape
                if m==0:
                    node['leaf']=1 
                    tree_after_process.append(node)
                    continue
                attribute_list= node['attribute_list'] 
                attribute=selectAttribute(data,attribute_list)
                if attribute==-1:
                    S_positive=(data['Survived']==1).sum()
                    S_negetive=(data['Survived']==0).sum()
                    if S_positive>S_negetive:
                        node['leaf']=1
                        node['majority_class']=1
                        tree_after_process.append(node)
                        continue
                    else:
                        node['leaf']=1
                        node['majority_class']=0
                        tree_after_process.append(node)
                        continue
                if attribute==-2:
                    S_positive=(data['Survived']==1).sum()
                    S_negetive=(data['Survived']==0).sum()
                    if S_positive>S_negetive:
                        node['leaf']=1
                        node['majority_class']=1
                        tree_after_process.append(node)
                        continue
                    else:
                        node['leaf']=1
                        node['majority_class']=0
                        tree_after_process.append(node)
                        continue
                if attribute==0:
                    node['leaf']=1
                    node['majority_class']=0
                    tree_after_process.append(node)
                    continue
                if attribute==1:
                    node['leaf']=1
                    node['majority_class']=1
                    tree_after_process.append(node)
                    continue
                
                indx=at_List.index(attribute)
                value_list=at_values[indx]  #---REQUIRED
                num_of_children=len(value_list) #---REQUIRED
                
                #---ATTRIBUTE LIST UPDATE
                atrlist=copy.deepcopy(attribute_list)  
                atrlist.remove(attribute)  #---REQUIRED
                node['disc_attribute']=attribute
                child_list=[]
                for value in value_list:
                    
                    rows=data.loc[data[attribute] == value] 
                    (m,n)=rows.shape
                    if m==0:
                        maj_class=node['majority_class']
                    else:
                        S_positive=(rows['Survived']==1).sum()
                        S_negetive=(rows['Survived']==0).sum()
                        if S_positive>S_negetive:
                            maj_class=1
                        else:
                            maj_class=0
                    new_node={'disc_attribute': 0, 'num_of_children': 0, 'data': rows , 'label':value, 'children':0, 'attribute_list':atrlist,'leaf':0,'majority_class':maj_class};   
                    tree1.append(new_node)
                    tree.append(new_node)
                    child_list.append(count)
                    count=count+1
                    node_count=node_count+1
                    #print node_count
                node['children']=child_list
                node['num_of_children']=num_of_children
            tree_after_process.append(node)
            print node_count    
def nodeCount(tree_list,node):
    queue=[node]
    count=0
    while queue!=[]:
        new_node=queue[0]
        del queue[0]
        count=count+1
        if new_node['leaf']==0:
            child_list=new_node['children']
            for val in child_list:
                queue.append(tree_list[val])
    return count
def plot(plot_data):
    global test_count
    global tree_plot
    global plot_acc
    tree_plot=copy.deepcopy(tree_after_process) 
    leaf_nodes=[]
    internal_nodes=[]
    internal_nodes_index=[]
    for index, val in enumerate(tree_plot):
        if val['leaf']==1:
            leaf_nodes.append(val)
        else:
            internal_nodes.append(val)
            internal_nodes_index.append(index)
    internal_nodes.reverse()
    internal_nodes_index.reverse()
    i=0
    for val in internal_nodes:
        test_count=0
        val['children']=[]
        val['leaf']=1
        index_val=internal_nodes_index[i]
        tree_plot[index_val]=val
        
        data=copy.deepcopy(plot_data)
        (m,n)=data.shape
        testing_plot(data,tree_plot[0])
        i=i+1
        acc=test_count/float(m)
        plot_acc.append(acc)
        count=nodeCount(tree_plot,tree_plot[0])
        plot_count.append(count)
       
def pruning(data_test,data_val,data_train,maxValacc):
    global test_count
    global tree_plot
    global plot_acc   
    global plot_acc_val
    global plot_acc_test
    global plot_acc_train
    global plot_count
    global tree_nodes1
    tree_nodes=copy.deepcopy(tree_after_process)
    max_acc=maxValacc
    i=0
    while True:
        print 'itr'+str(i)
        acc_old=-1
        acc_index=-1
        tree_list=copy.deepcopy(tree_nodes)
        for k in range(0,len(tree_list),1):
            
            if  tree_list[k]['leaf']==1:
                continue
            tree_plot=copy.deepcopy(tree_nodes)
            tree_plot[k]['leaf']=1
            test_count=0
            data=copy.deepcopy(data_val)
            (m,n)=data.shape
            testing_plot(data,tree_plot[0])            
            acc=test_count/float(m)
            if acc>acc_old:
                acc_old=acc
                acc_index=k 
        if acc_old>=max_acc:
            tree_nodes[acc_index]['leaf']=1
            plot_acc.append(acc_old)
            count=nodeCount(tree_nodes,tree_nodes[0])
            plot_count.append(count)
            print'count'+str(count)
            max_acc=acc_old
            tree_nodes1=copy.deepcopy(tree_nodes)
            
            test_count=0
            
            
            data=copy.deepcopy(Xtst)
            testing_pruning(data, tree_nodes1[0])
            (m,n)=data.shape
            acc=test_count/float(m)
            plot_acc_test.append(acc)
            
            test_count=0
            
            
            data=copy.deepcopy(Xtrn)
            testing_pruning(data,tree_nodes1[0])
            (m,n)=data.shape
            acc=test_count/float(m)
            plot_acc_train.append(acc)
            
            test_count=0
            
            
            data=copy.deepcopy(XVal)
            testing_pruning(data, tree_nodes1[0])
            (m,n)=data.shape
            acc=test_count/float(m)
            plot_acc_val.append(acc)
        else:
            print 'final acc',acc_old
            break
        i=i+1
    return tree_nodes
            
            
    '''
    flag=1
    max_acc=maxValacc
    tree_nodes=copy.deepcopy(tree_after_process) 
    tree_plot=copy.deepcopy(tree_nodes) 
    it = 0
    while flag==1:
        it = it + 1
        print 'while begin  ',it
        list_acc = []
        test_count = 0
        tree_plot=copy.deepcopy(tree_nodes)
        leaf_nodes=[]
        internal_nodes=[]
        internal_nodes_index=[]
        for index, val in enumerate(tree_plot):
            if val['leaf']==1:
                leaf_nodes.append(val)
            else:
                internal_nodes.append(val)
                internal_nodes_index.append(index)
        i=0
        for val in internal_nodes:
            tree_plot=copy.deepcopy(tree_nodes)
            test_count=0
            val['children']=[]
            val['leaf']=1
            index_val=internal_nodes_index[i]
            tree_plot[index_val]=val
             
            data=copy.deepcopy(data_val)
            (m,n)=data.shape
            testing_plot(data,tree_plot[0])
            i=i+1
            acc=test_count/float(m)
            list_acc.append(acc)
            
        max_index=list_acc.index(max(list_acc))
        if list_acc[max_index] > max_acc:
            max_acc=list_acc[max_index]
        else:
            flag=0
            return tree_nodes
             
         
        n=tree_nodes[max_index]
        n['leaf']=1
        tree_nodes[max_index]=n
        
        tree_plot=copy.deepcopy(tree_nodes)
        count=nodeCount(tree_plot,tree_plot[0])
        print 'node_count'+str(count)
        plot_count.append(count)
        
        data=copy.deepcopy(data_val)
        test_count=0
        (m,n)=data.shape
        testing_plot(data,tree_plot[0])
        acc=test_count/float(m)
        plot_acc.append(acc)
        
        tree_nodes=bfs_tree()
        '''
#------------------------------------------------------------------------
'''
    flag=1 
    max_acc=maxValacc 
    tree_nodes=copy.deepcopy(tree_after_process) 
    tree_plot=copy.deepcopy(tree_nodes) 
    while flag==1:
        list_acc = []
        
        #---TO GET INTERNAL NODES LIST
        leaf_nodes=[]
        internal_nodes=[]
        internal_nodes_index=[]
        for index, val in enumerate(tree_nodes):
            if val['leaf']==1:
                leaf_nodes.append(val)
            else:
                internal_nodes.append(val)
                internal_nodes_index.append(index)
        
        i=0
        for val in internal_nodes:
            
            #---MARK THE INTERNAL NODE AS LEAF
            tree_plot=copy.deepcopy(tree_nodes)
            test_count=0
            val['children']=[]
            val['leaf']=1
            index_val=internal_nodes_index[i]
            tree_plot[index_val]=val
            
            #----to perform testing
            data=copy.deepcopy(data_val)
            (m,n)=data.shape
            testing_plot(data,tree_plot[0])
            acc=test_count/float(m)
            list_acc.append(acc)
            i=i+1
        #--OUT OF WHILE WITH THE LIST OF ACCURACIES ON TREE_PLOT
        
        max_index=list_acc.index(max(list_acc))
        if list_acc[max_index] > max_acc:
            max_acc=list_acc[max_index]
        else:
            flag=0
            return tree_nodes
        
        #--SET THE NODE WITH THE MAX PRUNING ACC TO LEAF
        n=tree_nodes[max_index]
        n['leaf']=1
        tree_nodes[max_index]=n
         
        #--BECAUSE NODE COUNT FUNCTION WORKS ON TREE_PLOT ONLY
        tree_plot=copy.deepcopy(tree_nodes)
        count=nodeCount(tree_plot,tree_plot[0])
        
        #--APPEND THE NUM OF NODES
        plot_count.append(count)
        print 'count '+str(count)
        
        #---TO FIND THE ACCURACY OF THE PRUNED TREE
        data=copy.deepcopy(data_val)
        test_count=0
        (m,n)=data.shape
        testing_plot(data,tree_plot[0])
        acc=test_count/float(m)
        
        #--APPEND THE ACCURACY
        plot_acc.append(acc)
        
        tree_nodes=bfs_tree()
'''        
def bfs_tree():
    queue=[tree_plot[0]]
    count=0
    for node1 in queue:
        if node1['leaf']==0:
            child_list=node1['children']
            for val in child_list:
                queue.append(tree_plot[val])
    return queue
#---THE MAIN METHOD        
def main():
    global count
    global node_count
    global tree
    global tree1
    global test_count
    global plot_acc
    global plot_count
    global tree_nodes1
    attribute_list=copy.deepcopy(at_List)
    data=copy.deepcopy(Xtrn)
    S_positive=(data['Survived']==1).sum()
    S_negetive=(data['Survived']==0).sum()
    if S_positive>S_negetive :
        maj_class=1
    else :
        maj_class=0
    root={'disc_attribute': 0, 'num_of_children': 0, 'data': data , 'label':0, 'children':0, 'attribute_list':attribute_list,'leaf':0,'majority_class':maj_class};
    tree=[root]
    tree1=[root]
    count=count+1
    node_count=node_count+1
    buildTree()
    print 'tree built'
    data=copy.deepcopy(Xtrn)
    testing(data, root)
    (m,n)=Xtrn.shape
    acc=test_count/float(m)
    print 'acc train'+str(acc)
    
    test_count=0
    data=copy.deepcopy(Xtst)
    testing(data, root)
    (m,n)=Xtst.shape
    acc=test_count/float(m)
    print 'acc test'+str(acc)
    
    test_count=0
    data=copy.deepcopy(XVal)
    testing(data, root)
    (m,n)=XVal.shape
    acc=test_count/float(m)
    print 'acc val'+str(acc)
    maxaccVAl = acc
    
    data=copy.deepcopy(Xtrn)
    plot(data) 
    print 'plot_acc_train'+str(plot_acc)
    plt.plot(plot_count,plot_acc,label='training')
    plt.legend(loc='upper right')
    plt.xlabel('No. of nodes', fontsize=18)
    plt.ylabel('Accuracy', fontsize=16)
    
    plot_acc=[]
    plot_count=[]
    plt.axis([0, 300, 0, 1.1])
    plt.show()
    data=copy.deepcopy(Xtst)
    plot(data) 
    print 'plot_acc_test'+str(plot_acc)
    plt.plot(plot_count,plot_acc,label='test')
    plt.legend(loc='upper right')
    plt.xlabel('No. of nodes', fontsize=18)
    plt.ylabel('Accuracy', fontsize=16)
    
    plot_acc=[]
    plot_count=[]
    plt.axis([0, 300, 0, 1.1])
    plt.show()
    data=copy.deepcopy(XVal)
    plot(data)
    print 'plot_acc_val'+str(plot_acc)
    plt.plot(plot_count,plot_acc,label='validation')
    plt.legend(loc='upper right')
    plt.xlabel('No. of nodes', fontsize=18)
    plt.ylabel('Accuracy', fontsize=16)
    plt.axis([0, 300, 0, 1.1])
    plt.show()
    
    data1=copy.deepcopy(Xtrn)
    data2=copy.deepcopy(XVal)
    data3=copy.deepcopy(Xtst)

    plot_count=[]
    tree_nodes=pruning(data3,data2,data1,maxaccVAl);
    tree_nodes1=copy.deepcopy(tree_nodes)
    print 'plot_acc'+str(plot_acc)
    count=nodeCount(tree_nodes,tree_nodes[0])
    print 'node count'+str(count)
    
    
    print 'len count:'+str(len(plot_count))
    print 'len plot_acc_train:'+str(len(plot_acc_train))
    print 'len plot_acc_train:'+str(len(plot_acc_val))
    print 'len plot_acc_train:'+str(len(plot_acc_test))
    y1 = np.array(plot_acc_train)
    y2 = np.array(plot_acc_val)
    y3 = np.array(plot_acc_test)
    print 'plot_acc_train' +str(plot_acc_train)
    print 'plot_acc_val'+str(plot_acc_val)
    print 'plot_acc_test'+str(plot_acc_test)
    x = np.array(plot_count)
    plt.plot(x,y1,label='train')
    plt.legend(loc='upper right')
    plt.xlabel('No. of nodes', fontsize=18)
    plt.ylabel('Accuracy', fontsize=16)
    plt.axis([0, 300, 0.5, 0.95])
    plt.show()
    
    print 'len count:'+str(len(plot_count))
    print 'len plot_acc_train:'+str(len(plot_acc_val))
    plt.plot(x,y2,label='val')
    plt.legend(loc='upper right')
    plt.xlabel('No. of nodes', fontsize=18)
    plt.ylabel('Accuracy', fontsize=16)
    plt.axis([0, 300, 0.5, 0.95])
    plt.show()
    
    print 'len count:'+str(len(plot_count))
    print 'len plot_acc_train:'+str(len(plot_acc_test))
    plt.plot(x,y3,label='test')
    plt.legend(loc='upper right')
    plt.xlabel('No. of nodes', fontsize=18)
    plt.ylabel('Accuracy', fontsize=16)
    plt.axis([0, 300, 0.5, 0.95])
    
   
    plt.show()
    
    
    return 

if __name__ == "__main__": main()
