# Kubernetes Cluster Installation 


## Document History

```
Document History:
2020-03-20	V1 Arif "Install multi node kubernetes cluster"
```



## Introduction

This document provides the procedure to install multi node Kubernetes cluster in Ubuntu 18.04 LTS. VMs are based in Ubuntu 18.04 LTS, and created in virtualbox with host-only adapter network option. 



## Architecture

Three VMs are taken for the kube cluster setup and assigned fixed IP address from network 192.168.56.0/24 in VirtualBox.

```bash
kube-master		192.168.56.50/24
kube-node1		192.168.56.51/24
kube-node2		192.168.56.52/24
```



As VMs are required internet access to setup necessary package so added NAT rule in host system using ipables command.

```bash
iptables -t nat  -A POSTROUTING -s 192.168.56.0/24 -j MASQUERADE
```



## Procedure

/etc/hosts file setting in each node so that can reach by name. 

```bash
192.168.56.50    kube-master
192.168.56.51    kube-node1
192.168.56.52    kube-node2
```



#### Setup Master node

```bash
sudo hostnamectl set-hostname kube-master
sudo swapoff -a

--install docker
sudo apt-get install docker.io -y
sudo systemctl enable docker
sudo systemctl start docker
sudo docker --version

--install kube soft
sudo apt-get install apt-transport-https curl -y
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add
sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
#sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-bionic main"

sudo apt-get install kubeadm -y
#sudo apt-get install kubeadm kubelet kubectl
kubeadm version

--initiate kube cluster
sudo kubeadm init --pod-network-cidr=10.244.0.0/16
#sudo kubeadm init --pod-network-cidr=172.168.10.0/24
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl get nodes

sudo kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

```





#### Setup Slave node 1

```bash
sudo hostnamectl set-hostname kube-node1
sudo swapoff -a

--install docker
sudo apt-get install docker.io -y
sudo systemctl enable docker
sudo systemctl start docker
docker --version

--install kube soft
sudo apt-get install apt-transport-https curl -y
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add
sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"

sudo apt-get install kubeadm -y

--join kube cluster
kubeadm join 192.168.56.50:6443 --token 4jp7x6.gpbb4ctdk2x7ryjp \
    --discovery-token-ca-cert-hash sha256:562d69946d2836bbae38857517fc44e3ed372278c12753e6a6c6e7ba0f1e5b88 

```





#### Setup Slave node2

```bash
sudo hostnamectl set-hostname kube-node2
sudo swapoff -a

--install docker
sudo apt-get install docker.io -y
sudo systemctl enable docker
sudo systemctl start docker
docker --version

--install kube soft
sudo apt-get install apt-transport-https curl -y
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add
sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"

sudo apt-get install kubeadm -y

--join kube cluster
kubeadm join 192.168.56.50:6443 --token 4jp7x6.gpbb4ctdk2x7ryjp \
    --discovery-token-ca-cert-hash sha256:562d69946d2836bbae38857517fc44e3ed372278c12753e6a6c6e7ba0f1e5b88 
```



#### Cluster Check 

```bash
kubectl get svc

kubectl cluster-info
kubectl cluster-info dump
kubectl config view

kubectl describe node kube-node2
```



#### Chuster admin command

```bash
kubectl drain kube-node2
kubectl uncordon kube-node2
```



#### Check logs

```bash
kubectl logs -h

--check system componet logs
kubectl get pods --all-namespaces
kubectl logs --namespace kube-system kube-flannel-ds-amd64-54wxq

--check logs for pods
kubectl get pods
kubectl logs nginx-6db489d4b7-5m7dx
kubectl logs nginx-6db489d4b7-5m7dx --all-containers=true

kubectl describe pod nginx-6db489d4b7-5m7dx
```



#### Create a pod

```bash
kubectl run nginx --image=nginx
```





## References:

1. https://www.linuxtechi.com/install-configure-kubernetes-ubuntu-18-04-ubuntu-18-10/
2. https://phoenixnap.com/kb/install-kubernetes-on-ubuntu
3. https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
4. https://kubernetes.io/docs/reference/kubectl/cheatsheet/
5. https://kubernetes.io/docs/reference/kubectl/conventions/





## Appendix:



**Master node setup log** 

