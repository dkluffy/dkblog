# DeepLearning - Part04

## Convolutional Neural Networks

CNN计算过程

![CNN基础](images/pic01/Im14_14_89.jpg)

CNN中PADING,STRIDE,FILTER,CHANNEL等概念：

### Padding
$$X(m, n_H, n_W, n_C) -padding-> X_o(m, n_H + 2*pad, n_W + 2*pad, n_C)$$

CNN层数越深，输出的矩阵越小，可能在中间某层就变为Shape（1，1，n),padding 很好解决了这个问题，使得即保留原来所有特征，又使得输出不变的太小

It allows you to use a CONV layer without necessarily shrinking the height and width of the volumes. This is important for building deeper networks, since otherwise the height/width would shrink as you go to deeper layers. An important special case is the "same" convolution, in which the height/width is exactly preserved after one layer.

It helps us keep more of the information at the border of an image. Without padding, very few values at the next layer would be affected by pixels as the edges of an image.

### Filter

$$Z=WX+b$$

The formulas relating the output $Z$ shape of the convolution to the input shape is:

$$n_H =\left \lfloor\frac{ n_{H_{prev}} - f + 2  \times pad}{stride} \right \rfloor + 1$$
$$n_W =\left \lfloor\frac{ n_{W_{prev}} - f + 2  \times pad}{stride} \right \rfloor + 1$$
$$n_C =  \text{number of filters used in the convolution}$$

![CNN基础2](images/pic01/Im15_15_95.jpg)

DEEP ConvNet示例：

![DEEP ConvNet示例](images/pic01/Im16_16_101.jpg)

经典 ConvNet：

![经典 ConvNet](images/pic01/Im17_17_108.jpg)

ResNet(残差网络)：

![ResNet](images/pic01/Im18_18_114.jpg)

太深的神经网络训练起来很难，因为有 梯度消失和爆炸这类问题，RESNET就是为了解决这类问题。

## Tips for benchmarks/competitions

- Ensembling:独立训练多个网络，然后取输出平均
- Multi-corp at test time：对测试集进行裁剪以取得多个不同的测试集，最后对结果进行平均

## 算法

### 对象检测和定位

输出
$$Y=\begin{bmatrix}
pc
\\ 
b_x
\\
b_y
\\
b_h
\\
b_w
\\ 
c_1
\\
...
\\
c_n
\end{bmatrix}$$

- $pc = 0,1$ 指示是否存在对象，如果pc=0，则Y中的其他值将变得无关紧要
- $b_x,b_y,b_h,b_w$ 框出对象所在位置和大小
- $C=[0,0,1,...,0]$ one-hot vector 标记对象类别

### landmark detection

- 人脸识别 $[face?, l_{x1},l_{y1},...]$
- 姿势识别

### 滑动窗口实现对象检测和定位

单纯用滑动窗口，计算成本太高，也不能准确定位对象的中心点。

改进：

1. 使用卷积实现滑动窗口检测

把FC(fully connected)层替换成卷积层

假定SOFTMAX分类器网络

X-->Filter-->MaxPool-->FC-->FC-->softmax

X-->Filter-->MaxPool-->Filter-->filter(1,1,n)-->filter(1,1,c)

![conv_sliding win](images/conv_sliding_win.PNG)

>缺点就是对对象的边界仍然不准确

2. Bounding box predictions

YOLO 算法

"You Only Look Once" (YOLO) is a popular algorithm because it achieves high accuracy while also being able to run in real-time. This algorithm "only looks once" at the image in the sense that it requires only one forward propagation pass through the network to make predictions. After non-max suppression, it then outputs recognized objects together with the bounding boxes.

几个关键概念:

- Anchor Box (不同形状的滑动窗口)
- Class score (pc * c)
- IoU (重叠率)
- Non-max suppression （选择Class score最高的BOX，去掉与之重叠率即iOU最高的框）


### Region proposal:R-CNN


## 人脸识别

### 人脸识别（recognition）和 人脸认证（verification）的区别

人脸认证（verification）：输入图像，检测是否是PersonX
人脸识别（recognition）：输入图像，检测是谁（限定某个范围）


Face verification solves an easier 1:1 matching problem; face recognition addresses a harder 1:K matching problem.
The triplet loss is an effective loss function for training a neural network to learn an encoding of a face image.
The same encoding can be used for verification and recognition. Measuring distances between two images' encodings allows you to determine whether they are pictures of the same person.

### One Shot Learning

需要识别某个人是否是数据库中的某人，数据库中只有该人的一张样本。

- 不能应用SOFTMAX，因为没有足够数据
- 如果应用SOFTMAX，当又新人加入时，你需要重新训练

解决办法：Siamese Network(双生网络)和TRIPLET LOSS

通过一个Siamese Network(双生网络)计算d(imag1,imag2)，
如果d很大，则两个人为不同人，否则为同一个人。
$$\mid \mid f(A^{(i)}) - f(P^{(i)}) \mid \mid_2^2 + \alpha < \mid \mid f(A^{(i)}) - f(N^{(i)}) \mid \mid_2^2$$

## Neural Style Transfer

- 随机初始化G
- Build the content cost function $J_{content}(C,G)$
- Build the style cost function $J_{style}(S,G)$
- Put it together to get $J(G) = \alpha J_{content}(C,G) + \beta J_{style}(S,G)$.

















