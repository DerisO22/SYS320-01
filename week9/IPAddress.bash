#!bin/bash
ip addr | grep "inet " | grep -v -E "127.0.0.1|127.0.17.255" | cut -d' ' -f6 | cut -d"/" -f1
