# DeepLearning - Part02

## Improving Deep Neural Networks: Hyperparameter tuning, Regularization and Optimization

- 合理的数据集划分
- 正则化
- 输入归一化
- 参数初始化（HE初始化）
- mini-batch
- 梯度下降优化(EWA,RMSprop,Adam)
- 学习速率衰减
- 超参调节
- 批归一化（中间值Z）

### 数据集划分

- 经典ML(100~10000)

    Train/Dev/Test `60% ： 20% ：20%`

- DL(1M or More)

  Train/Dev/Test `98% ： 1% ：1%`

三个数据集必须是来自相同的分布

参考： PDF: pdf/02_01.pdf

### Bias (偏差)) and Variance(方差)

- 高偏差 - 欠拟合
- 高方差 - 过拟合

- 高偏差(HIGH BIAS) - 欠拟合: 更大的网络；训练更久些
- 高方差(HIGH VARIANCE) - 过拟合: 更多的训练数据;**正则化(Regularization)**

### 正则化(Regularization)

- `L2`

以最小化损失和复杂度为目标，这称为结构风险最小化:

$$J=minimize(Loss(Data|Model) + complexity(Model))$$

$$J_{regularized} = \small \underbrace{-\frac{1}{m} \sum\limits_{i = 1}^{m} \large{(}\small y^{(i)}\log\left(a^{[L](i)}\right) + (1-y^{(i)})\log\left(1- a^{[L](i)}\right) \large{)} }_\text{cross-entropy cost} + \underbrace{\frac{1}{m} \frac{\lambda}{2} \sum\limits_l\sum\limits_k\sum\limits_j W_{k,j}^{[l]2} }_\text{L2 regularization cost} \tag{2}$$

一个是损失项，用于衡量模型与数据的拟合度，另一个是正则化项，用于衡量模型复杂度

**Observations**:

- The value of $\lambda$ is a hyperparameter(超参) that you can tune using a dev set.
- L2 regularization makes your decision boundary smoother. If $\lambda$ is too large, it is also possible to "oversmooth", resulting in a model with high bias.

**What is L2-regularization actually doing?**:

L2-regularization relies on the assumption that a model with small weights is simpler than a model with large weights. Thus, by penalizing the square values of the weights in the cost function you drive all the weights `to smaller values`. It becomes too costly for the cost to have large weights! This leads to a smoother model in which the output changes more slowly as the input changes.

**为什么正则化治理过拟合**：

`机器学习细则`
以下三项基本假设阐明了泛化：

- 我们从分布中随机抽取独立同分布 (i.i.d) 的样本。换言之，样本之间不会互相影响。（另一种解释：i.i.d. 是表示变量随机性的一种方式）。
- 分布是平稳的；即分布在数据集内不会发生变化。
- 我们从同一分布的数据划分中抽取样本。

> 在实践中，我们有时会违背这些假设。例如：
想象有一个选择要展示的广告的模型。如果该模型在某种程度上根据用户以前看过的广告选择广告，则会违背 i.i.d. 假设。
想象有一个包含一年零售信息的数据集。用户的购买行为会出现季节性变化，这会违反平稳性。
如果违背了上述三项基本假设中的任何一项，那么我们就必须密切注意指标。

某个模型的训练损失逐渐减少，但验证损失最终增加。换言之，该泛化曲线显示该模型与训练集中的数据过拟合。根据奥卡姆剃刀定律，或许我们可以通过降低复杂模型的复杂度来防止过拟合，这种原则称为正则化。

https://developers.google.cn/machine-learning/crash-course/regularization-for-simplicity/l2-regularization

- `Dropout`

You `only` use dropout during `training`. Don't use dropout (randomly eliminate nodes) during test time.
Apply dropout `both` during forward and backward propagation.

- `L1 稀疏性正则化` (Regularization for Sparsity)

稀疏矢量通常包含许多维度。创建特征组合会导致包含更多维度。由于使用此类高维度特征矢量，因此模型可能会非常庞大，并且需要大量的 RAM。
在高维度稀疏矢量中，最好尽可能使权重正好降至 0。正好为 0 的权重基本上会使相应特征从模型中移除。 将特征设为 0 可节省 RAM 空间，且可以减少模型中的噪点.

