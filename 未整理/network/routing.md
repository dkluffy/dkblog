# 路由主题

## 路由实列

```c
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

！-----------------

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

