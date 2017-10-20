# Point the script to the text file
$Computers = Read-Host "Enter Location Of text file containing list of computers"

# sets the varible for the file location ei c:\temp\ThisFile.exe
$Source = Read-Host "Enter source file location"

# sets the varible for the file destination
$Destination = Read-Host "Enter file destination"


# displays the file being copied, the destination directory and the target computer names on screen
Write-host "Copying " -NoNewline
Write-Host "$Source " -foreground "red" -NoNewline
Write-Host "to " -NoNewline
Write-Host "$Destination " -Foreground "red" -NoNewline
Write-Host "on the following computers: " -NoNewline
Write-Host "$(Get-Content $Computers)" -ForegroundColor "red" 

# Copies the file
Get-Content $Computers | foreach {Copy-Item $Source -Destination \\$_\c$\$Destination}