>L2 和 L1 采用不同的方式降低权重：
>L2 会降低$W^2$。 <----> L1 会降低$|W|$。
>因此，L2 和 L1 具有不同的导数：
>L2 的导数为 $2W$。<----> L1 的导数为 $K$（一个常数，其值与权重无关）

L1 正则化 - 减少所有权重的绝对值 - 证明对宽度模型非常有效。
https://developers.google.cn/machine-learning/crash-course/regularization-for-sparsity/l1-regularization

- `Other`:
  - `Data Augmentation`
  - `Early Stopping`

--------------------

### 优化

### 优化参数初始化

> nb/Initialization.ipynb

好的参数初始化：

- Speed up the convergence of gradient descent
- Increase the odds of gradient descent converging to a lower training (and generalization) error

#### 1. 初始化为0

fails to break symmetry

#### 2. 过大

```python
parameters['W' + str(l)] = np.random.randn(layers_dims[l], layers_dims[l-1])*10
parameters['b' + str(l)] = np.zeros((layers_dims[l], 1))
```

1. `The cost starts very high`. This is because with large random-valued weights, the last activation (sigmoid) outputs results that are very close to 0 or 1 for some examples, and when it gets that example wrong it incurs a very high loss for that example. Indeed, when $\log(a^{[3]}) = \log(0)$, the loss goes to infinity.
2. Poor initialization can lead to `vanishing/exploding gradients`, which also slows down the optimization algorithm.
3. If you train this network longer you will see better results, but initializing with overly large random numbers `slows down the optimization`.

#### 3. He initialization（合适）

this is similar except `Xavier initialization` uses a scaling factor for the weights $W^{[l]}$ of `sqrt(1./layers_dims[l-1])` where He initialization would use `sqrt(2./layers_dims[l-1])`.

### 输入归一化 Normalizing Inputs

让$X$分布于中心（0，0）附近，并让$0<=|X|<=1$。
归一化后，可以让$J$更接近于圆形，从而可以使用更大的学习速率来进行学习

### 梯度下降优化

#### mini-batch grad desent

在梯度下降法中，**批量**指的是用于在单次迭代中计算梯度的样本总数。

>单次迭代:就是输入n个样本，计算梯度，更新参数的一次完整计算

1. 一般梯度下降：
    - 单次输入整个数据集（$m$个样本），即$X.shape = n_x \times m$, `batch_size=m`
    - 遍历整个数据集一次`1 epoch`需要需要计算`batch_size/m = 1`次
    - 在总样本m<2000等小规模的场景适用。

2. mini-batch SGD:
    - 单次输入$mb$个样本,即$X.shape = n_x \times mb$, `batch_size=mb`
    - `1 epoch`需要计算`batch_size/mb` 次
    - mb最好取值$2^n$，如64，128，512，有利于CPU计算
    - 使用时，应先Shuffle整个数据集，然后分区Partition

3. 随机梯度下降(SGD)：
    - 单次输入1个样本，即mini-batch SGD中`batch_size=1`

#### 梯度优化

##### 指数加权平均（exponentially weighted averages EWA）：

$$v_{dW^{[t]}} = \beta v_{dW^{[t-1]}} + (1 - \beta) dW^{[t]}$$
$dW^{[t]}$是$t$时刻对应的梯度，$v_{dW^{[t-1]}}$是$t-1$时刻EWA值，越靠近$t$时刻的$dW$值对$v_{dW^{[t]}}$影响/贡献越大。

##### 带动量的梯度更新

