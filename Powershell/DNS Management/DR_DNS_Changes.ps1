###############################################################
#
# Batch DNS record change
# Written by David Roy / Greg Malone - February 2014
# 
# Script to quickly reconfigure DNS records for services which 
#   have been brough up in a Disaster Recovery site.
# 
###############################################################
# 
# Requires configuration of the DNSrecords.csv file and Environment
#   Configuration section of this script prior to disaster recovery
#   scenario.
# 
# This script will create a log of all changes but does not 
#   validate the current data of the DNS records at run time!
# 
###############################################################

## Environment configuration
$DNSServer = "dns.contoso.com"
$DNSZone = "contoso.com"
$InputRecords = ".\DR_DNS_Records.csv"
$LogFile = ".\DR_DNS_Changes.log"

# Clear previous log file, or create new one.
Get-Date | Out-File -Filepath $LogFile

# Read input file
$records = Import-Csv $InputRecords

# Default is to initiate Disaster Recovery scenario DNS changes
$Disaster = $True   # True will use the dr_ip value in dnsrecords.csv
                    # False will use the prod_ip value in dnsrecords.csv

# Loop through csv file to delete and recreate DNS records.

ForEach ($record in $records) {

    # Copy object properties
    $recName = $record.Name
    $recType = $record.Type
    $recProdIP = $record.prod_ip
    $recDRIP = $record.dr_ip
    
    # Build DNSCMD DELETE command.
    $cmdDelete = "dnscmd $DNSServer /RecordDelete $DNSZone $recName $recType /f"
    
    # Build DNSCMD ADD command.
    if ($Disaster) {
        $cmdAdd = "dnscmd $DNSServer /RecordAdd $DNSZone $recName $recType $recDRIP"
    } else {
        $cmdAdd = "dnscmd $DNSServer /RecordAdd $DNSZone $recName $recType $recProdIP"
    }
    
    # Debug: write lines to screen to verify.
    # Write-Host $cmdDelete
    # Write-Host $cmdAdd
    
    # Execute Delete and Add commands.
    echo "Running command $cmdDelete" | out-file -Append $LogFile
    Invoke-Expression $cmdDelete | out-file -Append $LogFile
    echo "Running command $cmdAdd" | out-file -Append $LogFile 
    Invoke-Expression $cmdAdd | out-file -Append $LogFile
        
    }
