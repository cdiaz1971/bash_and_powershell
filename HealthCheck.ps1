## This scripts check the server Avrg CPU and Memory utlization along with C drive 
## disk utilization and sends an email to the receipents included in the script
################################################################################ 

$ServerListFile = "C:\ServerList.txt"  
$ServerList = Get-Content $ServerListFile -ErrorAction SilentlyContinue 
$Result = @() 
ForEach($computername in $ServerList) 
{

$AVGProc = Get-WmiObject -computername $computername win32_processor | 
Measure-Object -property LoadPercentage -Average | Select Average
$OS = gwmi -Class win32_operatingsystem -computername $computername |
Select-Object @{Name = "MemoryUsage"; Expression = {�{0:N2}� -f ((($_.TotalVisibleMemorySize - $_.FreePhysicalMemory)*100)/ $_.TotalVisibleMemorySize) }}
$vol = Get-WmiObject -Class win32_Volume -ComputerName $computername -Filter "DriveLetter = 'C:'" |
Select-object @{Name = "C PercentFree"; Expression = {�{0:N2}� -f  (($_.FreeSpace / $_.Capacity)*100) } }
  
$result += [PSCustomObject] @{ 
        ServerName = "$computername"
        CPULoad = "$($AVGProc.Average)%"
        MemLoad = "$($OS.MemoryUsage)%"
        CDrive = "$($vol.'C PercentFree')%"
    }

    $Outputreport = "<HTML><TITLE> Server Health Report </TITLE>
                     <BODY background-color:peachpuff>
                     <font color =""#99000"" face=""Microsoft Tai le"">
                     <H2> Server Health Report </H2></font>
                     <Table border=1 cellpadding=0 cellspacing=0>
                     <TR bgcolor=gray align=center>
                       <TD><B>Server Name</B></TD>
                       <TD><B>Avrg.CPU Utilization</B></TD>
                       <TD><B>Memory Utilization</B></TD>
                       <TD><B>C Drive Utilization</B></TD></TR>"
                        
    Foreach($Entry in $Result) 
    
        { 
          if(($Entry.CDrive) -ge "50") 
          { 
            $Outputreport += "<TR bgcolor=red>" 
          } 
          else
           {
            $Outputreport += "<TR bgcolor=green>" 
          }
          $Outputreport += "<TD>$($Entry.Servername)</TD><TD align=center>$($Entry.CPULoad)</TD><TD align=center>$($Entry.MemLoad)</TD><TD align=center>$($Entry.Cdrive)</TD></TR>" 
        }
     $Outputreport += "</Table></BODY></HTML>" 
        } 

$CurrentDate = Get-Date
$CurrentDate = $CurrentDate.ToString('MM-dd-yyyy')
 
$Outputreport | out-file "C:\Scripts\Test_$CurrentDate.htm" 
Invoke-Expression "C:\Scripts\Test_$CurrentDate.htm"
