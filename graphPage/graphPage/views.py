# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.shortcuts import render, HttpResponse
from django.templatetags.static import static
import tensorflow as tf
import numpy as np
from django.db import connection
from random import *
import json
import csv
import itertools


def test(request) :
    # Use numpy to read data from a .csv file
    member_no = request.POST.get('member_no')
    print(member_no)
    training_set = np.loadtxt(static('csv\interest_recommand2.csv'), delimiter=',', dtype=np.float32)
    # slicing
    x_set = training_set[:, 0:-1]
    y_set = training_set[:, [-1]]

    cursor = connection.cursor()
    try:
        cursor.execute("SELECT member_interest from [dbo].[gim_member] where member_no = " + member_no)
        inter = cursor.fetchone()
        print(inter)
        int_result = []
        result = list(inter)

        if result[0] =='':
            print("관심사 선택안함")

        else :
            result = ",".join(result)
            int_result = result.split(",")
            int_result = [int (i) for i in int_result]  #optimize ex) [1,2,5,9,15,19 ...etc]
            print(int_result)
            #10개 미만일경우에 count해서 10개 채워서 랜덤으로 합치기

        length = len(int_result)

        while True:
            if length < 10:
                ran = randint(1,30)
                for x in range(length):
                    if ran == int_result[x]:
                        ran = randint(1,30)
                        x=0

                int_result.append(ran)
                length = len(int_result)

            elif length == 10:
                break

        print(int_result)

    except:
        print("error")
    finally:
        cursor.close()

    # initialize
    num = 5  # one-hot encoding
    x_num = 10  # number of interests
    y_num = 1  # result

    X = tf.placeholder(tf.float32, [None, x_num])
    Y = tf.placeholder(tf.int32, [None, y_num])

    # One-Hot encoding(0~num), reshape as a one-dimensional array
    Y_one_hot = tf.one_hot(Y, num)
    Y_one_hot = tf.reshape(Y_one_hot, [-1, num])

    W = tf.Variable(tf.random_normal([x_num, num]), name='weight')
    b = tf.Variable(tf.random_normal([num]), name='bias')

    # Calculate WX+b as the product of the matrix
    logits = tf.matmul(X, W) + b
    # Expressed as a probability value using softmax
    hypothesis = tf.nn.softmax(logits)

    # Cross entropy cost and minimize
    cost_i = tf.nn.softmax_cross_entropy_with_logits_v2(logits=logits, labels=Y_one_hot)
    cost = tf.reduce_mean(cost_i)
    optimizer = tf.train.GradientDescentOptimizer(learning_rate=0.001).minimize(cost)

    # Accuracy calculation
    prediction = tf.argmax(hypothesis, y_num)
    correct = tf.equal(prediction, tf.argmax(Y_one_hot, y_num))
    accuracy = tf.reduce_mean(tf.cast(correct, tf.float32))

    # launch graph
    #sess = tf.Session()
    #sess.run(tf.global_variables_initializer())
    with tf.Session() as sess :
        sess.run(tf.global_variables_initializer())

    # The process of machine learning
        for i in range(2000):
            sess.run(optimizer, feed_dict={X: x_set, Y: y_set})
            if i % 100 == 0:
                cost_loss, acc = sess.run([cost, accuracy], feed_dict={X: x_set, Y: y_set})
                print("step :{}, loss :{:.2f}, Acc :{:.1%}".format(i, cost_loss, acc))

        # Put input into the learned model
        select = sess.run(hypothesis, feed_dict={X: [int_result]})
        # Check the selected value through One-hot encoding
        arg = sess.run(tf.argmax(select, 1))
        print(select, arg)

    if arg == 0:
        recommand_set = np.loadtxt(static('csv\course_0.csv'), delimiter=',', dtype=np.str)
        f = open(static('csv\course_0_tude.csv'), 'r', encoding='utf-8')
        f2 = open(static('csv\course_0_3word.txt'), 'r')

    elif arg == 1:
        recommand_set = np.loadtxt(static('csv\course_1.csv'), delimiter=',', dtype=np.str)
        f = open(static('csv\course_1_tude.csv'), 'r', encoding='utf-8')
        f2 = open(static('csv\course_1_3word.txt'), 'r')

    elif arg == 2:
        recommand_set = np.loadtxt(static('csv\course_2.csv'), delimiter=',', dtype=np.str)
        f = open(static('csv\course_2_tude.csv'), 'r', encoding='utf-8')
        f2 = open(static('csv\course_2_3word.txt'), 'r')

    elif arg == 3:
        recommand_set = np.loadtxt(static('csv\course_3.csv'), delimiter=',', dtype=np.str)
        f = open(static('csv\course_3_tude.csv'), 'r', encoding='utf-8')
        f2 = open(static('csv\course_3_3word.txt'), 'r')

    elif arg == 4:
        recommand_set = np.loadtxt(static('csv\course_4.csv'), delimiter=',', dtype=np.str)
        f = open(static('csv\course_4_tude.csv'), 'r', encoding='utf-8')
        f2 = open(static('csv\course_4_3word.txt'), 'r')

############################################################################
    word3_set = f2.read().split()
    print(len(word3_set))
    print(word3_set)
    print()
    f2.close()

############################################################################ 3단어
    rdr = csv.reader(f)
    tude_dummy = []
    for line in rdr :
        tude_dummy.append(line)

    tude_set = list(itertools.chain(*tude_dummy))

    while '' in tude_set:
        tude_set.remove('')
    print(len(tude_set))
    print(tude_set)
    print()
    f.close()
    ############################################################################ 경도 위도

    recom_set = recommand_set[:].flatten()
    list_set = recom_set.tolist()

    while '' in list_set:
        list_set.remove('')

    print(len(list_set))
    print(list_set)

    resultData = {'list_set' : list_set,
                  'tude_set' : tude_set,
                  'word3_set' : word3_set}
    json_data = json.dumps(resultData)
    return HttpResponse(json_data,content_type="application/json")

# Create your views here.
