#!/bin/bash
sudo nmap -Pn -oN /mnt/hgfs/Shared/results-nmap/$1.noping.txt  $1
#xsltproc /home/cdiaz/Shared/$1.xml -o /home/cdiaz/Shared/$1.html
