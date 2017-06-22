#!/bin/bash
sudo nmap -F -oN /mnt/hgfs/Shared/results-nmap/$1.fast.txt $1
