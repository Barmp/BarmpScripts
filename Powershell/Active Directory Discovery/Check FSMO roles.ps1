###############################################################
#
# Script to query and print AD Domain Controler FSMO roles and 
#   functional level for the current domain
# Written by Greg Malone - August 2014
#
###############################################################

Import-Module activedirectory

## Queries the local domain of the workstation
## Use get-addomain -Server <DC Name> -Credential <user credential> for remote domains
## cmdlet details: https://docs.microsoft.com/en-us/powershell/module/addsadministration/get-addomain?view=win10-ps
$dnsroot = get-addomain | select dnsroot  

## Generates a list with Forest functional level and role holders
Get-ADForest $dnsroot.dnsroot | Format-List ForestMode
Get-ADForest $dnsroot.dnsroot | Format-List SchemaMaster,DomainNamingMaster

## Generates a list with Domain functional level and role holders
Get-ADDomain $dnsroot.dnsroot | Format-List DomainMode
Get-ADDomain $dnsroot.dnsroot | format-List PDCEmulator,RIDMaster,InfrastructureMaster



