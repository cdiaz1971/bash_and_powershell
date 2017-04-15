###Author: Cesar Diaz
### This script read a list of computers from c:\scripts\adcomputers.txt
### and writes the computer's uptime to an HTML file
### if the computer does not respond it writes the computer name to a text file


Function UPTimeReport { 
$Prop = [ordered]@{} 
$ComputerName = [System.IO.File]::ReadAllLines("c:\scripts\adcomputers.txt") 
$ErrorActionPreference = "Stop" 
foreach ($computer in $ComputerName)  
  {  
   
Try { 
write-host $computer
$GWMIC = Get-EventLog -log System -cn $computer 
$Prop.Computername = GWMI win32_operatingsystem -cn $computer | Select-object -ExpandProperty CSName  
$Prop.LastRebootTime =  $GWMIC | ? EventID -EQ 12 | Select-Object -ExpandProperty TimeGenerated -First 1  
$Prop.Reason =  $GWMIC | ? EventID -EQ 12 | Select-Object -ExpandProperty Message -First 1 
write-host $computer
New-Object PSObject -property $Prop  
  }   
 
  Catch 
  { 
   Add-Content "$computer is not reachable" -path c:\scripts\UnreachableHosts.txt 

  } 
 } 
} 

$a = "<!--mce:0-->" 
UPTimeReport | ConvertTo-HTML -head $a -body "<H2> UPTime Report</H2>" |  

Out-File c:\scripts\uptime.htm #HTML Output 
Invoke-Item c:\scripts\uptime.htm