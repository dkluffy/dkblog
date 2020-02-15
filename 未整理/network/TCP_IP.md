# TCP/IP

## TCP

### 超时

对每个连接，T C P管理4个不同的定时器。

1) 重传定时器使用于当希望收到另一端的确认。 
    连续重传之间不同的时间差，它们取整后分别为1、3、6、12、24、48和多个64秒
2) 坚持( p e r s i s t )定时器使窗口大小信息保持不断流动，即使另一端关闭了其接收窗口。
3) 保活( k e e p a l i v e )定时器可检测到一个空闲连接的另一端何时崩溃或重启。 7200s
4) 2MSL定时器测量一个连接处于T I M E WA I T状态的时间。

### 连接建立和结束

符号的含义：

* 右箭头 (-->) ：从 A 发送到 B 的 TCP 报文段，且 B 接收到了；
* 左箭头 (<--) ：从 B 发送到 A 的 TCP 报文段，且 A 接收到了；
* 省略号 (…) ：TCP 报文段仍在网络中（delayed）；
* 丢失 ("XXX") ：TCP 报文段丢失或者被拒绝。
* 注释会放在括号中；
* TCP 状态代表了处于中间的报文段到达之后的状态（AFTER）；
* 报文段的内容只显示了序列号（SEQ）、控制符（CTL）和 ACK，其余内容被省略。

#### 三次握手

> `-S`  打印TCP 数据包的顺序号时, 使用绝对的顺序号, 而不是相对的顺序号.(nt: 相对顺序号可理解为, 相对第一个TCP 包顺序号的差距,比如, 接受方收到第一个数据包的绝对顺序号为232323, 对于后来接收到的第2个,第3个数据包, tcpdump会打印其序列号为1, 2分别表示与第一个数据包的差距为1 和 2. 而如果此时-S 选项被设置, 对于后来接收到的第2个, 第3个数据包会打印出其绝对顺序号:232324, 232325).

```c
12:08:02.022955 IP client.4970 > server.23: Flags [S], seq 1197597775, win 64240, options [mss 1460,nop,wscale 8,nop,nop,sackOK], length 0
/*
 Flags [S] // SYN=1
 seq 1197597775, // 随机序号client_isn 
 ack 任意
 win 64240, 
 options [mss 1460,
        nop, //no-operation
        wscale 8, // 2**8 =  256, wscale*win 为最大允许窗口，wscale最大14
        nop,
        nop,
        sackOK], 
length 0

**状态转换**
发送方client: CLOSED ->> SYN_SENT

当服务端接收到该报文后，
会为其分配TCP 缓存和变量（这使得TCP容易受到被称为SYN 洪泛攻击的拒绝服务攻击）紧接着，
服务端会返回一个SYNACK 报文到客户端
*/
12:08:02.023049 IP server.23 > client.4970: Flags [S.], seq 677374397, ack 1197597776, win 29200, options [mss 1460,nop,nop,sackOK,nop,wscale 7], length 0
/*
Flags [S.],  //SYN=1,ACK=1
seq 677374397, //随机序号server_isn
++ ack 1197597776, //随机序号client_isn+1 (即期望收到的下一个块的序号)
win 29200, 
options [mss 1460,nop,nop,sackOK,nop,wscale 7], 
length 0

**状态转换**
发送方SERVER: LISTEN ->> SYN_RCVD

*/

12:08:02.023285 IP client.4970 > server.23: Flags [.], ack 1, win 4106, length 0
/*
Flags [.],  //ACK=1
ack 1,  // 相对序号： server_isn - (绝对序号server_isn+1)
seq 1, // 这个信息被省略
win 4106, 
length 0

**状态转换**
发送方client: SYN_SENT ->> established
服务器接收到后 server:SYN_RCVD ->> established
*/
12:08:02.023489 IP server.23 > client.4970: Flags [P.], seq 1:16, ack 1, win 229, length 15
12:08:02.066589 IP client.4970 > server.23: Flags [.], ack 16, win 4106, length 0
12:08:04.637967 IP client.4970 > server.23: Flags [P.], seq 1:3, ack 16, win 4106, length 2

12:08:04.638049 IP server.23 > client.4970: Flags [.], ack 3, win 229, length 0
12:08:20.506133 IP client.4970 > server.23: Flags [F.], seq 3, ack 16, win 4106, length 0
12:08:20.506278 IP server.23 > client.4970: Flags [F.], seq 16, ack 4, win 229, length 0
12:08:20.506583 IP client.4970 > server.23: Flags [.], ack 17, win 4106, length 0


// with -S
12:37:53.438419 IP client.5293 > server.23: Flags [S], seq 3733352892, win 64240, options [mss 1460,nop,wscale 8,nop,nop,sackOK], length 0
12:37:53.438514 IP server.23 > client.5293: Flags [S.], seq 748757602, ack 3733352893, win 29200, options [mss 1460,nop,nop,sackOK,nop,wscale 7], length 0
12:37:53.438772 IP client.5293 > server.23: Flags [.], ack 748757603, win 4106, length 0

12:37:53.438913 IP server.23 > client.5293: Flags [P.], seq 748757603:748757618, ack 3733352893, win 229, length 15

12:37:53.485820 IP client.5293 > server.23: Flags [.], ack 748757618, win 4106, length 0
12:38:00.839436 IP client.5293 > server.23: Flags [F.], seq 3733352893, ack 748757618, win 4106, length 0
12:38:00.839638 IP server.23 > client.5293: Flags [F.], seq 748757618, ack 3733352894, win 229, length 0
12:38:00.840075 IP client.5293 > server.23: Flags [.], ack 748757619, win 4106, length 0
```

