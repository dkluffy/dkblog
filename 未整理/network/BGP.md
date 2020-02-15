# BGP

#### version 0.1 2019/09/04  

## WHY BGP

#### BGP要解决的问题

* 当IGP不能提供必须的工具来执行路由策略，或者当归奶无法控制路由表规模

* 当区域里使用IGP时，BGP是十分有用的，比起试图在所有IGP内重分发，BGP更简单有效

* 一个用户的路由区域必须由一个自治系统号来标识


#### BGP不是必须的

* 加入额外的路由协议使网络变得复杂，即使是网络被分解成多个路由域，也不一定要BGP

* 即使是自治系统之间互联


### BGP  Highlights

自治系统号

    私用保留 64512 ~ 65535

入业务 和 出业务 必须分开考虑


TCP 179 ， 点对点连接

“路径”向量协议
    BGP是距离向量协议，因此每个节点依靠下游邻居来将他的路由表传送下去
    节点在公布路由的基础上进行路由计算并将结果传给上行邻居

    BGP使用AS号列表，数据包必须通过这些AS才能到达目的地。 这不同于的距离向量协议



```
route-views.wide.routeviews.org> show ip bgp
BGP table version is 0, local router ID is 202.249.2.166
Status codes: s suppressed, d damped, h history, * valid, > best, = multipath,
              i internal, r RIB-failure, S Stale, R Removed
Origin codes: i - IGP, e - EGP, ? - incomplete

   Network          Next Hop                          Metric LocPrf Weight Path
*> 1.0.0.0/24       202.249.2.169                          0 2497 13335 i
*                   202.249.2.86                           0 7500 2516 13335 i
*> 1.0.4.0/22       202.249.2.169                          0 2497 4826 38803 56203 i
*                   202.249.2.169                          0 7500 2497 4826 38803 56203 i

r1#sh ip route
Codes: L - local, C - connected, S - static, R - RIP, M - mobile, B - BGP
       D - EIGRP, EX - EIGRP external, O - OSPF, IA - OSPF inter area 
       N1 - OSPF NSSA external type 1, N2 - OSPF NSSA external type 2
       E1 - OSPF external type 1, E2 - OSPF external type 2
       i - IS-IS, su - IS-IS summary, L1 - IS-IS level-1, L2 - IS-IS level-2
       ia - IS-IS inter area, * - candidate default, U - per-user static route
       o - ODR, P - periodic downloaded static route, + - replicated route

Gateway of last resort is not set

      1.0.0.0/32 is subnetted, 1 subnets
C        1.1.1.1 is directly connected, Loopback0
      12.0.0.0/8 is variably subnetted, 2 subnets, 2 masks
C        12.0.0.0/24 is directly connected, Ethernet0/0
L        12.0.0.1/32 is directly connected, Ethernet0/0
      13.0.0.0/8 is variably subnetted, 2 subnets, 2 masks
C        13.0.0.0/24 is directly connected, Ethernet0/1
L        13.0.0.1/32 is directly connected, Ethernet0/1
```


BGP 消息类型

```
Open
Keepalive
Update
Notification
```

BGP cap

```

Border Gateway Protocol - UPDATE Message
    Marker: ffffffffffffffffffffffffffffffff
    Length: 64
    Type: UPDATE Message (2)
    Withdrawn Routes Length: 0
    Total Path Attribute Length: 39
    Path attributes
        Path Attribute - ORIGIN: EGP
        Path Attribute - AS_PATH: empty
        Path Attribute - NEXT_HOP: 192.168.0.33 
        Path Attribute - MULTI_EXIT_DISC: 0
        Path Attribute - LOCAL_PREF: 100
        Path Attribute - COMMUNITIES: 65033:500 65033:600 
    Network Layer Reachability Information (NLRI)
        10.0.0.0/8
            NLRI prefix length: 8
            NLRI prefix: 10.0.0.0

Border Gateway Protocol - UPDATE Message
    Marker: ffffffffffffffffffffffffffffffff
    Length: 98
    Type: UPDATE Message (2)
    Withdrawn Routes Length: 0
    Total Path Attribute Length: 72
    Path attributes
        Path Attribute - ORIGIN: INCOMPLETE
        Path Attribute - AS_PATH: {500, 500} 65211 
        Path Attribute - NEXT_HOP: 192.168.0.15 
        Path Attribute - LOCAL_PREF: 100
        Path Attribute - ATOMIC_AGGREGATE
        Path Attribute - AGGREGATOR: AS: 65210 origin: 192.168.0.10
        Path Attribute - COMMUNITIES: 65215:1 790:4 340:250 
        Path Attribute - ORIGINATOR_ID: 192.168.0.15 
        Path Attribute - CLUSTER_LIST: 192.168.0.250
    Network Layer Reachability Information (NLRI)
        172.16.0.0/16
            NLRI prefix length: 16
            NLRI prefix: 172.16.0.0

```

### BGP 决策过程

#### 路由信息数据库 RIB

* Adj-RIBs-In 未经处理的路由消息
* Loc-RIB 使用本地策略选择的路由
* Adj-RIBs-Out 向对等公布的路由

#### RIB更新过程

* 为每一条可用路由计算首选等级
* 从到特定目的地址的所有可用路由中选取最好的路由，并放入Loc-RIB。
* 将合适的路由放入Adj-RIBs-Out


#### 最好路由的选择准则

* 最高管理权值（有cisco提出，Cisco特有）
* 最高 LOCAL_PREF
* 最短AS_PATH
* 最低ORIGIN CODE (IGP<EGP<Incomplete)
* 最低MUTIL_EXIT_DISC （MED）：限相同AS
* EBGP>联盟EBGP,联盟EBGP>IBGP
* 最低IGP度量路由
* 如果路由相同，它们来自相同的相邻AS并且通过 MAXIMUM-PATHS 命令使BGP多条路径可用，
那么将所有开销相同的路由写入Loc-RIB
* 如果多条路径不可用，首选最低BGP路由器ID的路由





Cisco 路由器规定的路由协议缺省管理距离:

* eBGP​​​​​​​​​​|​​ 2
* iBGP| 200














