# Shell

## 数组

数组元素可以用符号`variable[xx]`来初始化. 另外，脚本可以用`declare -a variable`语句来清楚地指定一个数组. 要访问一个数组元素，可以使用花括号来访问，即`${variable[xx]}`.

### 切片

字符串切片：

    ${#var}: 返回字符串变量var 的长度

    ${var:offset}: 返回 字符串变量var 中从第offset 个字符后（不包括第offset 个字符）的字符开始，到最后的部分，offset的取值在0 到 ${#var}-1 之间(bash4.2后，允许为负值)。

    ${var:offset:number} ：返回 字符串变量var 中从第offset 个字符后（不包括第offset 个字符）的字符开始，长度为number 的部分1。

    `${var: -lengh}` ：取字符串的最右侧几 个字符

    注意：冒号后必须有一空白字符

    ${var:offset: -lengh} ：从最左侧跳过offset 字符，一直取到字符串的最右侧lengh个字符之前。

```bash

#生成随机数
echo ${1:-$$}
echo $RANDOM

# :- :+ :?
# 可以用于 设置默认值
echo ${var:-value} #如果var 为空或未设置，那么返回value ；否则，则返回var 的值。
echo ${var:=value} #与 #- 等价
echo ${var:+value} #与 #-相反
echo ${var:?error_info} #如果var 为空或未设置 ，那么在当前终端打印error_info ；否则，则返回var 的值

```