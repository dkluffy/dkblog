# DeepLearning - Part05

## Sequence Models

### 序列问题

语音、音乐合成、DNA、情绪识别（NLP）、视频、人名识别等

### 单词表示

- 建立一个词汇表，每个单词有对应一个INDEX
- 未知单词使用伪单词如 “UNKW”
- 用ONE-HOT向量表示每个单词，即对应INDEX=1，其余为0

### RNN - Recurrent Neural Network

#### Cell - Forward

$t$ 为时刻/step
$$a^{\langle t \rangle} = g(W_{aa} a^{\langle t-1 \rangle} + W_{ax} x^{\langle t \rangle} + b_a)$$
$$a^{\langle t \rangle} = g(W_{a} [ a^{\langle t-1 \rangle} , x^{\langle t \rangle} ] + b_a)$$

#### 堆叠

$$W_{a} = [W_{aa},W_{ax}]$$
$$[ a^{\langle t-1 \rangle} , x^{\langle t \rangle} ] = \begin{bmatrix}
a^{\langle t-1 \rangle}
\\ 
x^{\langle t \rangle}
\end{bmatrix}$$

$\hat{y}^{\langle t \rangle} = g(W_{ya} a^{\langle t \rangle} + b_y)$

$X$ shape $(n_x, m, T_x)$,m为样本数量，$T_x$是总时刻数，$n_x$为表示X的one-hot vector的维度

$W_{aa}$ shape $(n_a, n_a)$

$W_{ax}$ shape $(n_a, n_x)$

#### RNN结构

- M to M ($T_x = T_y$)
- 1 to Many：音乐生产
- M to 1:情绪分析
- M to M ($T_x \neq T_y$):机器翻译

### Long Short-Term Memory (LSTM) network



### NLP & Word Embeddings

#### Sampling

Carry out sampling: Pick the next character's index according to the probability distribution specified by $\hat{y}^{\langle t+1 \rangle }$. This means that if $\hat{y}^{\langle t+1 \rangle }_i = 0.16$, you will pick the index "i" with 16% probability. To implement it, you can use [`np.random.choice`](https://docs.scipy.org/doc/numpy-1.13.0/reference/generated/numpy.random.choice.html).

Here is an example of how to use `np.random.choice()`:
```python
np.random.seed(0)
p = np.array([0.1, 0.0, 0.7, 0.2])
index = np.random.choice([0, 1, 2, 3], p = p.ravel())
```
This means that you will pick the `index` according to the distribution: 
$P(index = 0) = 0.1, P(index = 1) = 0.0, P(index = 2) = 0.7, P(index = 3) = 0.2$.

### Squence Models & Attention mechanism

