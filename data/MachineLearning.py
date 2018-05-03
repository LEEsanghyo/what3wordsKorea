import tensorflow as tf
import numpy as np
import itertools

##################################
#I will add the Mssql DB connection part
#and communicate with the web using Django
##################################

#Use numpy to read data from a .csv file
training_set = np.loadtxt('interest_recommand.csv', delimiter = ',' , dtype=np.float32)
#slicing
x_set = training_set[:, 0:-1]
y_set = training_set[:, [-1]]

#initialize
num = 5     #one-hot encoding
x_num = 10  #number of interests
y_num = 1   #result

X= tf.placeholder(tf.float32, [None, x_num])
Y= tf.placeholder(tf.int32, [None, y_num])

#One-Hot encoding(0~num), reshape as a one-dimensional array
Y_one_hot = tf.one_hot(Y, num)
Y_one_hot = tf.reshape(Y_one_hot, [-1,num])

W = tf.Variable(tf.random_normal([x_num, num]), name = 'weight')
b = tf.Variable(tf.random_normal([num]), name='bias')

#Calculate WX+b as the product of the matrix
logits = tf.matmul(X,W) + b
#Expressed as a probability value using softmax
hypothesis = tf.nn.softmax(logits)

#Cross entropy cost and minimize
cost_i = tf.nn.softmax_cross_entropy_with_logits_v2(logits = logits, labels=Y_one_hot)
cost = tf.reduce_mean(cost_i)
optimizer = tf.train.GradientDescentOptimizer(learning_rate=0.0001).minimize(cost)

#Accuracy calculation
prediction = tf.argmax(hypothesis,y_num)
correct = tf.equal(prediction, tf.argmax(Y_one_hot, y_num))
accuracy = tf.reduce_mean(tf.cast(correct, tf.float32))

#launch graph
sess = tf.Session()
sess.run(tf.global_variables_initializer())
#with tf.Seesion() as sess :
    #sess.run(tf.global_variables_initializer())

#The process of machine learning
for i in range(4000):
    sess.run(optimizer, feed_dict={X: x_set, Y: y_set})
    if i % 200 == 0:
        cost_loss, acc = sess.run([cost,accuracy], feed_dict={X: x_set, Y: y_set})
        print("step :{}, loss :{:.2f}, Acc :{:.1%}" .format(i,cost_loss,acc))

#Put input into the learned model
select = sess.run(hypothesis, feed_dict={X: [[30,29,10,18,19,20,28,14,27,13]]})
#Check the selected value through One-hot encoding
arg = sess.run(tf.argmax(select,1))
print(select, arg)

if arg == 1:
    recommand_set = np.loadtxt('course_1.csv', delimiter = ',' , dtype=np.str)

#I will create and add more data-set
elif arg == 2 :
    print(2)
elif arg == 3 :
    print(3)
elif arg == 4 :
    print(4)

x_recom = recommand_set[:]
for j in range(len(x_recom)):
    for k in range(len(x_recom[j])):
        if k != len(x_recom[j])-1:
            print(x_recom[j][k], end='->')
        else :
            print(x_recom[j][k])
