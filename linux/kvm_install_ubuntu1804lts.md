# KVM Install & Integration



## Document History

```
Author: Arif
Document History:
2019-09-25	V1 Install virtualization manager in ubuntu 18.4lts

```



## Introduction

**KVM** (kernel-based Virtual Machine) is a full virtualization solutions for x86 hardware with virtualization extensions (Inter VT or AMD-V). it's provide a loadable kernel module kernel.ko. It is an open source software. 

Userspace componet of KVM is **QEMU** which is a generic and open source machine emulator and virtualizer. 

Multiple virtual machine can be run using KVM where individual machine have private virtualized hardware: cpu, a network card, disk, graphics adapter etc.

 **Virt-manager** application provides a desktop user interface for managing virtual machines throguh libvirt. 



## KVM, QEMU, Virt-manager & libvirt-bin Installation in Linux



#### Check CPU setting

```bash
egrep -c '(svm|vmx)' /proc/cpuinfo
arif@ariflindesk1:/$ egrep -c '(svm|vmx)' /proc/cpuinfo
12

sudo apt install cpu-checker
arif@ariflindesk1:/$ sudo kvm-ok
INFO: /dev/kvm exists
KVM acceleration can be used
arif@ariflindesk1:/$ 
```

#### Install KVM and related Software

```bash
sudo apt-get install qemu-kvm libvirt-bin bridge-utils virt-manager

virt-manager (GUI utility)
virt-install command (cli utility)
```

Check process status:

```bash
systemctl status libvirtd
```



#### Add user to libvirt group

```bash
arif@ariflindesk1:/$ grep libvirt /etc/group
libvirt:x:132:arif
libvirt-qemu:x:64055:libvirt-qemu
libvirt-dnsmasq:x:133:
arif@ariflindesk1:/$ 

sudo adduser [username] libvirt
```



#### Check virtual machine list

```bash
sudo virsh -c qemu:///system list
sudo virsh list --all
```



#### Change default image location - /var/lib/libvirt/images 

```bash
arif@ariflindesk1:/ext/wdc512/LinuxContent/kvmRepos$ sudo virsh pool-dumpxml default
<pool type='dir'>
  <name>default</name>
  <uuid>4f0bcc7f-a552-40b8-8b79-ba1050b57332</uuid>
  <capacity unit='bytes'>102406119424</capacity>
  <allocation unit='bytes'>48340934656</allocation>
  <available unit='bytes'>54065184768</available>
  <source>
  </source>
  <target>
    <path>/var/lib/libvirt/images</path>
    <permissions>
      <mode>0711</mode>
      <owner>0</owner>
      <group>0</group>
    </permissions>
  </target>
</pool>

sudo virsh pool-destroy default
sudo virsh pool-create pool.xml
```

#### Creating custom network

```bash
sudo vi /etc/netplan/50-cloud-init.yaml
  bridges:
    br0:
      interfaces: [ens33]
      dhcp4: no
      addresses: [192.168.0.51/24]
      gateway4: 192.168.0.1
      nameservers:
        addresses: [192.168.0.1]
```



#### Check default network

```bash
sudo virsh net-list --all
sudo virsh net-dumpxml default
sudo virsh net-start default

arif@ariflindesk1:/ext/wdc512/LinuxContent/kvmRepos$ sudo virsh net-dumpxml default
<network>
  <name>default</name>
  <uuid>6a14b33e-8834-47fa-94b8-cbd51ac6a64c</uuid>
  <forward mode='nat'>
    <nat>
      <port start='1024' end='65535'/>
    </nat>
  </forward>
  <bridge name='virbr0' stp='on' delay='0'/>
  <mac address='52:54:00:ea:19:eb'/>
  <ip address='192.168.122.1' netmask='255.255.255.0'>
    <dhcp>
      <range start='192.168.122.2' end='192.168.122.254'/>
    </dhcp>
  </ip>
</network>

arif@ariflindesk1:/ext/wdc512/LinuxContent/kvmRepos$ ip a s|grep vir
163: virbr0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default qlen 1000
    inet 192.168.122.1/24 brd 192.168.122.255 scope global virbr0
164: virbr0-nic: <BROADCAST,MULTICAST> mtu 1500 qdisc fq_codel master virbr0 state DOWN group default qlen 1000

```



### Launch Virt-mager

In cli type `virt-manager`to lunch management gui for creating a new VMs. 





## References

* https://www.linux-kvm.org/page/Main_Page
* https://virt-manager.org/
* https://www.qemu.org/

#### 