# Datasets

## curl/wget

```bash
!curl -O -J -L --cookie "intercom-id-koj6gxx6=:.." https://www.kaggle.com/stanfordu/street-view-house-numbers/download

#or use
kaggle-cli/kaggle api
```


## Colab

```bash
%tensorflow_version 2.x
import tensorflow as tf
print(tf.__version__)
!apt-get install unzip
```

## GPU

```python
tf.config.experimental.list_physical_devices('GPU')
with tf.device("/GPU:0"):
    ...
```