```bash
root@kube-master:~# kubeadm version
kubeadm version: &version.Info{Major:"1", Minor:"17", GitVersion:"v1.17.4", GitCommit:"8d8aa39598534325ad77120c120a22b3a990b5ea", GitTreeState:"clean", BuildDate:"2020-03-12T21:01:11Z", GoVersion:"go1.13.8", Compiler:"gc", Platform:"linux/amd64"}
root@kube-master:~# sudo kubeadm init --pod-network-cidr=10.244.1.0/24
W0321 01:22:55.325390    7135 validation.go:28] Cannot validate kube-proxy config - no validator is available
W0321 01:22:55.325526    7135 validation.go:28] Cannot validate kubelet config - no validator is available
[init] Using Kubernetes version: v1.17.4
[preflight] Running pre-flight checks
	[WARNING IsDockerSystemdCheck]: detected "cgroupfs" as the Docker cgroup driver. The recommended driver is "systemd". Please follow the guide at https://kubernetes.io/docs/setup/cri/
[preflight] Pulling images required for setting up a Kubernetes cluster
[preflight] This might take a minute or two, depending on the speed of your internet connection
[preflight] You can also perform this action in beforehand using 'kubeadm config images pull'
[kubelet-start] Writing kubelet environment file with flags to file "/var/lib/kubelet/kubeadm-flags.env"
[kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
[kubelet-start] Starting the kubelet
[certs] Using certificateDir folder "/etc/kubernetes/pki"
[certs] Generating "ca" certificate and key
[certs] Generating "apiserver" certificate and key
[certs] apiserver serving cert is signed for DNS names [kube-master kubernetes kubernetes.default kubernetes.default.svc kubernetes.default.svc.cluster.local] and IPs [10.96.0.1 192.168.56.50]
[certs] Generating "apiserver-kubelet-client" certificate and key
[certs] Generating "front-proxy-ca" certificate and key
[certs] Generating "front-proxy-client" certificate and key
[certs] Generating "etcd/ca" certificate and key
[certs] Generating "etcd/server" certificate and key
[certs] etcd/server serving cert is signed for DNS names [kube-master localhost] and IPs [192.168.56.50 127.0.0.1 ::1]
[certs] Generating "etcd/peer" certificate and key
[certs] etcd/peer serving cert is signed for DNS names [kube-master localhost] and IPs [192.168.56.50 127.0.0.1 ::1]
[certs] Generating "etcd/healthcheck-client" certificate and key
[certs] Generating "apiserver-etcd-client" certificate and key
[certs] Generating "sa" key and public key
[kubeconfig] Using kubeconfig folder "/etc/kubernetes"
[kubeconfig] Writing "admin.conf" kubeconfig file
[kubeconfig] Writing "kubelet.conf" kubeconfig file
[kubeconfig] Writing "controller-manager.conf" kubeconfig file
[kubeconfig] Writing "scheduler.conf" kubeconfig file
[control-plane] Using manifest folder "/etc/kubernetes/manifests"
[control-plane] Creating static Pod manifest for "kube-apiserver"
[control-plane] Creating static Pod manifest for "kube-controller-manager"
W0321 01:23:47.264627    7135 manifests.go:214] the default kube-apiserver authorization-mode is "Node,RBAC"; using "Node,RBAC"
[control-plane] Creating static Pod manifest for "kube-scheduler"
W0321 01:23:47.265583    7135 manifests.go:214] the default kube-apiserver authorization-mode is "Node,RBAC"; using "Node,RBAC"
[etcd] Creating static Pod manifest for local etcd in "/etc/kubernetes/manifests"
[wait-control-plane] Waiting for the kubelet to boot up the control plane as static Pods from directory "/etc/kubernetes/manifests". This can take up to 4m0s
[apiclient] All control plane components are healthy after 24.930232 seconds
[upload-config] Storing the configuration used in ConfigMap "kubeadm-config" in the "kube-system" Namespace
[kubelet] Creating a ConfigMap "kubelet-config-1.17" in namespace kube-system with the configuration for the kubelets in the cluster
[upload-certs] Skipping phase. Please see --upload-certs
[mark-control-plane] Marking the node kube-master as control-plane by adding the label "node-role.kubernetes.io/master=''"
[mark-control-plane] Marking the node kube-master as control-plane by adding the taints [node-role.kubernetes.io/master:NoSchedule]
[bootstrap-token] Using token: 4jp7x6.gpbb4ctdk2x7ryjp
[bootstrap-token] Configuring bootstrap tokens, cluster-info ConfigMap, RBAC Roles
[bootstrap-token] configured RBAC rules to allow Node Bootstrap tokens to post CSRs in order for nodes to get long term certificate credentials
[bootstrap-token] configured RBAC rules to allow the csrapprover controller automatically approve CSRs from a Node Bootstrap Token
[bootstrap-token] configured RBAC rules to allow certificate rotation for all node client certificates in the cluster
[bootstrap-token] Creating the "cluster-info" ConfigMap in the "kube-public" namespace
[kubelet-finalize] Updating "/etc/kubernetes/kubelet.conf" to point to a rotatable kubelet client certificate and key
[addons] Applied essential addon: CoreDNS
[addons] Applied essential addon: kube-proxy

Your Kubernetes control-plane has initialized successfully!

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join 192.168.56.50:6443 --token 4jp7x6.gpbb4ctdk2x7ryjp \
    --discovery-token-ca-cert-hash sha256:562d69946d2836bbae38857517fc44e3ed372278c12753e6a6c6e7ba0f1e5b88 
root@kube-master:~# 


arif@kube-master:~$ sudo kubectl get nodes
NAME          STATUS     ROLES    AGE     VERSION
kube-master   NotReady   master   2m57s   v1.17.4
arif@kube-master:~$ 



arif@kube-master:~$ kubectl get pods --all-namespaces
NAMESPACE     NAME                                  READY   STATUS    RESTARTS   AGE
kube-system   coredns-6955765f44-dmjg6              0/1     Pending   0          5m21s
kube-system   coredns-6955765f44-gjjbs              0/1     Pending   0          5m21s
kube-system   etcd-kube-master                      1/1     Running   0          5m32s
kube-system   kube-apiserver-kube-master            1/1     Running   0          5m32s
kube-system   kube-controller-manager-kube-master   1/1     Running   0          5m32s
kube-system   kube-proxy-xl5tn                      1/1     Running   0          5m21s
kube-system   kube-scheduler-kube-master            1/1     Running   0          5m32s
arif@kube-master:~$ 


arif@kube-master:~$ sudo kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
podsecuritypolicy.policy/psp.flannel.unprivileged created
clusterrole.rbac.authorization.k8s.io/flannel created
clusterrolebinding.rbac.authorization.k8s.io/flannel created
serviceaccount/flannel created
configmap/kube-flannel-cfg created
daemonset.apps/kube-flannel-ds-amd64 created
daemonset.apps/kube-flannel-ds-arm64 created
daemonset.apps/kube-flannel-ds-arm created
daemonset.apps/kube-flannel-ds-ppc64le created
daemonset.apps/kube-flannel-ds-s390x created
arif@kube-master:~$ sudo kubectl get nodes
NAME          STATUS     ROLES    AGE     VERSION
kube-master   NotReady   master   7m13s   v1.17.4
arif@kube-master:~$ 

arif@kube-master:~$ sudo kubectl get nodes
NAME          STATUS   ROLES    AGE   VERSION
kube-master   Ready    master   8m    v1.17.4
arif@kube-master:~$ kubectl get pods --all-namespaces
NAMESPACE     NAME                                  READY   STATUS    RESTARTS   AGE
kube-system   coredns-6955765f44-dmjg6              1/1     Running   0          7m45s
kube-system   coredns-6955765f44-gjjbs              1/1     Running   0          7m45s
kube-system   etcd-kube-master                      1/1     Running   0          7m56s
kube-system   kube-apiserver-kube-master            1/1     Running   0          7m56s
kube-system   kube-controller-manager-kube-master   1/1     Running   0          7m56s
kube-system   kube-flannel-ds-amd64-l72z2           1/1     Running   0          66s
kube-system   kube-proxy-xl5tn                      1/1     Running   0          7m45s
kube-system   kube-scheduler-kube-master            1/1     Running   0          7m56s


after adding node1
arif@kube-master:~$ sudo kubectl get nodes
NAME          STATUS   ROLES    AGE   VERSION
kube-master   Ready    master   13m   v1.17.4
kube-node1    Ready    <none>   54s   v1.17.4
arif@kube-master:~$ 

--after adding 2nd node
arif@kube-master:~$ sudo kubectl get nodes
NAME          STATUS   ROLES    AGE     VERSION
kube-master   Ready    master   17m     v1.17.4
kube-node1    Ready    <none>   5m15s   v1.17.4
kube-node2    Ready    <none>   13s     v1.17.4
arif@kube-master:~$ 

arif@kube-master:~$ kubectl get pods --all-namespaces
NAMESPACE     NAME                                  READY   STATUS             RESTARTS   AGE
kube-system   coredns-6955765f44-dmjg6              1/1     Running            0          26m
kube-system   coredns-6955765f44-gjjbs              1/1     Running            0          26m
kube-system   etcd-kube-master                      1/1     Running            0          26m
kube-system   kube-apiserver-kube-master            1/1     Running            0          26m
kube-system   kube-controller-manager-kube-master   1/1     Running            0          26m
kube-system   kube-flannel-ds-amd64-l72z2           1/1     Running            0          20m
kube-system   kube-flannel-ds-amd64-m8s4z           0/1     CrashLoopBackOff   7          14m
kube-system   kube-flannel-ds-amd64-r9d5k           0/1     CrashLoopBackOff   6          9m22s
kube-system   kube-proxy-8jbdt                      1/1     Running            0          14m
kube-system   kube-proxy-c2wmz                      1/1     Running            0          9m22s
kube-system   kube-proxy-xl5tn                      1/1     Running            0          26m
kube-system   kube-scheduler-kube-master            1/1     Running            0          26m
arif@kube-master:~$ 


arif@kube-master:~$ kubectl get pods --all-namespaces
NAMESPACE     NAME                                  READY   STATUS    RESTARTS   AGE
kube-system   coredns-6955765f44-2rzll              1/1     Running   0          12m
kube-system   coredns-6955765f44-xjlh8              1/1     Running   0          12m
kube-system   etcd-kube-master                      1/1     Running   0          12m
kube-system   kube-apiserver-kube-master            1/1     Running   0          12m
kube-system   kube-controller-manager-kube-master   1/1     Running   0          12m
kube-system   kube-flannel-ds-amd64-54wxq           1/1     Running   0          4m1s
kube-system   kube-flannel-ds-amd64-bpk6j           1/1     Running   0          94s
kube-system   kube-flannel-ds-amd64-pgfbz           1/1     Running   0          10m
kube-system   kube-proxy-g58z8                      1/1     Running   0          94s
kube-system   kube-proxy-jbmsv                      1/1     Running   0          12m
kube-system   kube-proxy-kp92h                      1/1     Running   0          4m1s
kube-system   kube-scheduler-kube-master            1/1     Running   0          12m
arif@kube-master:~$ 

arif@kube-master:~$ kubectl get nodes -o wide
NAME          STATUS   ROLES    AGE     VERSION   INTERNAL-IP     EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION      CONTAINER-RUNTIME
kube-master   Ready    master   15m     v1.17.4   192.168.56.50   <none>        Ubuntu 18.04.4 LTS   4.15.0-91-generic   docker://19.3.6
kube-node1    Ready    <none>   6m25s   v1.17.4   192.168.56.51   <none>        Ubuntu 18.04.4 LTS   4.15.0-91-generic   docker://19.3.6
kube-node2    Ready    <none>   3m58s   v1.17.4   192.168.56.52   <none>        Ubuntu 18.04.4 LTS   4.15.0-91-generic   docker://19.3.6
arif@kube-master:~$ 

arif@kube-master:~$ kubectl get pods --all-namespaces -o wide
NAMESPACE     NAME                                  READY   STATUS    RESTARTS   AGE     IP              NODE          NOMINATED NODE   READINESS GATES
default       nginx-6db489d4b7-5m7dx                1/1     Running   0          82s     10.244.1.2      kube-node1    <none>           <none>
kube-system   coredns-6955765f44-2rzll              1/1     Running   0          15m     10.244.0.2      kube-master   <none>           <none>
kube-system   coredns-6955765f44-xjlh8              1/1     Running   0          15m     10.244.0.3      kube-master   <none>           <none>
kube-system   etcd-kube-master                      1/1     Running   0          16m     192.168.56.50   kube-master   <none>           <none>
kube-system   kube-apiserver-kube-master            1/1     Running   0          16m     192.168.56.50   kube-master   <none>           <none>
kube-system   kube-controller-manager-kube-master   1/1     Running   0          16m     192.168.56.50   kube-master   <none>           <none>
kube-system   kube-flannel-ds-amd64-54wxq           1/1     Running   0          7m25s   192.168.56.51   kube-node1    <none>           <none>
kube-system   kube-flannel-ds-amd64-bpk6j           1/1     Running   0          4m58s   192.168.56.52   kube-node2    <none>           <none>
kube-system   kube-flannel-ds-amd64-pgfbz           1/1     Running   0          13m     192.168.56.50   kube-master   <none>           <none>
kube-system   kube-proxy-g58z8                      1/1     Running   0          4m58s   192.168.56.52   kube-node2    <none>           <none>
kube-system   kube-proxy-jbmsv                      1/1     Running   0          15m     192.168.56.50   kube-master   <none>           <none>
kube-system   kube-proxy-kp92h                      1/1     Running   0          7m25s   192.168.56.51   kube-node1    <none>           <none>
kube-system   kube-scheduler-kube-master            1/1     Running   0          16m     192.168.56.50   kube-master   <none>           <none>
arif@kube-master:~$ 
```





