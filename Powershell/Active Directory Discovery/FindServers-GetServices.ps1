###############################################################
#
# Script to enumerate the services for each computer in a list of OUs.
#   Returns SystemName, Service Name, Credentials, Startup Mode
#   Indicates progress by printing each system scanned to console.
# 
# Written by Greg Malone - June 2015
#
################################################################

# Environment variables
# $ConnectionServers are an array of server or domain names for each domain we'll investigate.
Import-Module activedirectory
$ConnectionServer = @()
$ConnectionServer += "Domain1.com"
$ConnectionServer += "Domain2.com"

## There are two primary ways to select your target computers:  
## 1. Iterate through OUs for any computers listed in them.  Shown below in the $OUList section.
## 2. Filter computers based on attributes like Operating System or Enabled status.  
## Or use a combination of both if needed.

# $OUList is an array of arrays.  Each array holds the OUs that will be assessed per the $ConnectionServers variable.  
# Each array will coincide with the domains provided above. 
$OUList = @()
$OUList += @("OU1","OU2")
$OUList += @("OU2")

# Set Filter for Get-ADComputer cmdlet.
# Use * to get all computers.
$filter = {OperatingSystem -like "Windows Server *"}

# Iterate through OUList values for each ConnectionServer.
foreach ($domain in $ConnectionServer) {
    $listnum = 0    
    foreach ($group in $OUList[$listnum]) {   
        
        # Return array of servers in specified OUs
        $server = Get-ADComputer -Server "$domain" -SearchBase "$group" -Filter "$filter" 
        
        # Iterate through servers identified above.
        foreach ($sname in $server) {
            
            # Do the thing.
            # In this example get services and output them.
            echo "$sname.Name"   
            Get-WmiObject win32_service -ComputerName $sname.Name | Format-Table SystemName,Name,Startname,Startmode -AutoSize | Out-File "Path.to.File" -Append
        }
    }
    # Increment the array of OUs to check in the next domain (if any)
    $listnum = $listnum + 1
}
    
