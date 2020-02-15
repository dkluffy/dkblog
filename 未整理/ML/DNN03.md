# DeepLearning - Part03

## 设置目标

### 使用单一量化评估指标

例如定义精确率(percision) 和 召回率 (recall)：
ClassificationA ： P=95% R=90%
ClassificationB： P=90 R=98%

- `精准率`识别出是包含有猫的集合中有多少百分比真正是猫；因此分类器A有95%的精准率 就意味着 A如果把一张图片分类为猫 那么95%可能它就是猫
- `召回率`对于所有是猫的图片 你的分类器有多少百分比可以正确的识别出来 即多少比率的真猫被正确的识别出了;因此如果分类器A的召回率是90% 意味着 你验证集中真猫的图片 分类器A正确分出了90%

两个指标会难以判定，哪个分类器更好，所以可以设定单一指标`F1 Score = 2/(1/P + 1/R)` 来做参考

### 满意度和优化指标

在最大化优化指标（如：准确率）的情况下，提高满意度（如：运行时间）

### 数据集选择

TEST/DEV数据集应该能真实反应未来的应用环境的数据分布。

### 数据集划分

- 在较小数据集（<10000):  TRAIN/DEV/TEST [60:20:20] 或 [70:0:30]
- 在大数据集（>1M）: TRAIN/DEV/TEST [98:1:1]

TEST数据集需要足够大以保证高确信度

### 与人类对比

缩小HUMAN 与 TRAIN 差距(偏差)：

    - 更大的网络
    - 训练更长，优化
    - 改变DNN网络结构或超参

缩小TRAIN与DEV差距（方差：即模型过拟合DEV）：
    - 更多训练数据
    - 正则化
    - 改变DNN结构

>详细参考作业: PDF/03_01.PDF

## Mismatched training and dev/test set

- training and dev/test set 不同，例如training data是购买的，而dev/test的数据是真实用户数据，也是你的目标数据。

- 把真实用户数据打乱后[1:1:1]分别放入 training and dev/test set

- 把一小部分购买数据放入DEV/TEST SET

- 如何确定方差还是偏差：
  - 从训练数据从取一部分 放入 Training-dev set，不用于训练，值用于验证
  - 如果training-error(1%)<< training-dev-error(9%) ~= Dev-error(10%):那么可以断定`方差过大`
  - 如果training-error(1%)~= training-dev-error(1.5%)<< Dev-error(10%):那么`数据不匹配`
  - 如果human-error(1%) << training-error(10%):`偏差过大`

- 解决`数据不匹配`：增加训练数据

## transfer learning

- Task A and B 有相同的输入X（例如都是图片，都是声音等）
- Task A比Task B的数据多
- Low level features from A could be helpful for Learning B

## multi-task learning

