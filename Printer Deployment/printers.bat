goto Start
###############################################################
#
# Script to batch install workstation printers
# Written by Greg Malone - September 2012
# 
# This script can be run remotely via PSExec, manually on the 
#   workstation, or as part of an initial configuration script. 
#
###############################################################
# Additional information about the scripts used available at:
#    http://technet.microsoft.com/en-us/library/cc725868
#    http://technet.microsoft.com/en-us/library/cc754352
#    http://technet.microsoft.com/en-us/library/cc754632
#
#

### Example Printers installed by script
###     Staff Room (HP Laserjet 5)		10.0.0.3 
###     Science Lab (HP Laserjet 5)	    10.0.0.5 
###     Library (Lexmark T630)		    10.0.0.7  
#

### vbs scripts are built into Windows 7 systems
### Path to the drivers (P:) must be available localally or on a public 
###    network share.

:Start

REM	Add the drivers to the computer
Cscript %WINDIR%\System32\Printing_Admin_Scripts\en-US\Prndrvr.vbs -a -m "HP Laserjet 5" -v 3 -e "Windows NT x86" -h P:\PrinterDrivers\HPLJ5
Cscript %WINDIR%\System32\Printing_Admin_Scripts\en-US\Prndrvr.vbs -a -m "Lexmark T630 (MS)" -v 3 -e "Windows NT x86" -h P:\PrinterDrivers\Lexmark

REM	Add the network ports to the computer
Cscript %WINDIR%\System32\Printing_Admin_Scripts\en-US\Prnport.vbs -a -r IP_10.0.0.3 -h 10.0.0.3 -o raw -n 9100
Cscript %WINDIR%\System32\Printing_Admin_Scripts\en-US\Prnport.vbs -a -r IP_10.0.0.5 -h 10.0.0.5 -o raw -n 9100
Cscript %WINDIR%\System32\Printing_Admin_Scripts\en-US\Prnport.vbs -a -r IP_10.0.0.7 -h 10.0.0.7 -o raw -n 9100

REM	Add the printer to the computer
Cscript %WINDIR%\System32\Printing_Admin_Scripts\en-US\Prnmngr.vbs -a -p "Staff Room" -m "HP Laserjet 5" -r IP_10.0.0.3
Cscript %WINDIR%\System32\Printing_Admin_Scripts\en-US\Prnmngr.vbs -a -p "Science Lab" -m "HP Laserjet 5" -r IP_10.0.0.5
Cscript %WINDIR%\System32\Printing_Admin_Scripts\en-US\Prnmngr.vbs -a -p "Library" -m "Lexmark T630 (MS)" -r IP_10.0.0.7

REM To list the printers installed at the end of the process:
REM	Cscript %WINDIR%\System32\Printing_Admin_Scripts\en-US\Prndrvr.vbs -l
