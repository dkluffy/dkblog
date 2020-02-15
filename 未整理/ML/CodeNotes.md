# Notes of Code


## Normalize Data

Data Standardization give data zero mean and unit variance, it is good practice, especially for algorithms such as KNN which is based on distance of cases:

```python
X = preprocessing.StandardScaler().fit(X).transform(X.astype(float))
```

## 数据自动分割

```python
from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split( X, y, test_size=0.2, random_state=4)
```

### 连接RNN CNN

```python
# Now let's get a tensor with the output of our vision model:
image_input = Input(shape=(224, 224, 3))
encoded_image = vision_model(image_input)

# Next, let's define a language model to encode the question into a vector.
# Each question will be at most 100 words long,
# and we will index words as integers from 1 to 9999.
question_input = Input(shape=(100,), dtype='int32')
embedded_question = Embedding(input_dim=10000, output_dim=256, input_length=100)(question_input)
encoded_question = LSTM(256)(embedded_question)

# Let's concatenate the question vector and the image vector:
merged = keras.layers.concatenate([encoded_question, encoded_image])

# And let's train a logistic regression over 1000 words on top:
output = Dense(1000, activation='softmax')(merged)

# This is our final model:
vqa_model = Model(inputs=[image_input, question_input], outputs=output)

#####################
#https://stackoverflow.com/questions/52032312/

model.add(Conv2D(32, kernel_size=(3, 3), activation='relu', input_shape=in_shape))
model.add(Conv2D(64, (3, 3), activation='relu'))
# NO MORE POOLING
model.add(Dropout(0.25))
# Reshape with the first argument being the number of filter in your last conv layer
model.add(Reshape((64, -1)))
# Just write this Permute after, its complicated why
model.add(Permute((2, 1)))
# it can also be an LSTM
model.add(SimpleRNN(128, activation='relu'))
model.add(Dropout(0.5))
model.add(Dense(num_classes, activation='softmax'))

```

## Numpy

### 矩阵展开

A trick when you want to flatten a matrix X of `shape (a,b,c,d)` to a matrix X_flatten of `shape (b∗c∗d, a)` is to use:

```python
X_flatten = X.reshape(X.shape[0], -1).T
```


## Pandas

[Examples On GitHub](https://github.com/guipsamora/pandas_exercises)


```python
data.isnull().sum()

data.query('day == 1')
```

```python
>>> @timeit(repeat=3, number=100)
>>> def convert_with_format(df, column_name):
...     return pd.to_datetime(df[column_name],
...                           format='%d/%m/%y %H:%M')
Best of 3 trials with 100 function calls per trial:
Function `convert_with_format` ran in average of 0.032 seconds.

# 结果只有0.032s，快了将近50倍。原因是：我们设置了转化的格式format。由于在CSV中的datetimes并不是 ISO 8601 格式的，如果不进行设置的话，那么pandas将使用 dateutil 包把每个字符串str转化成date日期。

#相反，如果原始数据datetime已经是 ISO 8601 格式了，那么pandas就可以立即使用最快速的方法来解析日期。这也就是为什么提前设置好格式format可以提升这么多

@timeit(repeat=3, number=100)
def apply_tariff_isin(df):
# 定义小时范围Boolean数组
    peak_hours = df.index.hour.isin(range(17, 24))
    shoulder_hours = df.index.hour.isin(range(7, 17))
    off_peak_hours = df.index.hour.isin(range(0, 7))

    # 使用上面的定义
    df.loc[peak_hours, 'cost_cents'] = df.loc[peak_hours, 'energy_kwh'] * 28
    df.loc[shoulder_hours,'cost_cents'] = df.loc[shoulder_hours, 'energy_kwh'] * 20
    df.loc[off_peak_hours,'cost_cents'] = df.loc[off_peak_hours, 'energy_kwh'] * 12

```

- 尝试尽可能使用矢量化操作，而不是在df 中解决for x的问题。如果你的代码是许多for循环，那么它可能更适合使用本机Python数据结构，因为Pandas会带来很多开销。
- 如果你有更复杂的操作，其中矢量化根本不可能或太难以有效地解决，请使用.apply方法。
- 如果必须循环遍历数组（确实发生了这种情况），请使用.iterrows()或.itertuples()来提高速度和语法。
- Pandas有很多可选性，几乎总有几种方法可以从A到B。请注意这一点，比较-不同方法的执行方式，并选择在项目环境中效果最佳的路线。
- 一旦建立了数据清理脚本，就可以通过使用HDFStore存储中间结果来避免重新处理。
- 将NumPy集成到Pandas操作中通常可以提高速度并简化语法。
`使用NumPy的 digitize() 函数。它类似于Pandas的cut()，因为数据将被分箱，但这次它将由一个索引数组表示，这些索引表示每小时所属的bin。`