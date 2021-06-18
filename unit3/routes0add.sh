#!/bin/sh

ip route add 65.243.227.208/30 via 10.1.1.2 
ip route add 97.93.105.220/30 via 10.1.1.2
ip route add 70.22.128.0/18 dev enp0s8
ip route add 28.104.128.0/19 via 10.1.1.2
ip route add 69.83.145.0/24 via 10.1.1.2
ip route add 26.40.32.0/19 via 10.1.1.2

