# FC CNN

http://cs231n.github.io/convolutional-networks/#conv

https://mp.weixin.qq.com/s/gC_kojhrvSx6KO1-sq1TSQ

## Model

### 密集层与1x1卷积

该代码包括密集层（注释掉）和1x1卷积。在使用两种配置构建和训练模型之后，这里是一些观察结果：


1. 两种模型都包含相同数量的可训练参数。

2. 类似的训练和推理时间。

3. 密集层比1x1卷积的泛化效果更好。


第三点不能一概而论，因为它取决于诸如数据集中的图像数量，使用的数据扩充，模型初始化等因素。但是这些是实验中的观察结果。

```python
# Uncomment the below line if you're using dense layers
# x = tf.keras.layers.GlobalMaxPooling2D()(x)
 
# Fully connected layer 1
# x = tf.keras.layers.Dropout(dropout_rate)(x)
# x = tf.keras.layers.BatchNormalization()(x)
# x = tf.keras.layers.Dense(units=64)(x)
# x = tf.keras.layers.Activation('relu')(x)
 
# Fully connected layer 1
x = tf.keras.layers.Conv2D(filters=64, kernel_size=1, strides=1)(x)
x = tf.keras.layers.Dropout(dropout_rate)(x)
x = tf.keras.layers.BatchNormalization()(x)
x = tf.keras.layers.Activation('relu')(x)
 
# Fully connected layer 2
# x = tf.keras.layers.Dropout(dropout_rate)(x)
# x = tf.keras.layers.BatchNormalization()(x)
# x = tf.keras.layers.Dense(units=len_classes)(x)
# predictions = tf.keras.layers.Activation('softmax')(x)

# Fully connected layer 2
"""
最后一层的设计：应该最少满足1*1*len_classes
"""
x = tf.keras.layers.Conv2D(filters=len_classes, kernel_size=1, strides=1)(x)
x = tf.keras.layers.Dropout(dropout_rate)(x)
x = tf.keras.layers.BatchNormalization()(x)
x = tf.keras.layers.GlobalMaxPooling2D()(x)
predictions = tf.keras.layers.Activation('softmax')(x)

model = tf.keras.Model(inputs=input, outputs=predictions)
print(model.summary())
```

### 图像处理

找到批处理中图像的最大高度和宽度，并用零填充每个其他图像，以使批处理中的每个图像都具有相等的尺寸。现在可以轻松地将其转换为numpy数组或张量，并将其传递给fit_generator()。该模型会自动学习忽略零（基本上是黑色像素），并从填充图像的预期部分学习特征。这样就有了一个具有相等图像尺寸的批处理，但是每个批处理具有不同的形状（由于批处理中图像的最大高度和宽度不同）。

```python

def construct_image_batch(image_group, BATCH_SIZE):
    # get the max image shape
    max_shape = tuple(max(image.shape[x] for image in image_group) for x in range(3))
 
    # construct an image batch object
    image_batch = np.zeros((BATCH_SIZE,) + max_shape, dtype='float32')
 
    # copy all images to the upper left part of the image batch object
    for image_index, image in enumerate(image_group):
        image_batch[image_index, :image.shape[0], :image.shape[1], :image.shape[2]] = image
 
    return image_batch
```