###############################################################
#
# Commands to remove and replace all exclusion ranges on two DHCP servers.
#   Assumes a split scope configuration and adds a delay to backup server.
#   I ran this manually, instead of as a script, so YMMV.
# 
# Requires CSV files with the configuration of the DHCP servers exclusion
#   ranges preconfigured. The Scopes are not changed during this process.
# 
# Written by Greg Malone - July 2016
#
###############################################################

# Create remote sessions to DHCP servers.
$srv01 = New-PSSession -ComputerName dhcpsrv01 -Name DHCPSRV01
$srv02 = New-PSSession -ComputerName dhcpsrv02 -Name DHCPSRV02

#DHCPSRV02 commands (Backup)
Enter-PSSession $srv02
  $exclusions = Import-Csv /path/to/dhcpsrv02_exclusionrange.csv  # Requires ScopeID, StartRange, EndRange
  
  # Set DHCP Scopes to inactive prior to reconfiguration.
  Get-DhcpServerv4Scope | Set-DhcpServerv4Scope -State InActive
  
  # Remove all exclusion ranges from DHCP scopes.
  Get-DhcpServerv4ExclusionRange | Remove-DhcpServerv4ExclusionRange
  
  # Set Delay on all DHCP Scopes of 500ms.
  Get-DhcpServerv4Scope | Set-DhcpServerv4Scope -Delay 500
  Invoke-Command {       
    foreach ($Scope in $exclusions) { 
        $ID = $Scope.ScopeId 
        $Startrange = $Scope.StartRange
        $Endrange = $Scope.EndRange
      
        Add-DhcpServerv4ExclusionRange -ScopeId $ID -StartRange $Startrange -EndRange $Endrange   
    } 
  }
  
  # Reactivate all scopes
  Get-DhcpServerv4Scope | Set-DhcpServerv4Scope -State Active
Exit-PSSession

#DHCPSRV01 commands
Enter-PSSession $srv01
  $exclusions = Import-Csv /path/to/dhcpsrv01_exclusionrange.csv # As above, but will require opposing exclusions to server 2

  # Set DHCP Scopes to inactive prior to reconfiguration.
  Get-DhcpServerv4Scope | Set-DhcpServerv4Scope -State InActive
  
  # Remove all exclusion ranges from DHCP scopes.
  Get-DhcpServerv4ExclusionRange | Remove-DhcpServerv4ExclusionRange

  Invoke-Command {       
    foreach ($Scope in $exclusions) { 
        $ID = $Scope.ScopeId 
        $Startrange = $Scope.StartRange
        $Endrange = $Scope.EndRange
      
        Add-DhcpServerv4ExclusionRange -ScopeId $ID -StartRange $Startrange -EndRange $Endrange   
    }
  }
  
  # Reactivate all scopes
  Get-DhcpServerv4Scope | Set-DhcpServerv4Scope -State Active
Exit-PSSession


Remove-PSSession -Name DHCPSRV01
Remove-PSSession -Name DHCPSRV02