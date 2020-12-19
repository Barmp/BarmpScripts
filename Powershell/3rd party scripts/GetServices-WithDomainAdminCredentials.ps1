###############################################################
#
# Script to query and print services on any domain server with a 
#   service account in the Domain Admins group.
# 
# Credit reddit user RampageUT
# http://www.reddit.com/r/sysadmin/comments/387nhy/junior_sysadmin_here_how_do_i_handle_a_director/crt1oyp
# 
###############################################################


$service = Get-ADGroupMember "Domain Admins" | Get-ADUser
$domain =  <#put domain here #>
$Computers = Get-ADComputer -Filter "operatingsystem -like '*server*'"

foreach ($s in $service) {
 foreach ($i in $Computers) {
    get-wmiobject Win32_Service -ComputerName $i.Name -ErrorAction SilentlyContinue | 
        where-object {$_.StartName -eq "$domain\$($s.SamAccountName)" } | 
        format-table $i.Name, Name, StartName, State
 }
}