**Slave node1**

```bash
root@kube-node1:~# kubeadm join 192.168.56.50:6443 --token 4jp7x6.gpbb4ctdk2x7ryjp \
>     --discovery-token-ca-cert-hash sha256:562d69946d2836bbae38857517fc44e3ed372278c12753e6a6c6e7ba0f1e5b88 
W0321 01:36:50.446011    4786 join.go:346] [preflight] WARNING: JoinControlPane.controlPlane settings will be ignored when control-plane flag is not set.
[preflight] Running pre-flight checks
	[WARNING IsDockerSystemdCheck]: detected "cgroupfs" as the Docker cgroup driver. The recommended driver is "systemd". Please follow the guide at https://kubernetes.io/docs/setup/cri/
[preflight] Reading configuration from the cluster...
[preflight] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -oyaml'
[kubelet-start] Downloading configuration for the kubelet from the "kubelet-config-1.17" ConfigMap in the kube-system namespace
[kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
[kubelet-start] Writing kubelet environment file with flags to file "/var/lib/kubelet/kubeadm-flags.env"
[kubelet-start] Starting the kubelet
[kubelet-start] Waiting for the kubelet to perform the TLS Bootstrap...

This node has joined the cluster:
* Certificate signing request was sent to apiserver and a response was received.
* The Kubelet was informed of the new secure connection details.

Run 'kubectl get nodes' on the control-plane to see this node join the cluster.

root@kube-node1:~# 

```



