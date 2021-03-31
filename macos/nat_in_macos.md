## Enable NAT in macOS



## Document History

```
Document History:
2020-03-20	V1 Arif "Transparent nat service for virtualbox ip address in macos"
2021-03-31  V2 Arif "Added prerequisite condition"
```



## Introduction

VirtualBox based VMs need internet access transparently. So need a NAT service in host macOS. **pfctl** is used to enable NAT configuration. 

#### Prerequisite:

`Enable` firewall from Apple menu > System Preferences > Security & Privacy > Firewall section.

 

#### Final Procedure:

Check current forwarding rule option (1=forwaring enable, 0=forwarding disable). 

```bash
sysctl net.inet.ip.forwarding 
```



If forwarding is not enable then enable using below command. System restart will reset value to 0.

```bash
sudo sysctl -w net.inet.ip.forwarding=1
```



Enable nat rule using pfctl -

```bash
#check nat status
sudo pfctl -s nat

# Find the laptop's internet interface by ifconfig command which is connected to internet and \
# also check interface IP address. for my case interface is en0 which is connected to internet
# schematic view: virtual box network (192.168.56.0/24) > mac laptop internet interface (en0) > internet router 

vi /etc/pf.conf
nat on en0 from 192.168.56.0/24 to any -> (en0)
#nat on en0 from vboxnet0:network to any -> (en0)

Check pf.conf for error first
sudo pfctl -nf /etc/pf.conf

If no error, deploy new rules without reboot
sudo pfctl -f /etc/pf.conf

#verify nat connection
sudo pfctl -sn
sudo pfctl -s state
sudo pfctl -s info
```



## References

1. http://artemisa.unicauca.edu.co/~mtrujillo/OpenBSD/pf/nat.html
2. https://www.openbsd.org/faq/pf/nat.html
3. https://www.openbsdhandbook.com/pf/cheat_sheet/
4. https://home.nuug.no/~peter/pf/en/basicgw.html
5. https://ral.ucar.edu/~tor/sadocs/tcpip/nat.html
6. https://apple.stackexchange.com/questions/363099/how-to-forward-traffic-from-one-machine-to-another-with-pfctl
7. https://superuser.com/questions/539644/how-to-remove-port-forwarding-rule-on-mac

