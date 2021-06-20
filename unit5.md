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


Using ping 10.1.1.1 and ping 10.1.1.2 commands should now work for both machines. **Note** ping 10.1.1.2 is used for Machine 1 and 10.1.1.1 is used for Machine 2.

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
Since neither machine is accepting connections, adding the rule bellow to machine 2 will allow a new SSH connection.
```bash
# Machine 2
sudo iptables -I INPUT 1 -p tcp --dport 22 -m state --state NEW -j ACCEPT
```
Once all the rules have been set, a quick test using the commands below will check if the rules implemeneted above are in working order.
```bash
sudo nc -l 22
ssh 10.1.1.2.
```

SSH is now able to go through From Machine 1 to the @nd Machine. However, It will not work the other way round because Machine 1 is not set up to receive incoming connections.


#Task 2 - Port Redirection.
TO SSH port 22 ON machine 1 to the external 12345 port, we need to utilize a port redirection rule. Using the rule below will help accomplish this.
```bash
sudo iptables -t nat -A PREROUTING -i enp0s8 -p tcp --dport 12345 -j REDIRECT --to-port 22
```
Then add the secodn rule below.
```bash
sudo iptables -I INPUT 1 -p tcp --dport 22 -m state --state NEW -j ACCEPT
```

A quick thest using

```bash
sudo nc -l 22
ssh 10.1.1.2.
```

WIll show a succesful message saying "Welcome to Ubuntu 18.04.5 LTS (GNU/Linux 5.4.0-74-generic x86_64)"

