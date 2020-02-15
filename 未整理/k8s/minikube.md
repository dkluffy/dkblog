### Scripts:

```
minikube start --registry-mirror=https://registry.docker-cn.com
kubectl proxy --address='172.168.1.169' --accept-hosts='^172\.168\.*'
source <(kubectl completion bash)

```

# Part1 - Hands on Notes
### 1.Install:

```
In China, use https://github.com/AliyunContainerService/minikube
```

### 2.Start:
```
#minikube start --registry-mirror=https://registry.docker-cn.com

* minikube v1.2.0 on linux (amd64)
! Please don't run minikube as root or with 'sudo' privileges. It isn't necessary.
* using image repository registry.cn-hangzhou.aliyuncs.com/google_containers
* Creating kvm2 VM (CPUs=2, Memory=2048MB, Disk=20000MB) ...
* Configuring environment for Kubernetes v1.15.0 on Docker 18.09.6
* Downloading kubeadm v1.15.0
* Downloading kubelet v1.15.0
* Pulling images ...
* Launching Kubernetes ... 
* Verifying: apiserver proxy etcd scheduler controller dns
* Done! kubectl is now configured to use "minikube"
```
### 3.Check
```
k8s# minikube status
host: Running
kubelet: Running
apiserver: Running
kubectl: Correctly Configured: pointing to minikube-vm at 192.168.39.228
```


### 4.DashBoard:
```
 #kubectl proxy --address='172.168.1.169' --accept-hosts='^172\.168\.*'
 
 #minikube dashboard --url
* Verifying dashboard health ...
* Launching proxy ...
* Verifying proxy health ...
http://127.0.0.1:37449/api/v1/namespaces/kube-system/services/http:kubernetes-dashboard:/proxy/


http://172.168.1.169:8001/api/v1/namespaces/kube-system/services/http:kubernetes-dashboard:/proxy/#!/overview?namespace=default

```


# Part2 - CKAD  

https://kubernetes.feisky.xyz/

https://github.com/kelseyhightower/kubernetes-the-hard-way

https://github.com/dgkanatsios/CKAD-exercises

https://courses.edx.org/courses/course-v1:LinuxFoundationX+LFS158x+2T2019/course/


https://jimmysong.io/kubernetes-handbook/concepts/cilium.html

## Note for Basic

Kubernetes 主要由以下几个核心组件组成：

```
etcd 保存了整个集群的状态；
apiserver 提供了资源操作的唯一入口，并提供认证、授权、访问控制、API 注册和发现等机制；
controller manager 负责维护集群的状态，比如故障检测、自动扩展、滚动更新等；
scheduler 负责资源的调度，按照预定的调度策略将 Pod 调度到相应的机器上；
kubelet 负责维护容器的生命周期，同时也负责 Volume（CVI）和网络（CNI）的管理；
Container runtime 负责镜像管理以及 Pod 和容器的真正运行（CRI）；
kube-proxy 负责为 Service 提供 cluster 内部的服务发现和负载均衡
```

每个API对象都有3大类属性：元数据metadata、规范spec和状态status。元数据是用来标识API对象的，每个对象都至少有3个元数据：namespace，name和uid；除此以外还有各种各样的标签labels用来标识和匹配不同的对象.

