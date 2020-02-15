# Kaggle DataScince


## ReadLater

算法文档：

[算法文档-H2O](http://docs.h2o.ai/h2o/latest-stable/h2o-docs/data-science.html)

- Vowpal Wabbit repository
- XGBoost repository
- LightGBM repository

**[分类器可视化](https://scikit-learn.org/stable/auto_examples/classification/plot_classifier_comparison.html)**


## Q&A

### Suppose we've trained a `RandomForest model` with 100 trees. Consider two cases

1. We drop the first tree in the model
2. We drop the last tree in the model
We then compare models performance on the train set.

`In RandomForest model we average 100 similar performing trees, trained independently. So the order of trees does not matter in RandomForest and performance drop will be very similar on average.`

### Suppose we've trained a `GBDT model` with 100 trees with a fairly high learning rate. Consider two cases:

1. We drop the first tree in the model
2. We drop the last tree in the model
We then compare models performance on the train set. Select the right answer.

`In the case1 performance will drop more than in the case2. In GBDT model we have sequence of trees, each improve predictions of all previous. So, if we drop first tree — sum of all the rest trees will be biased and overall performance should drop. If we drop the last tree -- sum of all previous tree won't be affected, so performance will change insignificantly (in case we have enough trees)`

### Question 4

Consider the two cases:
1. We fit two RandomForestClassifiers 500 trees each and average their predicted probabilities on the test set.
2. We fit a RandomForestClassifier with 1000 trees and use it to get test set probabilities.
All hyperparameters except number of trees are the same for all models.Select the right answer.

`The quality of predictions in the case1 will be roughly the same as the quality of the predictions in the case2. Each tree in forest is independent from the others, so two RF with 500 trees is essentially the same as single RF model with 1000 trees`

### Suppose we fit a tree-based model. In which cases label encoding can be better to use than one-hot encoding?

- `When categorical feature is ordinal`. Correct! Label encoding can lead to better quality if it preserves correct order of values. In this case a split made by a tree will divide the feature to values 'lower' and 'higher' that the value chosen for this split.

- `When we can come up with label encoder, that assigns close labels to similar (in terms of target) categories`. Correct! First, in this case tree will achieve the same quality with less amount of splits, and second, this encoding will help to treat rare categories.

- `When the number of categorical features in the dataset is huge`. One-hot encoding a categorical feature with huge number of values can lead to (1) high memory consumption and (2) the case when non-categorical features are rarely used by model. You can deal with the 1st case if you employ sparse matrices. The 2nd case can occur if you build a tree using only a subset of features. For example, if you have 9 numeric features and 1 categorical with 100 unique values and you one-hot-encoded that categorical feature, you will get 109 features. If a tree is built with only a subset of features, initial 9 numeric features will rarely be used. In this case, you can increase the parameter controlling size of this subset. In xgboost it is called colsample_bytree, in sklearn's Random Forest max_features.


## 数据预处理

### 数值

- Tree-based 模型（decision-tree）不依赖scaling

- Non-tree-based（KNN,DNN,LINEAR） 依赖scaling,尤其DNN

- 常用预处理：
    - a. MinMaxScaler - to [0,1]
    - b. StandardScaler - to mean==0,std==1
    - c. Rank - set spaces between sorted values to be equal
    - d. np.log(1+x) and np.sqrt(1+x)

- Feature generation is powered by understanding the data:
    - a. Prior knowledge
    - b. Exploratory data analysi(EDA)

### 类别、序号

- values in `ordinal features` are sorted in some meaningful order

- `label encoding`maps categories to numbers

- `frequency encoding` maps categories to their frequencies

- `label,frequency` encoding are often used to tree-based-models

- `one-hot` encoding is often used for non-tree-b

- `interactions of categorical features` can help linear models  and knn


### 时间、坐标

#### Datetime

- periodicity

- time since row-indepent/dependent event

- diff beteen dates

#### coordinates

- interesting places from train/test data or additional data

- centers of clusters

- aggregated statistics

### 缺失值

- fill NaN的方法依情况而定

- 常用fill： -999（异常值），mean,median

- missing values already can be replaced with something by organizers

- binary features "isnull" can beneficial

- in general, `avoid` filling nans `before feature generation`

- Xgboost can handle NaN

### EDA



