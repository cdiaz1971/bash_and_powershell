#!/bin/bash
sudo nmap -T4 -A -v4 -oN /mnt/hgfs/Shared/results-nmap/$1.txt  $1

#xsltproc /home/cdiaz/scripts/nmap/$1.xml -o /home/cdiaz/scripts/results-nmap/$1.html
