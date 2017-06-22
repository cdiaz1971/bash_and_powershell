
$listofIPs = Get-Content "c:\scripts\IPList.txt"
#$listofIPs = ""

$ResultList = @()

foreach ($ip in $listofIPs)
{
$result = $null
$currentEAP = $ErrorActionPreference
$ErrorActionPreference = "silentlycontinue"


$result = [System.Net.Dns]::gethostentry("$ip")

$ErrorActionPreference = $currentEAP

$result

If ($Result)
{
$Resultlist += $IP + "," + [string]$Result.HostName
}
Else
{
$Resultlist += $IP + " , No HostNameFound"
}
}



$Resultlist | Out-File "c:\scripts\output.txt"

