# 机器学习算法

## 贝叶斯分类器

贝叶斯分类器直接用贝叶斯公式解决分类问题。假设样本的特征向量为x，类别标签为y，根据贝叶斯公式，样本属于每个类的条件概率（后验概率）为：
$$P(y|x) = \frac{P(x|y)P(y)}{P(x)}$$

分母`p(x)`对所有类都是相同的，分类的规则是将样本归到后验概率最大的那个类，不需要计算准确的概率值，只需要知道属于哪个类的概率最大即可，这样可以忽略掉分母。分类器的判别函数为：

$$argmax_y(P(x|y)P(y))$$

在实现贝叶斯分类器时，需要知道每个类的条件概率分布p(x|y)即先验概率。一般假设样本服从正态分布。训练时确定先验概率分布的参数，一般用最大似然估计，即最大化对数似然函数。

## 决策树

`don’t require feature scaling or centering at all.`

决策树在本质上是一组嵌套的if-else判定规则，从数学上看是分段常数函数，对应于用平行于坐标轴的平面对空间的划分。

训练时，通过*最小化*`Gini score`或者其他指标来寻找最佳分裂。决策树可以输特征向量每个分量的重要性。

决策树是一种判别模型，既支持分类问题，也支持回归问题，是一种非线性模型（分段线性函数不是线性的）。它天然地支持多分类问题。

### Gini score

$$G_i =1 - \sum_{k=1}^{n}p_{i,k}^2$$

$p_{i,k}$ 是第i个Node中，class k实例的比例，n是总类别数

例如：第i个node中，总共有 10 个实例，三个类别的比例分别是1/10, 2/10, 7/10.

那么G = 1- （1/10）^2 - (2/10)^2 - (7/10)^2

### DT porba

第i个Node中，class k实例的比例 即对应该class的概率

```python
>>> tree_clf.predict_proba([[5, 1.5]])
array([[0. , 0.90740741, 0.09259259]])
```

### DT回归

This tree looks very similar to the classification tree you built earlier. The main difference is
that instead of predicting a class in each node, it predicts a value.This prediction is the
`average target value` of the 110 training instances associated with this leaf node

### Hyperparameters

```python
max_depth
min_samples_split, min_samples_leaf,min_weight_fraction_leaf, max_leaf_nodes
```

### 缺点

- sensitive to training set rotation
- very sensitive to small variations in the training data
- Actually, since the training algorithm used by
Scikit-Learn is stochastic, you may get very different models even on the same training data
(unless you set the random_state hyperparameter).



## KNN

kNN算法本质上使用了模板匹配的思想。要确定一个样本的类别，可以计算它与所有训练样本的距离，然后找出和该样本最接近的k个样本，统计这些样本的类别进行投票，票数最多的那个类就是分类结果.kNN算法是一种判别模型，既支持分类问题，也支持回归问题。它是一种非线性模型，天然地支持多分类问题。kNN算法没有训练过程，是一种基于实例的算法。



## SVM

[SIGAI SVM](http://www.tensorinfinity.com/paper_217.html)

支持向量机的目标是寻找一个`分类超平面`，它不仅能正确的分类每一个样本，并且要使得每一类样本中距离超平面最近的样本到超平面的`距离尽可能远`。

## PCA

核心：向重构误差最小（方差最大）的方向做线性投影
PCA是一种数据降维和去除相关性的方法，它通过线性变换将向量投影到低维空间。对向量进行投影就是让向量左乘一个矩阵得到结果向量，这是线性代数中讲述的线性变换：

y = Wx

降维要确保的是在低维空间中的投影能很好的近似表达原始向量，即重构误差最小化。

PCA是一种无监督的学习算法，它是线性模型，不能直接用于分类和回归问题。

## logistic回归

核心：直接从样本估计出它属于正负样本的概率

通过先将向量进行线性加权，然后计算logistic函数，可以得到[0,1]之间的概率值，它表示样本x属于正样本的概率：

$$h(x) = sigmoid(W^TX) = \frac{1}{1+e^{-W^TX}}$$

正样本标签值为1，负样本为0。训练时，求解的的是对数似然函数(Cost J)
：

$$J_cost = max\sum (y_i\log h(x_i) + (1-y_i)\log (1 - h(x_i)) )$$

这是一个凸优化问题，求解时可以用梯度下降法，也可以用牛顿法。logistic回归是一种判别模型，需要注意的是它是一种线性模型，用于二分类问题。

## 随机森林

核心：用有放回采样的样本训练多棵决策树，训练决策树的每个节点时只用了无放回抽样的部分特征，预测时用这些树的预测结果进行投票

`随机森林是一种集成学习算法`，它由`多棵决策树组成`。这些决策树用对训练样本集随抽样构造出样本集训练得到。随机森林不仅对`训练样本`进行抽样，还对`特征向量的分量随机抽样`，在训练决策树时，每次分裂时只使用一部分抽样的特征分量作为候选特征进行分裂。

对于分类问题，一个测试样本会送到每一棵决策树中进行预测，然后投票，得票最多的类为最终分类结果。对于回归问题随机森林的预测输出是所有决策树输出的均值。

假设有n个训练样本。训练每一棵树时，从样本集中有放回的抽取n个样本，每个样本可能会被抽中多次，也可能一次都没抽中。用这个抽样的样本集训练一棵决策树，训练时，每次寻找最佳分裂时，还要对特征向量的分量采样，即只考虑部分特征分量。

随机森林是一种判别模型，既支持分类问题，也支持回归问题，并且支持多分类问题。这是一种非线性模型。


## AdaBoost算法

核心：用多个分类器的线性组合来预测，训练时重点关注错分的样本，准确率高的弱分类器权重大

AdaBoost算法的全称是自适应boosting（Adaptive Boosting），是一种用于二分类问题的算法，它用弱分类器的线性组合来构造强分类器。弱分类器的性能不用太好，仅比随机猜测强，依靠它们可以构造出一个非常准确的强分类器。

## K均值算法 k-means

核心：把样本分配到离它最近的类中心所属的类，类中心由属于这个类的所有样本确定

k均值算法是一种无监督的聚类算法。算法将每个样本分配到离它最近的那个类中心所代表的类，而类中心的确定又依赖于样本的分配方案。

## TF-IDF

- TF-IDF（term frequency–inverse document frequency）是一种用于信息检索与数据挖掘的常用加权技术。
- TF-IDF倾向于过滤掉常见的词语，保留重要的词语
- TF = 该词在单个文件中的出现次数 / 在单个文件中`所有字词`的出现次数之和
- IDF = 语料库中的文件总数 / 包含词语的文件数目（即的文件数目）如果该词语不在语料库中，就会导致分母为零，因此一般情况下使用$1+t$作为分母
- TF-IDF = TF*IDF