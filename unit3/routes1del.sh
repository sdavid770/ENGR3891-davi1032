#!/bin/sh

ip route del 33.189.0.0/17 via 10.1.1.2
ip route del 41.153.148.160/28 dev enp0s8
ip route del 69.33.228.244/31 dev enp0s8
ip route del 66.136.213.64/26 dev enp0s8
ip route del 35.230.63.0/25 via 10.1.1.2
ip route del 75.185.6.0/23 via 10.1.1.2
