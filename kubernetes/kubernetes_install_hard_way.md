# kubernetes Cluster Installation Hard way

Table of Contents
=================

   * [kubernetes Cluster Installation Hard way](#kubernetes-cluster-installation-hard-way)
      * [Document History](#document-history)
      * [Introduction](#introduction)
         * [Kubernetes Software Cluster Details](#kubernetes-software-cluster-details)
      * [Provision Compute Node Using Vagrant](#provision-compute-node-using-vagrant)
         * [Install / Upgrade Vagrant Software](#install--upgrade-vagrant-software)
         * [Provision Compute Node](#provision-compute-node)
      * [Installing the Client Tools](#installing-the-client-tools)
      * [Certificate Authority and TLS Certificates](#certificate-authority-and-tls-certificates)
         * [Certificate Authority](#certificate-authority)
         * [Admin client Certificate](#admin-client-certificate)
         * [The Controller Manager Client Certificate](#the-controller-manager-client-certificate)
         * [The Kube Proxy Client Certificate](#the-kube-proxy-client-certificate)
         * [The Scheduler Client Certificate](#the-scheduler-client-certificate)
         * [The Kubernetes API Server Certificate](#the-kubernetes-api-server-certificate)
         * [The ETCD Server Certificate](#the-etcd-server-certificate)
         * [The Service Account Key Pair](#the-service-account-key-pair)
         * [Distribute the Certificates](#distribute-the-certificates)
      * [Generating Kubernetes Configuration Files for Authentication](#generating-kubernetes-configuration-files-for-authentication)
         * [Kubernetes Public IP Address](#kubernetes-public-ip-address)
         * [The kube-proxy Kubernetes Configuration File](#the-kube-proxy-kubernetes-configuration-file)
         * [The kube-controller-manager Kubernetes Configuration File](#the-kube-controller-manager-kubernetes-configuration-file)
         * [The kube-scheduler Kubernetes Configuration File](#the-kube-scheduler-kubernetes-configuration-file)
         * [The admin Kubernetes Configuration File](#the-admin-kubernetes-configuration-file)
         * [Distribute the Kubernetes Configuration Files](#distribute-the-kubernetes-configuration-files)
      * [Generating the Data Encryption Config and Key](#generating-the-data-encryption-config-and-key)
         * [The Encryption Key](#the-encryption-key)
         * [The Encryption Config File](#the-encryption-config-file)
      * [Bootstrapping the etcd Cluster](#bootstrapping-the-etcd-cluster)
         * [Download and Install etcd](#download-and-install-etcd)
         * [Configure the etcd Server](#configure-the-etcd-server)
         * [Start the etcd Server](#start-the-etcd-server)
         * [etcd server verification](#etcd-server-verification)
      * [Bootstrapping the Kubernetes Control Plane](#bootstrapping-the-kubernetes-control-plane)
         * [Provision the Kubernetes Control Plane](#provision-the-kubernetes-control-plane)
         * [Download and Install the Kubernetes Controller Binaries](#download-and-install-the-kubernetes-controller-binaries)
         * [Configure the Kubernetes API Server](#configure-the-kubernetes-api-server)
         * [Configure the Kubernetes Controller Manager](#configure-the-kubernetes-controller-manager)
         * [Configure the Kubernetes Scheduler](#configure-the-kubernetes-scheduler)
         * [Start the Controller Services](#start-the-controller-services)
         * [Controller Services starting issue](#controller-services-starting-issue)
         * [Verfication for Controller Services](#verfication-for-controller-services)
      * [The Kubernetes Frontend Load Balancer](#the-kubernetes-frontend-load-balancer)
         * [Provision a Network Load Balancer](#provision-a-network-load-balancer)
      * [Bootstrapping the Kubernetes Worker Nodes](#bootstrapping-the-kubernetes-worker-nodes)
         * [Generate Certificate for worker-1](#generate-certificate-for-worker-1)
         * [The kubelet Kubernetes Configuration File](#the-kubelet-kubernetes-configuration-file)
         * [Copy certificates, private keys and kubeconfig files to the worker node:](#copy-certificates-private-keys-and-kubeconfig-files-to-the-worker-node)
         * [Download and Install Worker Binaries](#download-and-install-worker-binaries)
         * [Configure the Kubelet](#configure-the-kubelet)
         * [Configure the Kubernetes Proxy](#configure-the-kubernetes-proxy)
         * [Start the Worker Services](#start-the-worker-services)
         * [Verification](#verification)
      * [TLS Bootstrapping Worker Nodes](#tls-bootstrapping-worker-nodes)
         * [Pre-Requisite](#pre-requisite)
         * [Configure the Binaries on the Worker node](#configure-the-binaries-on-the-worker-node)
         * [Move the ca certificate](#move-the-ca-certificate)
         * [Step 1 Create the Boostrap Token to be used by Nodes(Kubelets) to invoke Certificate API](#step-1-create-the-boostrap-token-to-be-used-by-nodeskubelets-to-invoke-certificate-api)
         * [Step 2 Authorize workers(kubelets) to create CSR](#step-2-authorize-workerskubelets-to-create-csr)
         * [Step 3 Authorize workers(kubelets) to approve CSR](#step-3-authorize-workerskubelets-to-approve-csr)
         * [Step 3 Authorize workers(kubelets) to Auto Renew Certificates on expiration](#step-3-authorize-workerskubelets-to-auto-renew-certificates-on-expiration)
         * [Step 4 Configure Kubelet to TLS Bootstrap](#step-4-configure-kubelet-to-tls-bootstrap)
         * [Step 5 Create Kubelet Config File](#step-5-create-kubelet-config-file)
         * [Step 6 Configure Kubelet Service](#step-6-configure-kubelet-service)
         * [Step 7 Configure the Kubernetes Proxy](#step-7-configure-the-kubernetes-proxy)
         * [Step 8 Start the Worker Services](#step-8-start-the-worker-services)
         * [Step 9 Approve Server CSR](#step-9-approve-server-csr)
         * [Verification](#verification-1)
         * [Logs](#logs)
      * [Configuring kubectl for Remote Access](#configuring-kubectl-for-remote-access)
      * [Provisioning Pod Network](#provisioning-pod-network)
         * [Install CNI plugins](#install-cni-plugins)
         * [Deploy weave network](#deploy-weave-network)
      * [RBAC for Kubelet Authorization](#rbac-for-kubelet-authorization)
         * [List current role:](#list-current-role)
         * [Execution logs:](#execution-logs)
      * [Deploying the DNS Cluster Add-on](#deploying-the-dns-cluster-add-on)
         * [The DNS Cluster Add-on](#the-dns-cluster-add-on)
         * [Logs](#logs-1)
         * [Logs After deployment](#logs-after-deployment)
         * [Error Logs while starting coredns](#error-logs-while-starting-coredns)
         * [Solution of core-dns start issue](#solution-of-core-dns-start-issue)
         * [Verification by creating a new pods](#verification-by-creating-a-new-pods)
      * [Smoke Test](#smoke-test)
         * [Data Encryption](#data-encryption)
         * [Deployments](#deployments)
         * [Services](#services)
         * [Logs](#logs-2)
         * [Exec](#exec)
      * [Run End-to-End Tests](#run-end-to-end-tests)
      * [Software Upgrade](#software-upgrade)
            * [Upgrade verification for worker node](#upgrade-verification-for-worker-node)
         * [Upgrade Kuberneties Control Plane](#upgrade-kuberneties-control-plane)
            * [Control plane upgrade verification](#control-plane-upgrade-verification)
         * [Upgrade ETCD DB](#upgrade-etcd-db)
            * [ETCD upgrade verification](#etcd-upgrade-verification)
         * [Upgrade CNI](#upgrade-cni)
         * [Upgrade Wave network](#upgrade-wave-network)
         * [Upgrade Coredns](#upgrade-coredns)
      * [References](#references)
      * [Verfication](#verfication)
      * [Appendix](#appendix)



## Document History

```reStructuredText
Document History:
2020-04-05 V1 Arif "Install multi node kubernetes cluster hard way"
2020-04-09 V2 Arif "Installation completed"

```



## Introduction

This install procedure followed [kubernetes-the-hard-way](https://github.com/mmumshad/kubernetes-the-hard-way) and few stpes are modified to install latest software release which is documentd in [kubernetes-the-hard-way](https://github.com/arif332/kubernetes-the-hard-way). 



Vagrant is used to create compute node in virtualbox.



### Kubernetes Software Cluster Details

```bash
Kubernetes 1.17.4 (later upgraded to latest: 1.18.1)
Docker Container Runtime 19.3.8
CNI Container Networking 0.8.5
Weave Networking v0.8.5
etcd v3.4.7
CoreDNS v1.6.9
```





## Provision Compute Node Using Vagrant



### Install / Upgrade Vagrant Software 

```bash
$ vagrant -v
Vagrant 2.2.4

#for upgrade download latest software
wget https://releases.hashicorp.com/vagrant/2.2.7/vagrant_2.2.7_x86_64.deb

double clik on the binary package to install it

$ vagrant -v
Vagrant 2.2.7
```



Setup vagrant environment variable for root & other user to get control config location from any where.

```bash
#Final Vagrant Config dir in my linux desktop: 
/ext/wdc512/LinuxContent/vagrantVMsRepo/vagrant.d

#set VAGRANT_HOME dir to find host specific config file
vi /home/arif/.bashrc
export VAGRANT_HOME=/ext/wdc512/LinuxContent/vagrantVMsRepo/vagrant.d
chown arif:arif -R /ext/wdc512/LinuxContent/vagrantVMsRepo/vagrant.d


#set vagrant path to find prefered config file
vi /home/arif/.bashrc
vagMyRepo=/ext/wdc512/LinuxContent/vagrantVMsRepo
export VAGRANT_CWD=$vagMyRepo/kube_hard_way/vagrant

#open virtual box as root user and setup prefered image location

```



### Provision Compute Node

```bash
mkdir -p /ext/wdc512/LinuxContent/vagrantVMsRepo/kube_hard_way
cd /ext/wdc512/LinuxContent/vagrantVMsRepo/kube_hard_way
cp -rfp ~/gitRepos/kubernetes-the-hard-way-mmumshad/vagrant /ext/wdc512/LinuxContent/vagrantVMsRepo/kube_hard_way

/ext/wdc512/LinuxContent/vagrantVMsRepo/kube_hard_way/vagrant$ sudo vagrant up --provider=virtualbox

Below command is working after upgrading vagrant to 2.2.7
$ sudo vagrant up --provider=virtualbox


$ sudo vagrant status
Current machine states:

master-1                  running (virtualbox)
master-2                  running (virtualbox)
master-3                  running (virtualbox)
loadbalancer              running (virtualbox)
worker-1                  running (virtualbox)
worker-2                  running (virtualbox)
worker-3                  running (virtualbox)
worker-4                  running (virtualbox)

This environment represents multiple VMs. The VMs are all listed
above with their current state. For more information about a specific
VM, run `vagrant status NAME`.

# vagrant status

$ vagrant global-status

```



<br>

## Installing the Client Tools

login to master-1 node as vagrant and generate private/public keys

```bash
ssh-keygen
```

```bash
vagrant@master-1:~$ cat .ssh/id_rsa.pub
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC8flC9WztSF3K0s5oATgeP9ZiASnP/qnKaP4gkK5XEYeiyy8vIpiWtNT67dPqDnUuE4yBJIAni50YnXJKPrsSdubMUs/k1y/M/iRosd9NJS7YZbanlfrt1AcqvyLgzfcXX0Xm/RxgXYmHN9kW1LJTSJrD2IA39ceT3oUHPJnb62vxXE8ZsnLlwjcVYwylwWsL8QVlvFX+5dXGryJnLRnd56562YX2AShEm8oapamMo2Lw7B1YqYx4AGc8WFDi2LlHC2qUO0nAOK9XGVyo+VjEuZUD8+EQ9ohC6N0SPnWNOBlbXjRL29N68AvTtPeXPDRg6Mu4eBM/oVDFTQNAwwLm5 vagrant@master-1
vagrant@master-1:~$ 
```

```bash
cat >> ~/.ssh/authorized_keys <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC8flC9WztSF3K0s5oATgeP9ZiASnP/qnKaP4gkK5XEYeiyy8vIpiWtNT67dPqDnUuE4yBJIAni50YnXJKPrsSdubMUs/k1y/M/iRosd9NJS7YZbanlfrt1AcqvyLgzfcXX0Xm/RxgXYmHN9kW1LJTSJrD2IA39ceT3oUHPJnb62vxXE8ZsnLlwjcVYwylwWsL8QVlvFX+5dXGryJnLRnd56562YX2AShEm8oapamMo2Lw7B1YqYx4AGc8WFDi2LlHC2qUO0nAOK9XGVyo+VjEuZUD8+EQ9ohC6N0SPnWNOBlbXjRL29N68AvTtPeXPDRg6Mu4eBM/oVDFTQNAwwLm5 vagrant@master-1
EOF
```



Get stable version information

```bash
curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt
v1.18.1
```



Get latest kubectl -

```bash
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

$ kubectl version --client
Client Version: version.Info{Major:"1", Minor:"18", GitVersion:"v1.18.0", GitCommit:"9e991415386e4cf155a24b1da15becaa390438d8", GitTreeState:"clean", BuildDate:"2020-03-25T14:58:59Z", GoVersion:"go1.13.8", Compiler:"gc", Platform:"linux/amd64"}
```



<br>



## Certificate Authority and TLS Certificates



```bash
- CA
- TLS Certificate

Componet: etcd, kube-apiserver, kube-controller-manager, kube-scheduler, kubelet, and kube-proxy
```



### Certificate Authority

Create a directory to keep all the certificate -

```bash
mkdir -p ~/pki
cd ~/pki
```



Generate CA certificate and key -

```bash
#Create blank file otherwise openssl will generate error
touch ~/.rnd

# Create private key for CA
openssl genrsa -out ca.key 2048

# Create CSR using the private key
openssl req -new -key ca.key -subj "/CN=KUBERNETES-CA" -out ca.csr

# Self sign the csr using its own private key
openssl x509 -req -in ca.csr -signkey ca.key -CAcreateserial  -out ca.crt -days 10000
```



### Admin client Certificate

```bash
# Generate private key for admin user
openssl genrsa -out admin.key 2048

# Generate CSR for admin user. Note the OU.
openssl req -new -key admin.key -subj "/CN=admin/O=system:masters" -out admin.csr

# Sign certificate for admin user using CA servers private key
openssl x509 -req -in admin.csr -CA ca.crt -CAkey ca.key -CAcreateserial  -out admin.crt -days 10000
```



### The Controller Manager Client Certificate

```bash
openssl genrsa -out kube-controller-manager.key 2048
openssl req -new -key kube-controller-manager.key -subj "/CN=system:kube-controller-manager" -out kube-controller-manager.csr
openssl x509 -req -in kube-controller-manager.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out kube-controller-manager.crt -days 10000
```



### The Kube Proxy Client Certificate

```bash
openssl genrsa -out kube-proxy.key 2048
openssl req -new -key kube-proxy.key -subj "/CN=system:kube-proxy" -out kube-proxy.csr
openssl x509 -req -in kube-proxy.csr -CA ca.crt -CAkey ca.key -CAcreateserial  -out kube-proxy.crt -days 10000
```



### The Scheduler Client Certificate

```bash
openssl genrsa -out kube-scheduler.key 2048
openssl req -new -key kube-scheduler.key -subj "/CN=system:kube-scheduler" -out kube-scheduler.csr
openssl x509 -req -in kube-scheduler.csr -CA ca.crt -CAkey ca.key -CAcreateserial  -out kube-scheduler.crt -days 10000
```



### The Kubernetes API Server Certificate

```bash
cat > openssl.cnf <<EOF
[req]
req_extensions = v3_req
distinguished_name = req_distinguished_name
[req_distinguished_name]
[ v3_req ]
basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
subjectAltName = @alt_names
[alt_names]
DNS.1 = kubernetes
DNS.2 = kubernetes.default
DNS.3 = kubernetes.default.svc
DNS.4 = kubernetes.default.svc.cluster.local
IP.1 = 10.96.0.1
IP.2 = 192.168.57.11
IP.3 = 192.168.57.12
IP.4 = 192.168.57.13
IP.5 = 192.168.57.30
IP.6 = 127.0.0.1
EOF
```



```bash
openssl genrsa -out kube-apiserver.key 2048
openssl req -new -key kube-apiserver.key -subj "/CN=kube-apiserver" -out kube-apiserver.csr -config openssl.cnf
openssl x509 -req -in kube-apiserver.csr -CA ca.crt -CAkey ca.key -CAcreateserial  -out kube-apiserver.crt -extensions v3_req -extfile openssl.cnf -days 10000
```



### The ETCD Server Certificate

```bash
cat > openssl-etcd.cnf <<EOF
[req]
req_extensions = v3_req
distinguished_name = req_distinguished_name
[req_distinguished_name]
[ v3_req ]
basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
subjectAltName = @alt_names
[alt_names]
IP.1 = 192.168.57.11
IP.2 = 192.168.57.12
IP.3 = 192.168.57.13
IP.4 = 127.0.0.1
EOF
```



```bash
openssl genrsa -out etcd-server.key 2048
openssl req -new -key etcd-server.key -subj "/CN=etcd-server" -out etcd-server.csr -config openssl-etcd.cnf
openssl x509 -req -in etcd-server.csr -CA ca.crt -CAkey ca.key -CAcreateserial  -out etcd-server.crt -extensions v3_req -extfile openssl-etcd.cnf -days 10000
```



### The Service Account Key Pair

```bash
openssl genrsa -out service-account.key 2048
openssl req -new -key service-account.key -subj "/CN=service-accounts" -out service-account.csr
openssl x509 -req -in service-account.csr -CA ca.crt -CAkey ca.key -CAcreateserial  -out service-account.crt -days 10000
```



### Distribute the Certificates

```bash
cd ~/pki
for instance in master-1 master-2 master-3; do
  scp ca.crt ca.key kube-apiserver.key kube-apiserver.crt \
    service-account.key service-account.crt \
    etcd-server.key etcd-server.crt \
    ${instance}:~/
done
```



<br>





## Generating Kubernetes Configuration Files for Authentication



We will generate kubeconfig files for the `controller manager`, `kubelet`, `kube-proxy`, and `scheduler` clients and the `admin` user.



### Kubernetes Public IP Address

```bash
LOADBALANCER_ADDRESS=192.168.57.30
```



### The kube-proxy Kubernetes Configuration File

```bash
cd ~/pki
{
  kubectl config set-cluster kubernetes-the-hard-way \
    --certificate-authority=ca.crt \
    --embed-certs=true \
    --server=https://${LOADBALANCER_ADDRESS}:6443 \
    --kubeconfig=kube-proxy.kubeconfig

  kubectl config set-credentials system:kube-proxy \
    --client-certificate=kube-proxy.crt \
    --client-key=kube-proxy.key \
    --embed-certs=true \
    --kubeconfig=kube-proxy.kubeconfig

  kubectl config set-context default \
    --cluster=kubernetes-the-hard-way \
    --user=system:kube-proxy \
    --kubeconfig=kube-proxy.kubeconfig

  kubectl config use-context default --kubeconfig=kube-proxy.kubeconfig
}
```



```bash
vagrant@master-1:~/pki$ {
>   kubectl config set-cluster kubernetes-the-hard-way \
>     --certificate-authority=ca.crt \
>     --embed-certs=true \
>     --server=https://${LOADBALANCER_ADDRESS}:6443 \
>     --kubeconfig=kube-proxy.kubeconfig
> 
>   kubectl config set-credentials system:kube-proxy \
>     --client-certificate=kube-proxy.crt \
>     --client-key=kube-proxy.key \
>     --embed-certs=true \
>     --kubeconfig=kube-proxy.kubeconfig
> 
>   kubectl config set-context default \
>     --cluster=kubernetes-the-hard-way \
>     --user=system:kube-proxy \
>     --kubeconfig=kube-proxy.kubeconfig
> 
>   kubectl config use-context default --kubeconfig=kube-proxy.kubeconfig
> }
Cluster "kubernetes-the-hard-way" set.
User "system:kube-proxy" set.
Context "default" created.
Switched to context "default".
vagrant@master-1:~/pki$ 

```



### The kube-controller-manager Kubernetes Configuration File

```bash
cd ~/pki
{
  kubectl config set-cluster kubernetes-the-hard-way \
    --certificate-authority=ca.crt \
    --embed-certs=true \
    --server=https://127.0.0.1:6443 \
    --kubeconfig=kube-controller-manager.kubeconfig

  kubectl config set-credentials system:kube-controller-manager \
    --client-certificate=kube-controller-manager.crt \
    --client-key=kube-controller-manager.key \
    --embed-certs=true \
    --kubeconfig=kube-controller-manager.kubeconfig

  kubectl config set-context default \
    --cluster=kubernetes-the-hard-way \
    --user=system:kube-controller-manager \
    --kubeconfig=kube-controller-manager.kubeconfig

  kubectl config use-context default --kubeconfig=kube-controller-manager.kubeconfig
}
```



### The kube-scheduler Kubernetes Configuration File

```bash
cd ~/pki
{
  kubectl config set-cluster kubernetes-the-hard-way \
    --certificate-authority=ca.crt \
    --embed-certs=true \
    --server=https://127.0.0.1:6443 \
    --kubeconfig=kube-scheduler.kubeconfig

  kubectl config set-credentials system:kube-scheduler \
    --client-certificate=kube-scheduler.crt \
    --client-key=kube-scheduler.key \
    --embed-certs=true \
    --kubeconfig=kube-scheduler.kubeconfig

  kubectl config set-context default \
    --cluster=kubernetes-the-hard-way \
    --user=system:kube-scheduler \
    --kubeconfig=kube-scheduler.kubeconfig

  kubectl config use-context default --kubeconfig=kube-scheduler.kubeconfig
}
```



### The admin Kubernetes Configuration File

```bash
cd ~/pki
{
  kubectl config set-cluster kubernetes-the-hard-way \
    --certificate-authority=ca.crt \
    --embed-certs=true \
    --server=https://127.0.0.1:6443 \
    --kubeconfig=admin.kubeconfig

  kubectl config set-credentials admin \
    --client-certificate=admin.crt \
    --client-key=admin.key \
    --embed-certs=true \
    --kubeconfig=admin.kubeconfig

  kubectl config set-context default \
    --cluster=kubernetes-the-hard-way \
    --user=admin \
    --kubeconfig=admin.kubeconfig

  kubectl config use-context default --kubeconfig=admin.kubeconfig
}
```



```bash
vagrant@master-1:~/pki$ ls *.kubeconfig
admin.kubeconfig  kube-controller-manager.kubeconfig  kube-proxy.kubeconfig  kube-scheduler.kubeconfig
vagrant@master-1:~/pki$ 
```



### Distribute the Kubernetes Configuration Files

Copy the appropriate `kube-proxy` kubeconfig files to each worker instance:

```bash
for instance in worker-1 worker-2; do
  scp kube-proxy.kubeconfig ${instance}:~/
done
```



Copy the appropriate `kube-controller-manager` and `kube-scheduler` kubeconfig files to each controller instance:

```bash
for instance in master-1 master-2 master-3; do
  scp admin.kubeconfig kube-controller-manager.kubeconfig kube-scheduler.kubeconfig ${instance}:~/
done
```

<br>





## Generating the Data Encryption Config and Key

### The Encryption Key

```bash
ENCRYPTION_KEY=$(head -c 32 /dev/urandom | base64)
```

### The Encryption Config File

```bash
cat > encryption-config.yaml <<EOF
kind: EncryptionConfig
apiVersion: v1
resources:
  - resources:
      - secrets
    providers:
      - aescbc:
          keys:
            - name: key1
              secret: ${ENCRYPTION_KEY}
      - identity: {}
EOF
```

Copy the `encryption-config.yaml` encryption config file to each controller instance:

```bash
for instance in master-1 master-2 master-3; do
  scp encryption-config.yaml ${instance}:~/
done
```

<br>



## Bootstrapping the etcd Cluster

Check latest release of etcd binary`https://github.com/etcd-io/etcd/releases`.

### Download and Install etcd

Download `etcd` software:

```bash
ETCD_VER=v3.4.7
# choose either URL
GOOGLE_URL=https://storage.googleapis.com/etcd
GITHUB_URL=https://github.com/etcd-io/etcd/releases/download
DOWNLOAD_URL=${GOOGLE_URL}

curl -L ${DOWNLOAD_URL}/${ETCD_VER}/etcd-${ETCD_VER}-linux-amd64.tar.gz -o ~/etcd-${ETCD_VER}-linux-amd64.tar.gz
```



Extract and install the `etcd` server and the `etcdctl` command line utility:

```bash
ETCD_VER=v3.4.7
{
  tar -xf etcd-${ETCD_VER}-linux-amd64.tar.gz
  sudo mv etcd-${ETCD_VER}-linux-amd64/etcd* /usr/local/bin/
}

{
/usr/local/bin/etcd --version
/usr/local/bin/etcdctl version
}
```



### Configure the etcd Server

```bash
{
  sudo mkdir -p /etc/etcd /var/lib/etcd
  sudo cp ca.crt etcd-server.key etcd-server.crt /etc/etcd/
}
```



```bash
INTERNAL_IP=$(ip addr show enp0s8 | grep "inet " | awk '{print $2}' | cut -d / -f 1)
ETCD_NAME=$(hostname -s)
```

Create the `etcd.service` systemd unit file:

```bash
cat <<EOF | sudo tee /etc/systemd/system/etcd.service
[Unit]
Description=etcd
Documentation=https://github.com/coreos

[Service]
ExecStart=/usr/local/bin/etcd \\
  --name ${ETCD_NAME} \\
  --cert-file=/etc/etcd/etcd-server.crt \\
  --key-file=/etc/etcd/etcd-server.key \\
  --peer-cert-file=/etc/etcd/etcd-server.crt \\
  --peer-key-file=/etc/etcd/etcd-server.key \\
  --trusted-ca-file=/etc/etcd/ca.crt \\
  --peer-trusted-ca-file=/etc/etcd/ca.crt \\
  --peer-client-cert-auth \\
  --client-cert-auth \\
  --initial-advertise-peer-urls https://${INTERNAL_IP}:2380 \\
  --listen-peer-urls https://${INTERNAL_IP}:2380 \\
  --listen-client-urls https://${INTERNAL_IP}:2379,https://127.0.0.1:2379 \\
  --advertise-client-urls https://${INTERNAL_IP}:2379 \\
  --initial-cluster-token etcd-cluster-0 \\
  --initial-cluster master-1=https://192.168.57.11:2380,master-2=https://192.168.57.12:2380,master-3=https://192.168.57.13:2380 \\
  --initial-cluster-state new \\
  --data-dir=/var/lib/etcd
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF
```

### Start the etcd Server

```bash
{
  sudo systemctl daemon-reload
  sudo systemctl enable etcd
  sudo systemctl start etcd
  sudo systemctl status etcd
}
```



### etcd server verification

```bash
sudo ETCDCTL_API=3 etcdctl member list \
  --endpoints=https://127.0.0.1:2379 \
  --cacert=/etc/etcd/ca.crt \
  --cert=/etc/etcd/etcd-server.crt \
  --key=/etc/etcd/etcd-server.key
```



```bash
export etcdargs="--endpoints=https://127.0.0.1:2379   --cacert=/etc/etcd/ca.crt   --cert=/etc/etcd/etcd-server.crt   --key=/etc/etcd/etcd-server.key"
{
sudo ETCDCTL_API=3 etcdctl endpoint status --cluster -w table $etcdargs
sudo ETCDCTL_API=3 etcdctl endpoint health --cluster $etcdargs
}

{
sudo ETCDCTL_API=3 etcdctl endpoint status --cluster -w table $etcdargs
sudo ETCDCTL_API=3 etcdctl endpoint health --cluster -w table $etcdargs
}

--help doc
https://github.com/etcd-io/etcd/tree/master/etcdctl

```



```bash
+----------------------------+------------------+---------+---------+-----------+------------+-----------+------------+--------------------+--------+
|          ENDPOINT          |        ID        | VERSION | DB SIZE | IS LEADER | IS LEARNER | RAFT TERM | RAFT INDEX | RAFT APPLIED INDEX | ERRORS |
+----------------------------+------------------+---------+---------+-----------+------------+-----------+------------+--------------------+--------+
| https://192.168.57.11:2379 | 4357819c96acc3ce |   3.4.7 |   43 MB |     false |      false |       240 |      17767 |              17767 |        |
| https://192.168.57.13:2379 | 5140aead4f7edcf3 |   3.4.7 |   43 MB |      true |      false |       240 |      17767 |              17767 |        |
| https://192.168.57.12:2379 | ab0f9bf91eb36640 |   3.4.7 |   43 MB |     false |      false |       240 |      17767 |              17767 |        |
+----------------------------+------------------+---------+---------+-----------+------------+-----------+------------+--------------------+--------+
https://192.168.57.11:2379 is healthy: successfully committed proposal: took = 11.40301ms
https://192.168.57.13:2379 is healthy: successfully committed proposal: took = 10.883259ms
https://192.168.57.12:2379 is healthy: successfully committed proposal: took = 11.208407ms

```



`Logs:`

```bash
4357819c96acc3ce, started, master-1, https://192.168.57.11:2380, https://192.168.57.11:2379, false
5140aead4f7edcf3, started, master-3, https://192.168.57.13:2380, , false
ab0f9bf91eb36640, started, master-2, https://192.168.57.12:2380, https://192.168.57.12:2379, false
```

```bash
4357819c96acc3ce, started, master-1, https://192.168.57.11:2380, https://192.168.57.11:2379, false
5140aead4f7edcf3, started, master-3, https://192.168.57.13:2380, https://192.168.57.13:2379, false
ab0f9bf91eb36640, started, master-2, https://192.168.57.12:2380, https://192.168.57.12:2379, false
```



<br>



## Bootstrapping the Kubernetes Control Plane

The following components will be installed on each node: `Kubernetes API Server`, `Scheduler`, and `Controller Manager`.



### Provision the Kubernetes Control Plane

Create the Kubernetes configuration directory:

```bash
sudo mkdir -p /etc/kubernetes/config
```



### Download and Install the Kubernetes Controller Binaries

```bash
{
kubeversion=v1.17.4
wget -q --show-progress --https-only --timestamping \
  "https://storage.googleapis.com/kubernetes-release/release/${kubeversion}/bin/linux/amd64/kube-apiserver" \
  "https://storage.googleapis.com/kubernetes-release/release/${kubeversion}/bin/linux/amd64/kube-controller-manager" \
  "https://storage.googleapis.com/kubernetes-release/release/${kubeversion}/bin/linux/amd64/kube-scheduler" \
  "https://storage.googleapis.com/kubernetes-release/release/${kubeversion}/bin/linux/amd64/kubectl"
}
```



Install the Kubernetes binaries:

```bash
{
  chmod +x kube-apiserver kube-controller-manager kube-scheduler kubectl
  sudo mv kube-apiserver kube-controller-manager kube-scheduler kubectl /usr/local/bin/
}
```





### Configure the Kubernetes API Server

```bash
{
  sudo mkdir -p /var/lib/kubernetes/

  sudo cp ca.crt ca.key kube-apiserver.crt kube-apiserver.key \
    service-account.key service-account.crt \
    etcd-server.key etcd-server.crt \
    encryption-config.yaml /var/lib/kubernetes/
}
```



```bash
INTERNAL_IP=$(ip addr show enp0s8 | grep "inet " | awk '{print $2}' | cut -d / -f 1)
echo $INTERNAL_IP
```



```bash
cat <<EOF | sudo tee /etc/systemd/system/kube-apiserver.service
[Unit]
Description=Kubernetes API Server
Documentation=https://github.com/kubernetes/kubernetes

[Service]
ExecStart=/usr/local/bin/kube-apiserver \\
  --advertise-address=${INTERNAL_IP} \\
  --allow-privileged=true \\
  --apiserver-count=3 \\
  --audit-log-maxage=30 \\
  --audit-log-maxbackup=3 \\
  --audit-log-maxsize=100 \\
  --audit-log-path=/var/log/audit.log \\
  --authorization-mode=Node,RBAC \\
  --bind-address=0.0.0.0 \\
  --client-ca-file=/var/lib/kubernetes/ca.crt \\
  --enable-admission-plugins=NodeRestriction,ServiceAccount \\
  --enable-swagger-ui=true \\
  --enable-bootstrap-token-auth=true \\
  --etcd-cafile=/var/lib/kubernetes/ca.crt \\
  --etcd-certfile=/var/lib/kubernetes/etcd-server.crt \\
  --etcd-keyfile=/var/lib/kubernetes/etcd-server.key \\
  --etcd-servers=https://192.168.57.11:2379,https://192.168.57.12:2379,https://192.168.57.13:2379 \\
  --event-ttl=1h \\
  --encryption-provider-config=/var/lib/kubernetes/encryption-config.yaml \\
  --kubelet-certificate-authority=/var/lib/kubernetes/ca.crt \\
  --kubelet-client-certificate=/var/lib/kubernetes/kube-apiserver.crt \\
  --kubelet-client-key=/var/lib/kubernetes/kube-apiserver.key \\
  --kubelet-https=true \\
  --runtime-config="api/all=true" \\
  --service-account-key-file=/var/lib/kubernetes/service-account.crt \\
  --service-cluster-ip-range=10.96.0.0/24 \\
  --service-node-port-range=30000-32767 \\
  --tls-cert-file=/var/lib/kubernetes/kube-apiserver.crt \\
  --tls-private-key-file=/var/lib/kubernetes/kube-apiserver.key \\
  --v=2
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF
```



### Configure the Kubernetes Controller Manager

Move the `kube-controller-manager` kubeconfig into place:

```bash
sudo mv kube-controller-manager.kubeconfig /var/lib/kubernetes/
```

Create the `kube-controller-manager.service` systemd unit file:

```bash
cat <<EOF | sudo tee /etc/systemd/system/kube-controller-manager.service
[Unit]
Description=Kubernetes Controller Manager
Documentation=https://github.com/kubernetes/kubernetes

[Service]
ExecStart=/usr/local/bin/kube-controller-manager \\
  --address=0.0.0.0 \\
  --cluster-cidr=192.168.57.0/24 \\
  --cluster-name=kubernetes \\
  --cluster-signing-cert-file=/var/lib/kubernetes/ca.crt \\
  --cluster-signing-key-file=/var/lib/kubernetes/ca.key \\
  --kubeconfig=/var/lib/kubernetes/kube-controller-manager.kubeconfig \\
  --leader-elect=true \\
  --root-ca-file=/var/lib/kubernetes/ca.crt \\
  --service-account-private-key-file=/var/lib/kubernetes/service-account.key \\
  --service-cluster-ip-range=10.96.0.0/24 \\
  --use-service-account-credentials=true \\
  --v=2
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF
```



### Configure the Kubernetes Scheduler

Move the `kube-scheduler` kubeconfig into place:

```bash
sudo mv kube-scheduler.kubeconfig /var/lib/kubernetes/
```

Create the `kube-scheduler.service` systemd unit file:

```bash
cat <<EOF | sudo tee /etc/systemd/system/kube-scheduler.service
[Unit]
Description=Kubernetes Scheduler
Documentation=https://github.com/kubernetes/kubernetes

[Service]
ExecStart=/usr/local/bin/kube-scheduler \\
  --kubeconfig=/var/lib/kubernetes/kube-scheduler.kubeconfig \\
  --address=127.0.0.1 \\
  --leader-elect=true \\
  --v=2
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF
```



### Start the Controller Services

```bash
{
  sudo systemctl daemon-reload
  sudo systemctl enable kube-apiserver kube-controller-manager kube-scheduler
  sudo systemctl start kube-apiserver kube-controller-manager kube-scheduler
  sudo systemctl status kube-apiserver kube-controller-manager kube-scheduler
}
```



```bash
{
  sudo systemctl daemon-reload
  sudo systemctl stop kube-apiserver kube-controller-manager kube-scheduler
  sudo systemctl start kube-apiserver kube-controller-manager kube-scheduler
  #sudo systemctl status kube-apiserver kube-controller-manager kube-scheduler
}
```



### Controller Services starting issue

`kube-apiserver` is not starting and giving error messages in `/var/log/syslog`

```bash
tail -f /var/log/syslog
....
Apr  8 19:03:17 master-1 kube-apiserver[31992]: I0408 19:03:17.444972   31992 server.go:639] Initializing cache sizes based on 0MB limit
Apr  8 19:03:17 master-1 kube-apiserver[31992]: I0408 19:03:17.445106   31992 server.go:150] Version: v1.17.4
Apr  8 19:03:17 master-1 kube-apiserver[31992]: Error: invalid value api/all=
Apr  8 19:03:17 master-1 kube-apiserver[31992]: Usage:
Apr  8 19:03:17 master-1 kube-apiserver[31992]:   kube-apiserver [flags]
...

Apr  7 04:26:45 master-2 kube-controller-manager[16861]: E0407 04:26:45.455342   16861 leaderelection.go:320] error retrieving resource lock kube-system/kube-controller-manager: Get https://127.0.0.1:6443/api/v1/namespaces/kube-system/endpoints/kube-controller-manager?timeout=10s: dial tcp 127.0.0.1:6443: connect: connection refused
....

```



Service staring issue of `kube-apiserver` is resolved by setting value as `api/all=true` for the `runtime-config` parameter in the start config file. 

```bash
vi  /etc/systemd/system/kube-apiserver.service

....
--runtime-config="api/all=true"
... 

```



### Verfication for Controller Services

```bash
kubectl get componentstatuses --kubeconfig admin.kubeconfig
```



```bash
vagrant@master-1:~$ kubectl get componentstatuses --kubeconfig admin.kubeconfig
NAME                 STATUS      MESSAGE                                                                                     ERROR
controller-manager   Unhealthy   Get http://127.0.0.1:10252/healthz: dial tcp 127.0.0.1:10252: connect: connection refused   
scheduler            Unhealthy   Get http://127.0.0.1:10251/healthz: dial tcp 127.0.0.1:10251: connect: connection refused   
etcd-0               Healthy     {"health":"true"}                                                                           
etcd-1               Healthy     {"health":"true"}                                                                           
etcd-2               Healthy     {"health":"true"}                                                                           
vagrant@master-1:~$ 

```



```bash
vagrant@master-1:~$ kubectl get componentstatuses --kubeconfig admin.kubeconfig
NAME                 STATUS    MESSAGE             ERROR
scheduler            Healthy   ok                  
controller-manager   Healthy   ok                  
etcd-1               Healthy   {"health":"true"}   
etcd-2               Healthy   {"health":"true"}   
etcd-0               Healthy   {"health":"true"}   
vagrant@master-1:~$ 

vagrant@master-3:~$ kubectl get componentstatuses --kubeconfig admin.kubeconfig
NAME                 STATUS    MESSAGE             ERROR
scheduler            Healthy   ok                  
controller-manager   Healthy   ok                  
etcd-2               Healthy   {"health":"true"}   
etcd-1               Healthy   {"health":"true"}   
etcd-0               Healthy   {"health":"true"}   
vagrant@master-3:~$ 

```





<br>

## The Kubernetes Frontend Load Balancer

### Provision a Network Load Balancer

```bash
#Install HAProxy loadbalancer# 
sudo apt-get update && sudo apt-get install -y haproxy
```



```bash
loadbalancer# cat <<EOF | sudo tee /etc/haproxy/haproxy.cfg 
frontend kubernetes
    bind 192.168.57.30:6443
    option tcplog
    mode tcp
    default_backend kubernetes-master-nodes

backend kubernetes-master-nodes
    mode tcp
    balance roundrobin
    option tcp-check
    server master-1 192.168.57.11:6443 check fall 3 rise 2
    server master-2 192.168.57.12:6443 check fall 3 rise 2
    server master-3 192.168.57.13:6443 check fall 3 rise 2
EOF
```



```bash
loadbalancer# sudo service haproxy restart
```



```bash
curl  https://192.168.57.30:6443/version -k
```

```bash
vagrant@loadbalancer:~$ curl  https://192.168.57.30:6443/version -k
{
  "major": "1",
  "minor": "17",
  "gitVersion": "v1.17.4",
  "gitCommit": "8d8aa39598534325ad77120c120a22b3a990b5ea",
  "gitTreeState": "clean",
  "buildDate": "2020-03-12T20:55:23Z",
  "goVersion": "go1.13.8",
  "compiler": "gc",
  "platform": "linux/amd64"
}vagrant@loadbalancer:~$ 

```





<br>

## Bootstrapping the Kubernetes Worker Nodes



### Generate Certificate for worker-1

Generate certificate for worker-1 in master-1.

```bash
cat > openssl-worker-1.cnf <<EOF
[req]
req_extensions = v3_req
distinguished_name = req_distinguished_name
[req_distinguished_name]
[ v3_req ]
basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
subjectAltName = @alt_names
[alt_names]
DNS.1 = worker-1
IP.1 = 192.168.57.21
EOF

openssl genrsa -out worker-1.key 2048
openssl req -new -key worker-1.key -subj "/CN=system:node:worker-1/O=system:nodes" -out worker-1.csr -config openssl-worker-1.cnf
openssl x509 -req -in worker-1.csr -CA ca.crt -CAkey ca.key -CAcreateserial  -out worker-1.crt -extensions v3_req -extfile openssl-worker-1.cnf -days 10000
```



### The kubelet Kubernetes Configuration File

Get the kub-api server load-balancer IP.

```
LOADBALANCER_ADDRESS=192.168.57.30
```

Generate a kubeconfig file for the first worker node at master-1:

```bash
master-1$
{
  kubectl config set-cluster kubernetes-the-hard-way \
    --certificate-authority=ca.crt \
    --embed-certs=true \
    --server=https://${LOADBALANCER_ADDRESS}:6443 \
    --kubeconfig=worker-1.kubeconfig

  kubectl config set-credentials system:node:worker-1 \
    --client-certificate=worker-1.crt \
    --client-key=worker-1.key \
    --embed-certs=true \
    --kubeconfig=worker-1.kubeconfig

  kubectl config set-context default \
    --cluster=kubernetes-the-hard-way \
    --user=system:node:worker-1 \
    --kubeconfig=worker-1.kubeconfig

  kubectl config use-context default --kubeconfig=worker-1.kubeconfig
}
```



### Copy certificates, private keys and kubeconfig files to the worker node:

```bash
master-1$ scp ca.crt worker-1.crt worker-1.key worker-1.kubeconfig worker-1:~/
```



### Download and Install Worker Binaries

Going forward all activities are to be done on the `worker-1` node.

```bash

{
kubeversion=v1.17.4
wget -q --show-progress --https-only --timestamping \
  https://storage.googleapis.com/kubernetes-release/release/${kubeversion}/bin/linux/amd64/kubectl \
  https://storage.googleapis.com/kubernetes-release/release/${kubeversion}/bin/linux/amd64/kube-proxy \
  https://storage.googleapis.com/kubernetes-release/release/${kubeversion}/bin/linux/amd64/kubelet
}
```



Create the installation directories:

```bash
{
sudo mkdir -p \
  /etc/cni/net.d \
  /opt/cni/bin \
  /var/lib/kubelet \
  /var/lib/kube-proxy \
  /var/lib/kubernetes \
  /var/run/kubernetes
}  
```

Install the worker binaries:

```bash
{
  chmod +x kubectl kube-proxy kubelet
  sudo mv kubectl kube-proxy kubelet /usr/local/bin/
}
```



### Configure the Kubelet

```bash
{
  sudo mv ${HOSTNAME}.key ${HOSTNAME}.crt /var/lib/kubelet/
  sudo mv ${HOSTNAME}.kubeconfig /var/lib/kubelet/kubeconfig
  sudo mv ca.crt /var/lib/kubernetes/
}
```



Create the `kubelet-config.yaml` configuration file:

```bash
cat <<EOF | sudo tee /var/lib/kubelet/kubelet-config.yaml
kind: KubeletConfiguration
apiVersion: kubelet.config.k8s.io/v1beta1
authentication:
  anonymous:
    enabled: false
  webhook:
    enabled: true
  x509:
    clientCAFile: "/var/lib/kubernetes/ca.crt"
authorization:
  mode: Webhook
clusterDomain: "cluster.local"
clusterDNS:
  - "10.96.0.10"
resolvConf: "/run/systemd/resolve/resolv.conf"
runtimeRequestTimeout: "15m"
EOF
```



Create the `kubelet.service` systemd unit file:

```bash
cat <<EOF | sudo tee /etc/systemd/system/kubelet.service
[Unit]
Description=Kubernetes Kubelet
Documentation=https://github.com/kubernetes/kubernetes
After=docker.service
Requires=docker.service

[Service]
ExecStart=/usr/local/bin/kubelet \\
  --config=/var/lib/kubelet/kubelet-config.yaml \\
  --image-pull-progress-deadline=2m \\
  --kubeconfig=/var/lib/kubelet/kubeconfig \\
  --tls-cert-file=/var/lib/kubelet/${HOSTNAME}.crt \\
  --tls-private-key-file=/var/lib/kubelet/${HOSTNAME}.key \\
  --network-plugin=cni \\
  --register-node=true \\
  --v=2
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF
```





### Configure the Kubernetes Proxy

```bash
worker-1$ sudo mv kube-proxy.kubeconfig /var/lib/kube-proxy/kubeconfig
```



Create the `kube-proxy-config.yaml` configuration file:

```bash
worker-1$ cat <<EOF | sudo tee /var/lib/kube-proxy/kube-proxy-config.yaml
kind: KubeProxyConfiguration
apiVersion: kubeproxy.config.k8s.io/v1alpha1
clientConnection:
  kubeconfig: "/var/lib/kube-proxy/kubeconfig"
mode: "iptables"
clusterCIDR: "192.168.57.0/24"
EOF
```

Create the `kube-proxy.service` systemd unit file:

```bash
worker-1$ cat <<EOF | sudo tee /etc/systemd/system/kube-proxy.service
[Unit]
Description=Kubernetes Kube Proxy
Documentation=https://github.com/kubernetes/kubernetes

[Service]
ExecStart=/usr/local/bin/kube-proxy \\
  --config=/var/lib/kube-proxy/kube-proxy-config.yaml
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF
```



### Start the Worker Services

```bash
{
  sudo systemctl daemon-reload
  sudo systemctl enable kubelet kube-proxy
  sudo systemctl start kubelet kube-proxy
}
```



### Verification

List the registered Kubernetes nodes from the master node:

```
master-1$ kubectl get nodes --kubeconfig admin.kubeconfig
```



<br>

## TLS Bootstrapping Worker Nodes



### Pre-Requisite

**kube-apiserver** - Ensure bootstrap token based authentication is enabled on the kube-apiserver.

```
--enable-bootstrap-token-auth=true
```

**kube-controller-manager** - The certificate requests are signed by the kube-controller-manager ultimately. The kube-controller-manager requires the CA Certificate and Key to perform these operations.

```
  --cluster-signing-cert-file=/var/lib/kubernetes/ca.crt \\
  --cluster-signing-key-file=/var/lib/kubernetes/ca.key
```

Copy the ca certificate to the worker node:

```bash
scp ca.crt worker-2:~/
```

### Configure the Binaries on the Worker node

Going forward all activities are to be done on the `worker-1` node.

```bash
{
kubeversion=v1.17.4
wget -q --show-progress --https-only --timestamping \
  https://storage.googleapis.com/kubernetes-release/release/${kubeversion}/bin/linux/amd64/kubectl \
  https://storage.googleapis.com/kubernetes-release/release/${kubeversion}/bin/linux/amd64/kube-proxy \
  https://storage.googleapis.com/kubernetes-release/release/${kubeversion}/bin/linux/amd64/kubelet
}
```



Create the installation directories:

```bash
{
sudo mkdir -p \
  /etc/cni/net.d \
  /opt/cni/bin \
  /var/lib/kubelet \
  /var/lib/kube-proxy \
  /var/lib/kubernetes \
  /var/run/kubernetes
}  
```

Install the worker binaries:

```bash
{
  chmod +x kubectl kube-proxy kubelet
  sudo mv kubectl kube-proxy kubelet /usr/local/bin/
}
```

### Move the ca certificate

```
sudo mv ca.crt /var/lib/kubernetes/
```



`Note:` Step-1 to Step-3 is require to execute in master node.



### Step 1 Create the Boostrap Token to be used by Nodes(Kubelets) to invoke Certificate API

Bootstrap Tokens are created as a secret in the kube-system namespace.

```bash
cat > bootstrap-token-07401b.yaml <<EOF
apiVersion: v1
kind: Secret
metadata:
  # Name MUST be of form "bootstrap-token-<token id>"
  name: bootstrap-token-07401b
  namespace: kube-system

# Type MUST be 'bootstrap.kubernetes.io/token'
type: bootstrap.kubernetes.io/token
stringData:
  # Human readable description. Optional.
  description: "The default bootstrap token generated by 'kubeadm init'."

  # Token ID and secret. Required.
  token-id: 07401b
  token-secret: f395accd246ae52d

  # Expiration. Optional.
  expiration: 2021-03-10T03:22:11Z

  # Allowed usages.
  usage-bootstrap-authentication: "true"
  usage-bootstrap-signing: "true"

  # Extra groups to authenticate the token as. Must start with "system:bootstrappers:"
  auth-extra-groups: system:bootstrappers:worker
EOF


kubectl create -f bootstrap-token-07401b.yaml

```

```bash
vagrant@master-1:~$ kubectl create -f bootstrap-token-07401b.yaml
secret/bootstrap-token-07401b created
vagrant@master-1:~$ 
```



### Step 2 Authorize workers(kubelets) to create CSR

```bash
kubectl create clusterrolebinding create-csrs-for-bootstrapping --clusterrole=system:node-bootstrapper --group=system:bootstrappers
```



### Step 3 Authorize workers(kubelets) to approve CSR

```bash
kubectl create clusterrolebinding auto-approve-csrs-for-group --clusterrole=system:certificates.k8s.io:certificatesigningrequests:nodeclient --group=system:bootstrappers
```

### Step 3 Authorize workers(kubelets) to Auto Renew Certificates on expiration

```bash
kubectl create clusterrolebinding auto-approve-renewals-for-nodes --clusterrole=system:certificates.k8s.io:certificatesigningrequests:selfnodeclient --group=system:nodes
```



`Logs`

```bash
vagrant@master-1:~$ kubectl create -f bootstrap-token-07401b.yaml
secret/bootstrap-token-07401b created
vagrant@master-1:~$ kubectl create clusterrolebinding create-csrs-for-bootstrapping --clusterrole=system:node-bootstrapper --group=system:bootstrappers
clusterrolebinding.rbac.authorization.k8s.io/create-csrs-for-bootstrapping created
vagrant@master-1:~$ kubectl create clusterrolebinding auto-approve-csrs-for-group --clusterrole=system:certificates.k8s.io:certificatesigningrequests:nodeclient --group=system:bootstrappers
clusterrolebinding.rbac.authorization.k8s.io/auto-approve-csrs-for-group created
vagrant@master-1:~$ kubectl create clusterrolebinding auto-approve-renewals-for-nodes --clusterrole=system:certificates.k8s.io:certificatesigningrequests:selfnodeclient --group=system:nodes
clusterrolebinding.rbac.authorization.k8s.io/auto-approve-renewals-for-nodes created
vagrant@master-1:~$ 

```







### Step 4 Configure Kubelet to TLS Bootstrap

```bash
sudo kubectl config --kubeconfig=/var/lib/kubelet/bootstrap-kubeconfig set-cluster bootstrap --server='https://192.168.57.30:6443' --certificate-authority=/var/lib/kubernetes/ca.crt
sudo kubectl config --kubeconfig=/var/lib/kubelet/bootstrap-kubeconfig set-credentials kubelet-bootstrap --token=07401b.f395accd246ae52d
sudo kubectl config --kubeconfig=/var/lib/kubelet/bootstrap-kubeconfig set-context bootstrap --user=kubelet-bootstrap --cluster=bootstrap
sudo kubectl config --kubeconfig=/var/lib/kubelet/bootstrap-kubeconfig use-context bootstrap
```



Execution logs

```bash
vagrant@worker-2:~$ sudo kubectl config --kubeconfig=/var/lib/kubelet/bootstrap-kubeconfig set-cluster bootstrap --server='https://192.168.57.30:6443' --certificate-authority=/var/lib/kubernetes/ca.crt
Cluster "bootstrap" set.
vagrant@worker-2:~$ sudo kubectl config --kubeconfig=/var/lib/kubelet/bootstrap-kubeconfig set-credentials kubelet-bootstrap --token=07401b.f395accd246ae52d
User "kubelet-bootstrap" set.
vagrant@worker-2:~$ sudo kubectl config --kubeconfig=/var/lib/kubelet/bootstrap-kubeconfig set-context bootstrap --user=kubelet-bootstrap --cluster=bootstrap
Context "bootstrap" created.
vagrant@worker-2:~$ sudo kubectl config --kubeconfig=/var/lib/kubelet/bootstrap-kubeconfig use-context bootstrap
Switched to context "bootstrap".
vagrant@worker-2:~$ 

```





### Step 5 Create Kubelet Config File

```bash
cat <<EOF | sudo tee /var/lib/kubelet/kubelet-config.yaml
kind: KubeletConfiguration
apiVersion: kubelet.config.k8s.io/v1beta1
authentication:
  anonymous:
    enabled: false
  webhook:
    enabled: true
  x509:
    clientCAFile: "/var/lib/kubernetes/ca.crt"
authorization:
  mode: Webhook
clusterDomain: "cluster.local"
clusterDNS:
  - "10.96.0.10"
resolvConf: "/run/systemd/resolve/resolv.conf"
runtimeRequestTimeout: "15m"
EOF
```

### Step 6 Configure Kubelet Service

```bash
cat <<EOF | sudo tee /etc/systemd/system/kubelet.service
[Unit]
Description=Kubernetes Kubelet
Documentation=https://github.com/kubernetes/kubernetes
After=docker.service
Requires=docker.service

[Service]
ExecStart=/usr/local/bin/kubelet \\
  --bootstrap-kubeconfig="/var/lib/kubelet/bootstrap-kubeconfig" \\
  --config=/var/lib/kubelet/kubelet-config.yaml \\
  --image-pull-progress-deadline=2m \\
  --kubeconfig=/var/lib/kubelet/kubeconfig \\
  --cert-dir=/var/lib/kubelet/pki/ \\
  --rotate-certificates=true \\
  --rotate-server-certificates=true \\
  --network-plugin=cni \\
  --register-node=true \\
  --v=2
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF
```



### Step 7 Configure the Kubernetes Proxy

```bash
sudo mv kube-proxy.kubeconfig /var/lib/kube-proxy/kubeconfig

```

Create the `kube-proxy-config.yaml` configuration file:

```bash
cat <<EOF | sudo tee /var/lib/kube-proxy/kube-proxy-config.yaml
kind: KubeProxyConfiguration
apiVersion: kubeproxy.config.k8s.io/v1alpha1
clientConnection:
  kubeconfig: "/var/lib/kube-proxy/kubeconfig"
mode: "iptables"
clusterCIDR: "192.168.57.0/24"
EOF
```

Create the `kube-proxy.service` systemd unit file:

```bash
cat <<EOF | sudo tee /etc/systemd/system/kube-proxy.service
[Unit]
Description=Kubernetes Kube Proxy
Documentation=https://github.com/kubernetes/kubernetes

[Service]
ExecStart=/usr/local/bin/kube-proxy \\
  --config=/var/lib/kube-proxy/kube-proxy-config.yaml
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF
```



### Step 8 Start the Worker Services

```bash
{
  sudo systemctl daemon-reload
  sudo systemctl enable kubelet kube-proxy
  sudo systemctl start kubelet kube-proxy
}
```

### Step 9 Approve Server CSR

In master

```bash
kubectl get csr
```

### Verification

List the registered Kubernetes nodes from the master node:

```
master-1$ kubectl get nodes --kubeconfig admin.kubeconfig
```



### `Logs`

```bash
vagrant@master-1:~$ kubectl get csr
NAME        AGE   REQUESTOR                 CONDITION
csr-chkpp   41s   system:bootstrap:07401b   Approved,Issued
csr-rzsrd   37s   system:node:worker-2      Pending
vagrant@master-1:~$ kubectl get nodes --kubeconfig admin.kubeconfig
NAME       STATUS     ROLES    AGE   VERSION
worker-1   NotReady   <none>   58m   v1.17.4
worker-2   NotReady   <none>   44s   v1.17.4
vagrant@master-1:~$ 

vagrant@master-2:~$ kubectl get csr
error: no configuration has been provided, try setting KUBERNETES_MASTER environment variable
vagrant@master-2:~$ 



vagrant@master-1:~/pki$ kubectl describe csr csr-rzsrd
Name:               csr-rzsrd
Labels:             <none>
Annotations:        <none>
CreationTimestamp:  Wed, 08 Apr 2020 21:22:40 +0000
Requesting User:    system:node:worker-2
Status:             Pending
Subject:
  Common Name:    system:node:worker-2
  Serial Number:  
  Organization:   system:nodes
Subject Alternative Names:
         DNS Names:     worker-2
         IP Addresses:  192.168.57.22
Events:  <none>
vagrant@master-1:~/pki$ 


kubectl certificate approve csr-rzsrd


vagrant@master-1:~/pki$ kubectl describe csr csr-rzsrd
Name:               csr-rzsrd
Labels:             <none>
Annotations:        <none>
CreationTimestamp:  Wed, 08 Apr 2020 21:22:40 +0000
Requesting User:    system:node:worker-2
Status:             Approved,Issued
Subject:
  Common Name:    system:node:worker-2
  Serial Number:  
  Organization:   system:nodes
Subject Alternative Names:
         DNS Names:     worker-2
         IP Addresses:  192.168.57.22
Events:  <none>
vagrant@master-1:~/pki$ 

```



<br>



## Configuring kubectl for Remote Access



```bash
cd ~/pki

{
  KUBERNETES_LB_ADDRESS=192.168.57.30

  kubectl config set-cluster kubernetes-the-hard-way \
    --certificate-authority=ca.crt \
    --embed-certs=true \
    --server=https://${KUBERNETES_LB_ADDRESS}:6443

  kubectl config set-credentials admin \
    --client-certificate=admin.crt \
    --client-key=admin.key

  kubectl config set-context kubernetes-the-hard-way \
    --cluster=kubernetes-the-hard-way \
    --user=admin

  kubectl config use-context kubernetes-the-hard-way
} 
```



```bash
kubectl get componentstatuses
```

```bash
kubectl get nodes
```

<br>

## Provisioning Pod Network

### Install CNI plugins

In worker node -

```bash
wget https://github.com/containernetworking/plugins/releases/download/v0.8.5/cni-plugins-linux-amd64-v0.8.5.tgz
sudo tar -xzvf cni-plugins-linux-amd64-v0.8.5.tgz --directory /opt/cni/bin/
```



### Deploy weave network

Deploy weave network. Run only once on the `master` node.

```bash
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"
```



```bash
echo https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')

https://cloud.weave.works/k8s/net?k8s-version=Q2xpZW50IFZlcnNpb246IHZlcnNpb24uSW5mb3tNYWpvcjoiMSIsIE1pbm9yOiIxNyIsIEdpdFZlcnNpb246InYxLjE3LjQiLCBHaXRDb21taXQ6IjhkOGFhMzk1OTg1MzQzMjVhZDc3MTIwYzEyMGEyMmIzYTk5MGI1ZWEiLCBHaXRUcmVlU3RhdGU6ImNsZWFuIiwgQnVpbGREYXRlOiIyMDIwLTAzLTEyVDIxOjAzOjQyWiIsIEdvVmVyc2lvbjoiZ28xLjEzLjgiLCBDb21waWxlcjoiZ2MiLCBQbGF0Zm9ybToibGludXgvYW1kNjQifQpTZXJ2ZXIgVmVyc2lvbjogdmVyc2lvbi5JbmZve01ham9yOiIxIiwgTWlub3I6IjE4IiwgR2l0VmVyc2lvbjoidjEuMTguMCIsIEdpdENvbW1pdDoiOWU5OTE0MTUzODZlNGNmMTU1YTI0YjFkYTE1YmVjYWEzOTA0MzhkOCIsIEdpdFRyZWVTdGF0ZToiY2xlYW4iLCBCdWlsZERhdGU6IjIwMjAtMDMtMjVUMTQ6NTA6NDZaIiwgR29WZXJzaW9uOiJnbzEuMTMuOCIsIENvbXBpbGVyOiJnYyIsIFBsYXRmb3JtOiJsaW51eC9hbWQ2NCJ9Cg==
```





```bash
vagrant@master-1:~/pki$ kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"
serviceaccount/weave-net created
clusterrole.rbac.authorization.k8s.io/weave-net created
clusterrolebinding.rbac.authorization.k8s.io/weave-net created
role.rbac.authorization.k8s.io/weave-net created
rolebinding.rbac.authorization.k8s.io/weave-net created
daemonset.apps/weave-net created
vagrant@master-1:~/pki$ 

```



```bash
vagrant@master-1:~/pki$ kubectl get node
NAME       STATUS     ROLES    AGE   VERSION
worker-1   Ready      <none>   96m   v1.17.4
worker-2   NotReady   <none>   38m   v1.17.4
vagrant@master-1:~/pki$ 

```



```bash
vagrant@master-1:~/pki$ kubectl get node
NAME       STATUS   ROLES    AGE   VERSION
worker-1   Ready    <none>   97m   v1.17.4
worker-2   Ready    <none>   39m   v1.17.4
vagrant@master-1:~/pki$ 

```

```bash
vagrant@master-1:~/pki$ kubectl get pods -n kube-system
NAME              READY   STATUS    RESTARTS   AGE
weave-net-7vkms   2/2     Running   0          4m54s
weave-net-w7txv   2/2     Running   0          4m54s
vagrant@master-1:~/pki$ 


vagrant@master-1:~/pki$ kubectl get pods -A
NAMESPACE     NAME              READY   STATUS    RESTARTS   AGE
kube-system   weave-net-7vkms   2/2     Running   0          5m22s
kube-system   weave-net-w7txv   2/2     Running   0          5m22s
vagrant@master-1:~/pki$ kubectl get pods -A -o wide
NAMESPACE     NAME              READY   STATUS    RESTARTS   AGE     IP              NODE       NOMINATED NODE   READINESS GATES
kube-system   weave-net-7vkms   2/2     Running   0          5m30s   192.168.57.22   worker-2   <none>           <none>
kube-system   weave-net-w7txv   2/2     Running   0          5m30s   192.168.57.21   worker-1   <none>           <none>
vagrant@master-1:~/pki$ 

```



<br>

## RBAC for Kubelet Authorization

In this section you will configure RBAC permissions to allow the Kubernetes API Server to access the Kubelet API on each worker node. Access to the Kubelet API is required for retrieving metrics, logs, and executing commands in pods.



### List current role:

```bash
kubectl get clusterroles
kubectl get clusterroles system:discovery 
```



Create the `system:kube-apiserver-to-kubelet` [ClusterRole](https://kubernetes.io/docs/admin/authorization/rbac/#role-and-clusterrole) with permissions to access the Kubelet API and perform most common tasks associated with managing pods:

```bash
cat <<EOF | kubectl apply --kubeconfig admin.kubeconfig -f -
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRole
metadata:
  annotations:
    rbac.authorization.kubernetes.io/autoupdate: "true"
  labels:
    kubernetes.io/bootstrapping: rbac-defaults
  name: system:kube-apiserver-to-kubelet
rules:
  - apiGroups:
      - ""
    resources:
      - nodes/proxy
      - nodes/stats
      - nodes/log
      - nodes/spec
      - nodes/metrics
    verbs:
      - "*"
EOF
```



The Kubernetes API Server authenticates to the Kubelet as the `kubernetes` user using the client certificate as defined by the `--kubelet-client-certificate` flag.

Bind the `system:kube-apiserver-to-kubelet` ClusterRole to the `kubernetes` user:

```bash
cat <<EOF | kubectl apply --kubeconfig admin.kubeconfig -f -
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRoleBinding
metadata:
  name: system:kube-apiserver
  namespace: ""
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: system:kube-apiserver-to-kubelet
subjects:
  - apiGroup: rbac.authorization.k8s.io
    kind: User
    name: kube-apiserver
EOF
```



```bash
kubectl auth can-i create deployments --namespace dev
kubectl auth can-i create deployments --namespace prod
```



```bash
vagrant@master-1:~/pki$ kubectl get clusterroles system:discovery -o yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  annotations:
    rbac.authorization.kubernetes.io/autoupdate: "true"
  creationTimestamp: "2020-04-08T19:11:52Z"
  labels:
    kubernetes.io/bootstrapping: rbac-defaults
  name: system:discovery
  resourceVersion: "17793"
  selfLink: /apis/rbac.authorization.k8s.io/v1/clusterroles/system%3Adiscovery
  uid: ced4c960-8d38-4af4-b95b-627b8774f5b5
rules:
- nonResourceURLs:
  - /api
  - /api/*
  - /apis
  - /apis/*
  - /healthz
  - /livez
  - /openapi
  - /openapi/*
  - /readyz
  - /version
  - /version/
  verbs:
  - get
vagrant@master-1:~/pki$ kubectl get clusterroles system:discovery 
NAME               CREATED AT
system:discovery   2020-04-08T19:11:52Z
vagrant@master-1:~/pki$ 

```



### Execution logs:

```bash
vagrant@master-1:~/pki$ cat <<EOF | kubectl apply --kubeconfig admin.kubeconfig -f -
> apiVersion: rbac.authorization.k8s.io/v1beta1
> kind: ClusterRole
> metadata:
>   annotations:
>     rbac.authorization.kubernetes.io/autoupdate: "true"
>   labels:
>     kubernetes.io/bootstrapping: rbac-defaults
>   name: system:kube-apiserver-to-kubelet
> rules:
>   - apiGroups:
>       - ""
>     resources:
>       - nodes/proxy
>       - nodes/stats
>       - nodes/log
>       - nodes/spec
>       - nodes/metrics
>     verbs:
>       - "*"
> EOF
clusterrole.rbac.authorization.k8s.io/system:kube-apiserver-to-kubelet created
vagrant@master-1:~/pki$ 

vagrant@master-1:~/pki$ kubectl get clusterroles system:kube-apiserver-to-kubelet
NAME                               AGE
system:kube-apiserver-to-kubelet   3m55s
vagrant@master-1:~/pki$ 

vagrant@master-1:~/pki$ kubectl get clusterroles 
NAME                                                                   CREATED AT
admin                                                                  2020-04-08T19:11:52Z
cluster-admin                                                          2020-04-08T19:11:52Z
edit                                                                   2020-04-08T19:11:52Z
system:aggregate-to-admin                                              2020-04-08T19:11:52Z
system:aggregate-to-edit                                               2020-04-08T19:11:52Z
system:aggregate-to-view                                               2020-04-08T19:11:52Z
system:auth-delegator                                                  2020-04-08T19:11:52Z
system:basic-user                                                      2020-04-08T19:11:52Z
system:certificates.k8s.io:certificatesigningrequests:nodeclient       2020-04-08T19:11:52Z
system:certificates.k8s.io:certificatesigningrequests:selfnodeclient   2020-04-08T19:11:52Z
system:certificates.k8s.io:kube-apiserver-client-approver              2020-04-08T19:21:13Z
system:certificates.k8s.io:kube-apiserver-client-kubelet-approver      2020-04-08T19:21:13Z
system:certificates.k8s.io:kubelet-serving-approver                    2020-04-08T19:21:13Z
system:certificates.k8s.io:legacy-unknown-approver                     2020-04-08T19:21:13Z
system:controller:attachdetach-controller                              2020-04-08T19:11:52Z
system:controller:certificate-controller                               2020-04-08T19:11:53Z
system:controller:clusterrole-aggregation-controller                   2020-04-08T19:11:53Z
system:controller:cronjob-controller                                   2020-04-08T19:11:53Z
system:controller:daemon-set-controller                                2020-04-08T19:11:53Z
system:controller:deployment-controller                                2020-04-08T19:11:53Z
system:controller:disruption-controller                                2020-04-08T19:11:53Z
system:controller:endpoint-controller                                  2020-04-08T19:11:53Z
system:controller:endpointslice-controller                             2020-04-08T19:21:13Z
system:controller:expand-controller                                    2020-04-08T19:11:53Z
system:controller:generic-garbage-collector                            2020-04-08T19:11:53Z
system:controller:horizontal-pod-autoscaler                            2020-04-08T19:11:53Z
system:controller:job-controller                                       2020-04-08T19:11:53Z
system:controller:namespace-controller                                 2020-04-08T19:11:53Z
system:controller:node-controller                                      2020-04-08T19:11:53Z
system:controller:persistent-volume-binder                             2020-04-08T19:11:53Z
system:controller:pod-garbage-collector                                2020-04-08T19:11:53Z
system:controller:pv-protection-controller                             2020-04-08T19:11:53Z
system:controller:pvc-protection-controller                            2020-04-08T19:11:53Z
system:controller:replicaset-controller                                2020-04-08T19:11:53Z
system:controller:replication-controller                               2020-04-08T19:11:53Z
system:controller:resourcequota-controller                             2020-04-08T19:11:53Z
system:controller:route-controller                                     2020-04-08T19:11:53Z
system:controller:service-account-controller                           2020-04-08T19:11:53Z
system:controller:service-controller                                   2020-04-08T19:11:53Z
system:controller:statefulset-controller                               2020-04-08T19:11:53Z
system:controller:ttl-controller                                       2020-04-08T19:11:53Z
system:discovery                                                       2020-04-08T19:11:52Z
system:heapster                                                        2020-04-08T19:11:52Z
system:kube-aggregator                                                 2020-04-08T19:11:52Z
system:kube-apiserver-to-kubelet                                       2020-04-09T02:05:03Z
system:kube-controller-manager                                         2020-04-08T19:11:52Z
system:kube-dns                                                        2020-04-08T19:11:52Z
system:kube-scheduler                                                  2020-04-08T19:11:52Z
system:kubelet-api-admin                                               2020-04-08T19:11:52Z
system:node                                                            2020-04-08T19:11:52Z
system:node-bootstrapper                                               2020-04-08T19:11:52Z
system:node-problem-detector                                           2020-04-08T19:11:52Z
system:node-proxier                                                    2020-04-08T19:11:52Z
system:persistent-volume-provisioner                                   2020-04-08T19:11:52Z
system:public-info-viewer                                              2020-04-08T19:11:52Z
system:volume-scheduler                                                2020-04-08T19:11:52Z
view                                                                   2020-04-08T19:11:52Z
weave-net                                                              2020-04-08T22:01:03Z
vagrant@master-1:~/pki$ kubectl get clusterroles |wc -l
59
vagrant@master-1:~/pki$ 


vagrant@master-1:~/pki$ kubectl get clusterroles system:kube-apiserver-to-kubelet -o yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  annotations:
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"rbac.authorization.k8s.io/v1beta1","kind":"ClusterRole","metadata":{"annotations":{"rbac.authorization.kubernetes.io/autoupdate":"true"},"labels":{"kubernetes.io/bootstrapping":"rbac-defaults"},"name":"system:kube-apiserver-to-kubelet"},"rules":[{"apiGroups":[""],"resources":["nodes/proxy","nodes/stats","nodes/log","nodes/spec","nodes/metrics"],"verbs":["*"]}]}
    rbac.authorization.kubernetes.io/autoupdate: "true"
  creationTimestamp: "2020-04-09T02:05:03Z"
  labels:
    kubernetes.io/bootstrapping: rbac-defaults
  name: system:kube-apiserver-to-kubelet
  resourceVersion: "77185"
  selfLink: /apis/rbac.authorization.k8s.io/v1/clusterroles/system%3Akube-apiserver-to-kubelet
  uid: 074717d6-f617-4d9d-8e14-80bc1b91669d
rules:
- apiGroups:
  - ""
  resources:
  - nodes/proxy
  - nodes/stats
  - nodes/log
  - nodes/spec
  - nodes/metrics
  verbs:
  - '*'
vagrant@master-1:~/pki$ 

```



<br>

## Deploying the DNS Cluster Add-on

### The DNS Cluster Add-on

Deploy the `coredns` cluster add-on:

```bash
kubectl apply -f https://raw.githubusercontent.com/mmumshad/kubernetes-the-hard-way/master/deployments/coredns.yaml
```



```bash
kubectl apply -f https://raw.githubusercontent.com/arif332/kubernetes-the-hard-way/master/deployments/coredns1.6.9.yaml
```





### `Logs`

```bash
vagrant@master-1:~/pki$ kubectl apply -f https://raw.githubusercontent.com/mmumshad/kubernetes-the-hard-way/master/deployments/coredns.yaml
serviceaccount/coredns created
clusterrole.rbac.authorization.k8s.io/system:coredns created
clusterrolebinding.rbac.authorization.k8s.io/system:coredns created
configmap/coredns created
service/kube-dns created
error: unable to recognize "https://raw.githubusercontent.com/mmumshad/kubernetes-the-hard-way/master/deployments/coredns.yaml": no matches for kind "Deployment" in version "extensions/v1beta1"
vagrant@master-1:~/pki$ 


vagrant@master-1:~/pki$ kubectl apply -f https://raw.githubusercontent.com/arif332/kubernetes-the-hard-way/master/deployments/coredns1.6.9.yaml
serviceaccount/coredns unchanged
clusterrole.rbac.authorization.k8s.io/system:coredns unchanged
clusterrolebinding.rbac.authorization.k8s.io/system:coredns unchanged
configmap/coredns unchanged
deployment.apps/coredns created
service/kube-dns unchanged
vagrant@master-1:~/pki$ 


```



### Logs After deployment 

```bash
vagrant@master-1:~/pki$ kubectl get pods   -A
NAMESPACE     NAME                       READY   STATUS             RESTARTS   AGE
kube-system   coredns-845dd55d87-l4kfh   0/1     CrashLoopBackOff   11         34m
kube-system   coredns-845dd55d87-q7mh6   0/1     CrashLoopBackOff   11         34m
kube-system   weave-net-7vkms            2/2     Running            0          10h
kube-system   weave-net-w7txv            2/2     Running            0          10h
vagrant@master-1:~/pki$ 


kubectl describe -n kube-system pod coredns-845dd55d87-l4kfh

Events:
  Type     Reason     Age                  From               Message
  ----     ------     ----                 ----               -------
  Normal   Scheduled  35m                  default-scheduler  Successfully assigned kube-system/coredns-845dd55d87-l4kfh to worker-2
  Normal   Pulling    35m                  kubelet, worker-2  Pulling image "coredns/coredns:1.6.9"
  Normal   Pulled     35m                  kubelet, worker-2  Successfully pulled image "coredns/coredns:1.6.9"
  Normal   Created    34m (x4 over 35m)    kubelet, worker-2  Created container coredns
  Normal   Started    34m (x4 over 35m)    kubelet, worker-2  Started container coredns
  Normal   Pulled     33m (x4 over 35m)    kubelet, worker-2  Container image "coredns/coredns:1.6.9" already present on machine
  Warning  BackOff    18s (x172 over 35m)  kubelet, worker-2  Back-off restarting failed container
....



vagrant@master-1:~/pki$ kubectl get csr --all-namespaces
NAME        AGE     SIGNERNAME                      REQUESTOR              CONDITION
csr-27jwz   3h12m   kubernetes.io/kubelet-serving   system:node:worker-2   Pending
csr-27nn6   9h      kubernetes.io/kubelet-serving   system:node:worker-2   Pending
csr-2ckvg   6h18m   kubernetes.io/kubelet-serving   system:node:worker-2   Pending
csr-47kxt   4h30m   kubernetes.io/kubelet-serving   system:node:worker-2   Pending
csr-4brhb   131m    kubernetes.io/kubelet-serving   system:node:worker-2   Pending
csr-4s7sq   10h     kubernetes.io/kubelet-serving   system:node:worker-2   Pending
csr-8ksbs   10h     kubernetes.io/kubelet-serving   system:node:worker-2   Pending
csr-9jcr7   11h     kubernetes.io/kubelet-serving   system:node:worker-2   Pending
csr-9nlw8   10h     kubernetes.io/kubelet-serving   system:node:worker-2   Pending
csr-9p27j   8h      kubernetes.io/kubelet-serving   system:node:worker-2   Pending
csr-b7h9f   10h     kubernetes.io/kubelet-serving   system:node:worker-2   Pending
csr-btwj5   7h4m    kubernetes.io/kubelet-serving   system:node:worker-2   Pending
....


vagrant@master-1:~/pki$  kubectl describe csr system:node:worker-2
Error from server (NotFound): certificatesigningrequests.certificates.k8s.io "system:node:worker-2" not found
vagrant@master-1:~/pki$ 


vagrant@master-1:~/pki$ kubectl describe csr csr-xz4t7
Name:               csr-xz4t7
Labels:             <none>
Annotations:        <none>
CreationTimestamp:  Thu, 09 Apr 2020 01:13:24 +0000
Requesting User:    system:node:worker-2
Status:             Pending
Subject:
  Common Name:    system:node:worker-2
  Serial Number:  
  Organization:   system:nodes
Subject Alternative Names:
         DNS Names:     worker-2
         IP Addresses:  192.168.57.22
Events:  <none>
vagrant@master-1:~/pki$ 

$ kubectl certificate approve csr-rzsrd



```



### Error Logs while starting coredns

```bash
$ kubectl describe pods weave-net-7vkms -n kube-system


$ journalctl -xeu kubelet


vagrant@master-1:~/pki$ kubectl get pods -A -o wide
NAMESPACE     NAME                       READY   STATUS             RESTARTS   AGE    IP              NODE       NOMINATED NODE   READINESS GATES
kube-system   coredns-845dd55d87-69wrf   0/1     CrashLoopBackOff   10         27m    10.44.0.2       worker-1   <none>           <none>
kube-system   coredns-845dd55d87-q7mh6   0/1     CrashLoopBackOff   42         173m   10.44.0.1       worker-1   <none>           <none>
kube-system   weave-net-7vkms            2/2     Running            2          13h    192.168.57.22   worker-2   <none>           <none>
kube-system   weave-net-w7txv            2/2     Running            0          13h    192.168.57.21   worker-1   <none>           <none>
vagrant@master-1:~/pki$ kubectl logs coredns-845dd55d87-69wrf -n kube-system
/etc/coredns/Corefile:10 - Error during parsing: Unknown directive 'proxy'
vagrant@master-1:~/pki$ 




```



### Solution of core-dns start issue

```bash
vagrant@master-1:~/pki$ kubectl get pods -A -o wide
NAMESPACE     NAME                       READY   STATUS             RESTARTS   AGE    IP              NODE       NOMINATED NODE   READINESS GATES
kube-system   coredns-845dd55d87-69wrf   0/1     CrashLoopBackOff   10         27m    10.44.0.2       worker-1   <none>           <none>
kube-system   coredns-845dd55d87-q7mh6   0/1     CrashLoopBackOff   42         173m   10.44.0.1       worker-1   <none>           <none>
kube-system   weave-net-7vkms            2/2     Running            2          13h    192.168.57.22   worker-2   <none>           <none>
kube-system   weave-net-w7txv            2/2     Running            0          13h    192.168.57.21   worker-1   <none>           <none>
vagrant@master-1:~/pki$


vagrant@master-1:~/pki$ kubectl logs coredns-845dd55d87-69wrf -n kube-system
/etc/coredns/Corefile:10 - Error during parsing: Unknown directive 'proxy'
vagrant@master-1:~/pki$


-- modify proxy to forward 
-- details available https://raw.githubusercontent.com/arif332/kubernetes-the-hard-way/master/deployments/coredns1.6.9.yaml


vagrant@master-1:~/pki$ kubectl apply -f https://raw.githubusercontent.com/arif332/kubernetes-the-hard-way/master/deployments/coredns1.6.9.yaml
serviceaccount/coredns unchanged
clusterrole.rbac.authorization.k8s.io/system:coredns unchanged
clusterrolebinding.rbac.authorization.k8s.io/system:coredns unchanged
configmap/coredns configured
deployment.apps/coredns unchanged
service/kube-dns unchanged
vagrant@master-1:~/pki$



vagrant@master-1:~/pki$ kubectl get pods -A -o wide
NAMESPACE     NAME                       READY   STATUS    RESTARTS   AGE    IP              NODE       NOMINATED NODE   READINESS GATES
kube-system   coredns-845dd55d87-69wrf   1/1     Running   12         40m    10.44.0.2       worker-1   <none>           <none>
kube-system   coredns-845dd55d87-q7mh6   1/1     Running   45         3h7m   10.44.0.1       worker-1   <none>           <none>
kube-system   weave-net-7vkms            2/2     Running   2          13h    192.168.57.22   worker-2   <none>           <none>
kube-system   weave-net-w7txv            2/2     Running   0          13h    192.168.57.21   worker-1   <none>           <none>
vagrant@master-1:~/pki$ 


vagrant@master-1:~/pki$ kubectl get pods -l k8s-app=kube-dns -n kube-system
NAME                       READY   STATUS    RESTARTS   AGE
coredns-845dd55d87-69wrf   1/1     Running   12         43m
coredns-845dd55d87-q7mh6   1/1     Running   45         3h10m
vagrant@master-1:~/pki$ 


```





### Verification by creating a new pods

```bash
kubectl run --generator=run-pod/v1  busybox --image=busybox:1.28 --command -- sleep 3600

vagrant@master-1:~/pki$ kubectl get pods -A -o wide
NAMESPACE     NAME                       READY   STATUS    RESTARTS   AGE     IP              NODE       NOMINATED NODE   READINESS GATES
default       busybox                    1/1     Running   0          8s      10.32.0.2       worker-2   <none>           <none>
kube-system   coredns-845dd55d87-69wrf   1/1     Running   12         46m     10.44.0.2       worker-1   <none>           <none>
kube-system   coredns-845dd55d87-q7mh6   1/1     Running   45         3h13m   10.44.0.1       worker-1   <none>           <none>
kube-system   weave-net-7vkms            2/2     Running   2          13h     192.168.57.22   worker-2   <none>           <none>
kube-system   weave-net-w7txv            2/2     Running   0          13h     192.168.57.21   worker-1   <none>           <none>
vagrant@master-1:~/pki$ 

vagrant@master-1:~/pki$ kubectl get pods -l run=busybox
NAME      READY   STATUS    RESTARTS   AGE
busybox   1/1     Running   0          90s
vagrant@master-1:~/pki$ kubectl exec -ti busybox -- nslookup kubernetes
Server:    10.96.0.10
Address 1: 10.96.0.10 kube-dns.kube-system.svc.cluster.local

Name:      kubernetes
Address 1: 10.96.0.1 kubernetes.default.svc.cluster.local
vagrant@master-1:~/pki$ 


```





## Smoke Test

### Data Encryption

Create a generic secret:

```bash
kubectl create secret generic kubernetes-the-hard-way \
  --from-literal="mykey=mydata"
```

Print a hexdump of the `kubernetes-the-hard-way` secret stored in etcd:

```
sudo ETCDCTL_API=3 etcdctl get \
  --endpoints=https://127.0.0.1:2379 \
  --cacert=/etc/etcd/ca.crt \
  --cert=/etc/etcd/etcd-server.crt \
  --key=/etc/etcd/etcd-server.key\
  /registry/secrets/default/kubernetes-the-hard-way | hexdump -C
```



cleanup

```bash
kubectl delete secret kubernetes-the-hard-way
```





### Deployments

Create a deployment for the [nginx](https://nginx.org/en/) web server:

```
kubectl create deployment nginx --image=nginx
kubectl get pods -l app=nginx

```

### Services

In this section you will verify the ability to access applications remotely using [port forwarding](https://kubernetes.io/docs/tasks/access-application-cluster/port-forward-access-application-cluster/).

Create a service to expose deployment nginx on node ports.

```
kubectl expose deploy nginx --type=NodePort --port 80

PORT_NUMBER=$(kubectl get svc -l app=nginx -o jsonpath="{.items[0].spec.ports[0].nodePort}")
```



Test to view NGINX page

```
curl http://worker-1:$PORT_NUMBER
curl http://worker-2:$PORT_NUMBER
```



### Logs

Retrieve the full name of the `nginx` pod:

```bash
POD_NAME=$(kubectl get pods -l app=nginx -o jsonpath="{.items[0].metadata.name}")

vagrant@master-1:~/pki$ kubectl get pods -A
NAMESPACE     NAME                       READY   STATUS    RESTARTS   AGE
default       busybox                    1/1     Running   0          11m
default       nginx-86c57db685-psmx9     1/1     Running   0          4m39s
kube-system   coredns-845dd55d87-69wrf   1/1     Running   12         57m
kube-system   coredns-845dd55d87-q7mh6   1/1     Running   45         3h24m
kube-system   weave-net-7vkms            2/2     Running   2          13h
kube-system   weave-net-w7txv            2/2     Running   0          13h
vagrant@master-1:~/pki$ kubectl logs nginx-86c57db685-psmx9
10.44.0.0 - - [09/Apr/2020:11:41:41 +0000] "GET / HTTP/1.1" 200 612 "-" "curl/7.58.0" "-"
10.32.0.1 - - [09/Apr/2020:11:41:46 +0000] "GET / HTTP/1.1" 200 612 "-" "curl/7.58.0" "-"
vagrant@master-1:~/pki$ 

```



### Exec

Print the nginx version by executing the `nginx -v` command in the `nginx` container:

```bash
kubectl exec -ti $POD_NAME -- nginx -v

vagrant@master-1:~/pki$ kubectl exec -ti $POD_NAME -- nginx -v
nginx version: nginx/1.17.9
vagrant@master-1:~/pki$


vagrant@master-1:~/pki$ kubectl exec -ti nginx-86c57db685-psmx9 -- nginx -v
nginx version: nginx/1.17.9
vagrant@master-1:~/pki$ 

```





## Run End-to-End Tests

Install Go

```
wget https://dl.google.com/go/go1.12.1.linux-amd64.tar.gz

sudo tar -C /usr/local -xzf go1.12.1.linux-amd64.tar.gz
export GOPATH="/home/vagrant/go"
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin
```



```bash
kubetest --extract=v1.17.4

cd kubernetes
export KUBE_MASTER_IP="192.168.57.11:6443"
export KUBE_MASTER=master-1

kubetest --test --provider=skeleton --test_args="--ginkgo.focus=\[Conformance\]" | tee test.out
```

<br>





## Software Upgrade

Worker node upgrade

```bash
#offload worker node
kubectl uncordon worker-1

#check latest stable software
curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt

#download latest software
{
kubeversion=`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`
wget -q --show-progress --https-only --timestamping \
  https://storage.googleapis.com/kubernetes-release/release/${kubeversion}/bin/linux/amd64/kubectl \
  https://storage.googleapis.com/kubernetes-release/release/${kubeversion}/bin/linux/amd64/kube-proxy \
  https://storage.googleapis.com/kubernetes-release/release/${kubeversion}/bin/linux/amd64/kubelet
}

#stop application
sudo systemctl stop kubelet kube-proxy

#install software
{
  chmod +x kubectl kube-proxy kubelet
  sudo mv kubectl kube-proxy kubelet /usr/local/bin/
}

#start sofware
{
  sudo systemctl daemon-reload
  sudo systemctl enable kubelet kube-proxy
  sudo systemctl start kubelet kube-proxy
}

```



#### Upgrade verification for worker node

```bash
kubectl get nodes -A
```







<br>

### Upgrade Kuberneties Control Plane

```bash

#offload master node

#check latest stable software
curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt

#download software
{
kubeversion=`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`
wget -q --show-progress --https-only --timestamping \
  "https://storage.googleapis.com/kubernetes-release/release/${kubeversion}/bin/linux/amd64/kube-apiserver" \
  "https://storage.googleapis.com/kubernetes-release/release/${kubeversion}/bin/linux/amd64/kube-controller-manager" \
  "https://storage.googleapis.com/kubernetes-release/release/${kubeversion}/bin/linux/amd64/kube-scheduler" \
  "https://storage.googleapis.com/kubernetes-release/release/${kubeversion}/bin/linux/amd64/kubectl"
}

#Install software
{
  chmod +x kube-apiserver kube-controller-manager kube-scheduler kubectl
  sudo mv kube-apiserver kube-controller-manager kube-scheduler kubectl /usr/local/bin/
}

#Stop Application
{
  sudo systemctl stop kube-apiserver kube-controller-manager kube-scheduler
}

#Start Application
{
  #sudo systemctl daemon-reload
  sudo systemctl start kube-apiserver kube-controller-manager kube-scheduler
  #sudo systemctl status kube-apiserver kube-controller-manager kube-scheduler
}

```

#### Control plane upgrade verification

```bash
kubectl get componentstatuses --kubeconfig admin.kubeconfig
curl  https://192.168.57.13:6443/version -k
```



<br>

### Upgrade ETCD DB



```bash
ETCD_VER=v3.4.7
# choose either URL
GOOGLE_URL=https://storage.googleapis.com/etcd
GITHUB_URL=https://github.com/etcd-io/etcd/releases/download
DOWNLOAD_URL=${GOOGLE_URL}

curl -L ${DOWNLOAD_URL}/${ETCD_VER}/etcd-${ETCD_VER}-linux-amd64.tar.gz -o ~/etcd-${ETCD_VER}-linux-amd64.tar.gz

#install software
{
  tar -xf etcd-${ETCD_VER}-linux-amd64.tar.gz
  sudo mv etcd-${ETCD_VER}-linux-amd64/etcd* /usr/local/bin/
}

#check software version
{
/usr/local/bin/etcd --version
/usr/local/bin/etcdctl version
}

{
  sudo systemctl status etcd
  sudo systemctl stop etcd
}

{
  #sudo systemctl daemon-reload
  sudo systemctl enable etcd
}
```



#### ETCD upgrade verification

```bash
#master node

export etcdargs="--endpoints=https://127.0.0.1:2379   --cacert=/etc/etcd/ca.crt   --cert=/etc/etcd/etcd-server.crt   --key=/etc/etcd/etcd-server.key"
{
sudo ETCDCTL_API=3 etcdctl endpoint status --cluster -w table $etcdargs
sudo ETCDCTL_API=3 etcdctl endpoint health --cluster $etcdargs
}

{
sudo ETCDCTL_API=3 etcdctl endpoint status --cluster -w table $etcdargs
sudo ETCDCTL_API=3 etcdctl endpoint health --cluster -w table $etcdargs
}
```





### Upgrade CNI

```bash

```



### Upgrade Wave network

```bash

```



### Upgrade Coredns

```bash

```







## References

1. https://github.com/arif332/kubernetes-the-hard-way

2. https://github.com/mmumshad/kubernetes-the-hard-way

   



## Verfication



```bash
vagrant@master-1:~/pki$ sudo ETCDCTL_API=3 etcdctl endpoint status   --endpoints=https://127.0.0.1:2379   --cacert=/etc/etcd/ca.crt   --cert=/etc/etcd/etcd-server.crt   --key=/etc/etcd/etcd-server.key
https://127.0.0.1:2379, 4357819c96acc3ce, 3.4.7, 20 kB, true, false, 238, 17, 17, 


vagrant@master-1:~/pki$ sudo ETCDCTL_API=3 etcdctl endpoint health  --endpoints=https://127.0.0.1:2379   --cacert=/etc/etcd/ca.crt   --cert=/etc/etcd/etcd-server.crt   --key=/etc/etcd/etcd-server.key
https://127.0.0.1:2379 is healthy: successfully committed proposal: took = 20.541745ms
vagrant@master-1:~/pki$ 

export etcdargs="--endpoints=https://127.0.0.1:2379   --cacert=/etc/etcd/ca.crt   --cert=/etc/etcd/etcd-server.crt   --key=/etc/etcd/etcd-server.key"


sudo ETCDCTL_API=3 etcdctl member list $etcdargs

vagrant@master-1:~/pki$ sudo ETCDCTL_API=3 etcdctl check perf $etcdargs
 60 / 60 Booooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo! 100.00% 1m0s
PASS: Throughput is 148 writes/s
PASS: Slowest request took 0.090868s
PASS: Stddev is 0.006437s
PASS
vagrant@master-1:~/pki$ 

vagrant@master-2:~$ sudo ETCDCTL_API=3 etcdctl member list --write-out table $etcdargs
+------------------+---------+----------+----------------------------+----------------------------+------------+
|        ID        | STATUS  |   NAME   |         PEER ADDRS         |        CLIENT ADDRS        | IS LEARNER |
+------------------+---------+----------+----------------------------+----------------------------+------------+
| 4357819c96acc3ce | started | master-1 | https://192.168.57.11:2380 | https://192.168.57.11:2379 |      false |
| 5140aead4f7edcf3 | started | master-3 | https://192.168.57.13:2380 | https://192.168.57.13:2379 |      false |
| ab0f9bf91eb36640 | started | master-2 | https://192.168.57.12:2380 | https://192.168.57.12:2379 |      false |
+------------------+---------+----------+----------------------------+----------------------------+------------+
vagrant@master-2:~$ 

export etcdargs="--endpoints=https://127.0.0.1:2379   --cacert=/etc/etcd/ca.crt   --cert=/etc/etcd/etcd-server.crt   --key=/etc/etcd/etcd-server.key"

sudo ETCDCTL_API=3 etcdctl endpoint status --write-out=table table $etcdargs
sudo ETCDCTL_API=3 etcdctl endpoint status table $etcdargs

{
sudo ETCDCTL_API=3 etcdctl member list -w table $etcdargs
sudo ETCDCTL_API=3 etcdctl endpoint status -w table $etcdargs
#sudo ETCDCTL_API=3 etcdctl endpoint health -w table $etcdargs
sudo ETCDCTL_API=3 etcdctl endpoint health --cluster $etcdargs
#sudo ETCDCTL_API=3 etcdctl endpoint health --cluster -w table $etcdargs
}

export etcdargs="--endpoints=https://127.0.0.1:2379   --cacert=/etc/etcd/ca.crt   --cert=/etc/etcd/etcd-server.crt   --key=/etc/etcd/etcd-server.key"
{
sudo ETCDCTL_API=3 etcdctl endpoint status --cluster -w table $etcdargs
sudo ETCDCTL_API=3 etcdctl endpoint health --cluster $etcdargs
}

https://github.com/etcd-io/etcd/blob/master/Documentation/integrations.md
https://github.com/etcd-io/etcd/blob/master/Documentation/learning/design-learner.md


sudo ETCDCTL_API=3 etcdctl lease grant 60  $etcdargs
sudo ETCDCTL_API=3 etcdctl lease list  $etcdargs

```















## Appendix



[Vagrant Infrastruture Provision Logs](kubernetes_install_hard_way/appendix_vagrant_start_infra.md)







