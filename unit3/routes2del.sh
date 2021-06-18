#!/bin/sh

ip route del 123.241.156.0/22 via 10.1.1.2
ip route del 18.227.253.172/30 via 10.1.1.2
ip route del 106.30.224.0/19 dev enp0s8
ip route del 85.186.128.160/27 dev enp0s8
ip route del 77.60.0.0/19 via 10.1.1.2
ip route del 94.184.64.0/23 dev enp0s8
