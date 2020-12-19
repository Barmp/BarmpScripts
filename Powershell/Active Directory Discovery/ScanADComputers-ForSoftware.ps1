###############################################################
#
# Searches specified OUs in Active Directory for Computer accounts, 
#   then scan those Computers for software.  
# 
# Written by Greg Malone - June 2016
#
# There are customization variables located in the Configuration 
#   portion of the script.
# 
###############################################################

Import-Module activedirectory


### Configuration portion of the script

# Select the Base OU to start scanning for Computer objects. Filter as necessary.
$OUBase = "OU=Computers,DC=contoso,DC=com"  
$filter = "*"               # Filter the OUs to scan.
$outfile = 'path\to\csv'    # Output file path.

# If SCCM is live in the environment the win32reg_addremoveprogams WMI class it creates is the fastest 
# way to query the target computers.  This will dynamically check for this WMI class and fall back 
# to the built in Win32_Product class if not found.
#
# If Win32_Product is used the script performs very slowly and the scope should be limited as a result.
if (Get-WmiObject -class win32reg_addremoveprograms -ErrorAction SilentlyContinue) { 
    $class = "win32reg_addremoveprograms" 
} else { 
    $class = "win32_product" 
}

### 
### 
### Main portion of the script

# Note the SearchScope is limited to OneLevel here 
$OUList = Get-ADOrganizationalUnit -SearchBase "$OUBase" -SearchScope OneLevel -Filter "$filter" -Properties *


foreach ($OU in $OUList) {
    $OUName = $OU.Name
    #$OUDesc = $OU.Description
    #$OUPath = $OU.CanonicalName
    $targetOU = $OU.DistinguishedName

    $ComputerList = Get-ADComputer -SearchBase "$targetOU" -SearchScope OneLevel -Filter $Filter -Properties * 

        # Itemize desired Computer information, write to host
    if ($ComputerList) {
        foreach ($Computer in $ComputerList) {
        
            $results = "$OUName,"

            $CompName = $Computer.Name
            $CompDesc = $Computer.Description
            $targetComp = $Computer.Name
            $targetComp = $targetComp.trim()

            $results += "$CompName,$CompDesc,`n"
    
            if (Test-Connection -ComputerName $targetComp -Quiet) {
                $WMIObject = Get-WmiObject -Class $class -ComputerName $targetComp
                
                foreach ($Obj in $WMIObject) {
                        $results += ","                
                        $results += $Obj.DisplayName
                        $results += ","
                        $results += $Obj.Version
                        $results += "`n"
                }
                        
            } else {
                $results += ",System Offline"
            }
            
            Out-File -FilePath $outfile -InputObject $results -Append
            
        }
    }


}