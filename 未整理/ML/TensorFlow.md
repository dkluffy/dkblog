# Code Notes - 01

## Python

`sys.path.append('..')`
jupyter nbconvert --to script [YOUR_NOTEBOOK].ipynb

## Data

```python
from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=3)


# Data Standardization give data zero mean and unit variance
# (technically should be done after train test split )

X= preprocessing.StandardScaler().fit(X).transform(X)

Feature = pd.concat([Feature,pd.get_dummies(df['education'])], axis=1)
```

```python
# 在dataset batch之后应用，可以有效忽略数据错误，比如文件不存在，1/0等
img_lab_ds = img_lab_ds.apply(tf.data.experimental.ignore_errors())
```

## Model

### model图形化等功能

- tf.keras.utils.plot_model(model) :

> 需要安装: `conda install graphviz`(安装后需要把bin\graphviz 路径加入PATH) `conda install pydotplus`

- model.summary()


### model保存和断点fit

```python
model.save("my_keras_model.h5")
model = keras.models.load_model("my_keras_model.h5")
```

> 注意：自定义模型不能使用这种方法，必须手动`save_weights() and load_weights()`

```python
[...] # build and compile the model
checkpoint_cb = keras.callbacks.ModelCheckpoint("my_keras_model.h5")
history = model.fit(X_train, y_train, epochs=10, callbacks=[checkpoint_cb])

#保存最佳
checkpoint_cb = keras.callbacks.ModelCheckpoint("my_keras_model.h5",
save_best_only=True)

history = model.fit(X_train, y_train, epochs=10,
         validation_data=(X_valid, y_valid),
         callbacks=[checkpoint_cb])
model = keras.models.load_model("my_keras_model.h5") # roll back to best model

#早停
early_stopping_cb = keras.callbacks.EarlyStopping(patience=10,
restore_best_weights=True)
history = model.fit(X_train, y_train, epochs=100,
validation_data=(X_valid, y_valid),
callbacks=[checkpoint_cb, early_stopping_cb])


#Tensor board
[...] # Build and compile your model
tensorboard_cb = keras.callbacks.TensorBoard(run_logdir)
history = model.fit(X_train, y_train, epochs=30,
validation_data=(X_valid, y_valid),
callbacks=[tensorboard_cb])

#in NOTEBOOK
%load_ext tensorboard
%tensorboard --bind_all  --logdir=./my_logs --port=6007

```

```shell

$ tensorboard --logdir=./my_logs --port=6006
TensorBoard 2.0.0 at http://mycomputer.local:6006/ (Press CTRL+C to quit)

python3 -m tensorboard.main
```

### 超参相关

```
Hyperopt

Hyperas, kopt, or Talos

Keras Tuner

Scikit-Optimize (skopt):
A general-purpose optimization library. The BayesSearchCV class
performs Bayesian optimization using an interface similar to
GridSearchCV.

Spearmint

Hyperband

Sklearn-Deap
A hyperparameter optimization library based on evolutionary
algorithms, with a GridSearchCV-like interface.

Moreover,
Google Cloud AI Platform’s hyperparameter tuning service
Other options include services by Arimo and SigOpt, and
CallDesk’s Oscar.
```



## Evaluation

```python
from sklearn import metrics
print("Accuracy: ", metrics.accuracy_score(y_test, predictions))
```

## TF v1.0 迁移到 2.0

- https://tensorflow.google.cn/guide/migrate?hl=zh_cn

It is still possible to run 1.X code, unmodified (except for contrib), in TensorFlow 2.0:

```python
import tensorflow.compat.v1 as tf
tf.disable_v2_behavior()
```


## Loss

```python
#one-hot 用tf.keras.losses.CategoricalCrossentropy()
cce = tf.keras.losses.SparseCategoricalCrossentropy()
loss = cce(
  [0, 1, 2],
  [[.9, .05, .05], [.5, .89, .6], [.05, .01, .94]])
print('Loss: ', loss.numpy())  # Loss: 0.3239
```

https://blog.csdn.net/Hi_maxin/article/details/85281415


## GPU

```python
gpus = tf.config.experimental.list_physical_devices('GPU')
if gpus:
  # Restrict TensorFlow to only allocate 1GB of memory on the first GPU
  try:
    tf.config.experimental.set_virtual_device_configuration(
        gpus[0],
        [tf.config.experimental.VirtualDeviceConfiguration(memory_limit=1024)])
    logical_gpus = tf.config.experimental.list_logical_devices('GPU')
    print(len(gpus), "Physical GPUs,", len(logical_gpus), "Logical GPUs")
  except RuntimeError as e:
    # Virtual devices must be set before GPUs have been initialized
    print(e)
```