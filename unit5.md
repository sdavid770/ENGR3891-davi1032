# Unit 5 : Basic Firewall Task
## Setup

For this Scenario, both virutal machines are connected to the host computer network via a NAT and internal netowrk called Sean's Network.Each virtual machine has been assigned a unique MAC Address.

## Ip Configuration
To get the two machines communicatiing with each other, both of them need to be assigned an IP address. As the two machines have been connected to a NAt network, they have already been assigned via DHCP of 10.1.1.1/24 and 10.1.1.2/24. Both of which are using enp0s8 as their internal network interface

If the Network is based on Static Ip allocation, the commands below will assign the correct ipaddress to each VM.

```bash
# Machine 1
sudo ip link set dev enp0s8 up
sudo ip addr add 10.1.1.1/24 dev enp0s8
```

```bash
# Machine 2
sudo ip link set dev enp0s8 up
sudo ip addr add 10.1.1.1/24 dev enp0s8
```

**Pinging** is now possible between the two machnies, provided that both interfaces and address are set up properly.

```bash
Using ping 10.1.1.1 and ping 10.1.1.2 commands should now work for both machines. **Note** ping 10.1.1.2 is used for Machine 1 and 10.1.1.1 is used for Machine 2.
```

##Firewall Setup 
Now that both machines can communicate, we can build a basic Firewall Setup using iptables.

Firstly, we install the iptables using `sudo apt install iptables` (If you have version Ubuntu 18.04, it is already built into the system).

Once completed, we will now drop all traffic from both machines in both directions.

```bash
# Machine 1 and 2
sudo iptables--policy INPUT DROP
sudo iptables--policy OUTPUT DROP
sudo iptables--policy FORWARD DROP
```
The command below to boh machines will allow for it to open connections to others machines on the network and have them talk back.
```bash
# Both machines
sudo iptables -A OUTPUT -p tcp -m state --state NEW,ESTABLISHED -j ACCEPT
sudo iptables -A INPUT -p tcp -m state --state ESTABLISHED -j ACCEPT
```
Since neither machine is accepting connections, adding the rule bellow to machine 2 will allow a new SSH connection.# Machine 2
```bash
sudo iptables -I INPUT 1 -p tcp --dport 22 -m state --state NEW -j ACCEPT
```
