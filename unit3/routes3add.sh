#!/bin/sh

ip route add 108.178.215.128/26 via 10.1.1.2
ip route add 52.99.0.0/16 via 10.1.1.2
ip route add 22.49.189.84/30 dev enp0s8
ip route add 115.103.97.204/30 dev enp0s8
ip route add 73.33.226.128/25 dev enp0s8
ip route add 85.38.41.0/24 via 10.1.1.2