slave node2

```bash
root@kube-node2:~# kubeadm join 192.168.56.50:6443 --token 4jp7x6.gpbb4ctdk2x7ryjp --discovery-token-ca-cert-hash sha256:562d69946d2836bbae38857517fc44e3ed372278c12753e6a6c6e7ba0f1e5b88
W0321 01:41:51.398994    5512 join.go:346] [preflight] WARNING: JoinControlPane.controlPlane settings will be ignored when control-plane flag is not set.
[preflight] Running pre-flight checks
	[WARNING IsDockerSystemdCheck]: detected "cgroupfs" as the Docker cgroup driver. The recommended driver is "systemd". Please follow the guide at https://kubernetes.io/docs/setup/cri/
[preflight] Reading configuration from the cluster...
[preflight] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -oyaml'
[kubelet-start] Downloading configuration for the kubelet from the "kubelet-config-1.17" ConfigMap in the kube-system namespace
[kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
[kubelet-start] Writing kubelet environment file with flags to file "/var/lib/kubelet/kubeadm-flags.env"
[kubelet-start] Starting the kubelet
[kubelet-start] Waiting for the kubelet to perform the TLS Bootstrap...

This node has joined the cluster:
* Certificate signing request was sent to apiserver and a response was received.
* The Kubelet was informed of the new secure connection details.

Run 'kubectl get nodes' on the control-plane to see this node join the cluster.

root@kube-node2:~# 

```