> 两个TCP建立请求相互之间同时发起时会发生什么？建立几个连接？
>>只会建立一个连接，进程用4个参数表示 (srcIP,dstIP,srcPort,dstPort)

----

> 客户端正在和服务端建立 TCP 连接，然而当服务器变 SYN-RCVD 后，此时一个旧的 SYN 报文 又到达了，服务器会如何处理？
>> 服务端在SYN_RECEIVED状态下，接收到旧的SYN 报文时是不能作出判断的，而是照常返回.
>> 当客户端接收到该报文后发现异常(也就是说收到ACK才能发现异常)，才会发送RST 报文，重置连接。

----

> 第三次握手失败了怎么办？
>> ACK报文丢失导致第三次握手失败

当客户端收到服务端的SYNACK应答后，其状态变为ESTABLISHED，并会发送ACK包给服务端，准备发送数据了。如果此时ACK在网络中丢失（如上图所示），过了超时计时器后，那么服务端会重新发送SYNACK包，重传次数根据/proc/sys/net/ipv4/tcp_synack_retries来指定，默认是5次。如果重传指定次数到了后，仍然未收到ACK应答，那么一段时间后，Server自动关闭这个连接。

问题就在这里，客户端已经认为连接建立，而服务端则可能处在SYN-RCVD或者CLOSED，接下来我们需要考虑这两种情况下服务端的应答：

服务端处于CLOSED，当接收到连接已经关闭的请求时，服务端会返回RST 报文，客户端接收到后就会关闭连接，如果需要的话则会重连，那么那就是另一个三次握手了。
服务端处于SYN-RCVD，此时如果接收到正常的ACK 报文，那么很好，连接恢复，继续传输数据；如果接收到写入数据等请求呢？注意了，此时写入数据等请求也是带着ACK 报文的，实际上也能恢复连接，使服务器恢复到ESTABLISHED状态，继续传输数据。

>>> 如果一个ACK 报文丢失了，但它的下一个数据包没有丢失，那么连接正常，否则，连接会被重置

----

> 如何防御SYN FLOOD
>> `SYN Cookie`防御系统，与前面接收到SYN 报文就分配缓存不同，此时暂不分配资源；同时利用SYN 报文的源和目的地IP和端口，以及服务器存储的一个秘密数，使用它们进行散列，得到server_isn，然后附着在SYNACK 报文中发送给客户端，接下来就是对ACK 报文进行判断，如果其返回的ack字段正好等于server_isn + 1，说明这是一个合法的ACK，那么服务器才会为其生成一个具有套接字的全开的连接。

----

> 其他问题

```c
6.（ISN）是固定的吗？
不固定，client_isn是随机生成的，而server_isn则需要根据SYN 报文中的源、ip和端口，加上服务器本身的密码数进行相同的散列得到，显然这也不是固定的。

7.三次握手过程中可以携带数据吗？
讲过程的时候其实已经讲了，第三次握手是可以携带数据的，而前两次不行（MSS等未协商）。


细节拓展
四次挥手重要的是TIME-WAIT状态，为什么需要这个状态呢？
要确保服务器是否已经收到了我们的ACK 报文，如果没有收到的话，服务器会重新发FIN 报文给客户端，那么客户端再次收到FIN 报文之后，就知道之前的 ACK 报文丢失了，就会再次发送ACK 报文。

问题深究
1.为什么握手只要三次，挥手却要四次？
关键就在中间两步。

建立连接时，当服务器收到客户端的SYN 报文后，可以直接发送SYNACK 报文。其中ACK是用来应答的，SYN是用来同步的。
但是关闭连接时，当服务器收到FIN 报文时，很可能并不会立即关闭SOCKET，所以只能先回复一个ACK 报文，告诉客户端，“你发的FIN 报文我收到了”。只有等到服务器所有的报文都发送/接收完了，我才能发送FIN 报文，因此不能一起发送，需要四次握手。

2.为什么 TIME_WAIT 状态需要经过 2MSL 才能转换到 CLOSE 状态？

第一，为了保证客户端发送的最后一个ACK 报文能够到达服务器。我们必须假设网络是不可靠的，ACK 报文可能丢失。如果服务端发出FIN 报文后没有收到ACK 报文，就会重发FIN 报文，此时处于TIME-WAIT状态的客户端就会重发ACK 报文。当然，客户端也不能无限久的等待这个可能存在的FIN 报文，因为如果服务端正常接收到了ACK 报文后是不会再发FIN 报文的。因此，客户端需要设置一个计时器，那么等待多久最合适呢？所谓的MSL（Maximum Segment Lifetime）指一个报文在网络中最大的存活时间，2MSL就是一个发送和一个回复所需的最大时间。如果直到2MSL时间后，客户端都没有再次收到FIN 报文，那么客户端推断ACK 报文已经被服务器成功接收，所以结束TCP 连接。

第二，防止已失效的连接请求报文段出现在新的连接中。客户端在发送完最后一个ACK 报文后，再经过时间2MSL，就可以使由于网络不通畅产生的滞留报文段失效。这样下一个新的连接中就不会出现旧的连接请求报文。

cat /proc/sys/net/ipv4/tcp_fin_timeout
60
```