$$\left\{\begin{matrix}
v_{dW^{[l]}} = \beta v_{dW^{[l]}} + (1 - \beta) dW^{[l]}
\\ 
W^{[l]} = W^{[l]} - \alpha v_{dW^{[l]}}
\end{matrix}\right.$$

$$\left\{\begin{matrix}
v_{db^{[l]}} = \beta v_{db^{[l]}} + (1 - \beta) db^{[l]}
\\ 
b^{[l]} = b^{[l]} - \alpha v_{db^{[l]}}
\end{matrix}\right.$$

- 这样的效果就是，可以稳定梯度矢量更新方向，以达到更快收敛的目的。
- 如果$\beta  = 0$即成为普通的梯度更新
- 一般$\beta$取值在（0.8，0.999）之间

##### RMSProp - Root Mean Squared 均方根传递

$$s_{dW^{[l]}} = \beta_2 s_{dW^{[l]}} + (1 - \beta_2) (dW^{[l]})^2$$
$$W^{[l]} = W^{[l]} - \alpha \frac{dW}{\sqrt{s_{dW^{[l]}}}}$$

##### Adam

- 结合RMSProp和动量梯度更新

1. It calculates an exponentially weighted average of past gradients, and stores it in variables $v$ (before bias correction) and $v^{corrected}$ (with bias correction). 
2. It calculates an exponentially weighted average of the squares of the past gradients, and  stores it in variables $s$ (before bias correction) and $s^{corrected}$ (with bias correction). 
3. It updates parameters in a direction based on combining information from "1" and "2".

The update rule is, for $l = 1, ..., L$:
$$v_{dW^{[l]}} = \beta_1 v_{dW^{[l]}} + (1 - \beta_1) \frac{\partial \mathcal{J} }{ \partial W^{[l]} }$$

$$v^{corrected}_{dW^{[l]}} = \frac{v_{dW^{[l]}}}{1 - (\beta_1)^t}$$

$$s_{dW^{[l]}} = \beta_2 s_{dW^{[l]}} + (1 - \beta_2) (\frac{\partial \mathcal{J} }{\partial W^{[l]} })^2$$

$$s^{corrected}_{dW^{[l]}} = \frac{s_{dW^{[l]}}}{1 - (\beta_2)^t}$$

$$W^{[l]} = W^{[l]} - \alpha \frac{v^{corrected}_{dW^{[l]}}}{\sqrt{s^{corrected}_{dW^{[l]}}} + \varepsilon}$$

where:

- t counts the number of steps taken of Adam
- L is the number of layers
- $\beta_1$ and $\beta_2$ are hyperparameters that control the two exponentially weighted averages.
- $\alpha$ is the learning rate
- $\varepsilon$ is a very small number to avoid dividing by zero

Some advantages of Adam include:

- Relatively low memory requirements (though higher than gradient descent and gradient descent with momentum)
- Usually works well even with little tuning of hyperparameters (except $\alpha$)

### 学习速率衰减learning rate decay

- 在开始训练的时候，我们使用较大的学习速率，使得模型尽快靠近收敛点
- 越靠近收敛点，我们使用越小的学习速率来减小震荡，使得模型更快收敛

方法有以下：

- $\alpha = \frac{1}{1+D_{decayRate} \times E_{epochNum}} \times \alpha$
- $\alpha = 0.95^{epochNum} \times \alpha$
- 手动调节：按时间每日或每小时调节等

### 超参调节HyperParameter tuning

超参优先级（由高到低）

- 学习速率$\alpha$
- 层的隐藏单元数
- mini-batch size
- 梯度下降优化中的$\beta =0.9$
- 层数
- 学习速率衰减模式
- Adam：$\beta_1=0.9, \beta_2=0.999,\varepsilon=10^{-8}$

不要使用GRID方法逐个取测试HP，而是使用随机抽样：

1. 在超参区域Area(hp1,hp2...)中随机选择K个点
2. 在K个点中选出T个最优的点，划定一个小区域Area_Best来包含这几个最优点
3. 重复1，2步骤，直到找到相对较优

随机抽样的尺度问题：

并不是所有参数都可以用平均尺，例如学习速率应使用对数尺
`r=-4*random(-4,0); lr=10^r`

### Batch Normalization（批归一化）

归一化 神经网络的中间值$Z$,即输入激活函数之前的中间值
好处是减小前一层的噪音的影响
（详细见视频）