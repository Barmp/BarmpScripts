goto Start
###############################################################
#
# Script to install network printer via HP Universal Driver package
# Written by Greg Malone - September 2012
# 
# This script can be run remotely via PSExec, manually on the 
#   workstation, or as part of an initial configuration script. 
#
###############################################################

:Start
\\server\deploy$\Drivers\HP_UNI_PCL5\install.exe /q /dm /sm10.0.0.5 /n"HP LaserJet P2100 (LAB)"