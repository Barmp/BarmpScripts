# BarmpScripts

An import and organization of a number of my old scripts and projects for ease of use. This will start life as a private repository until the scripts are scrubbed of any reference to private or identifying data.

* 12 Dec 2020: Imported, cleaned up and created comments for script and project data imported from my oldest backups. Listed basic descriptions for each script or project.

## To do:
* Find and import additional scripts and side projects not on my backup drives.
* Go through my gists and add them to this repo.

## CS50 Problemset Code
1. Solutions for the first two C code problemsets I worked on. Basic C code, code usually includes the cs50.h library which is not present here.

## Linux Projects
1. __Simple Rsync Backup__ is a small project that created an offsite, file level backup of data from a number of remote sites. Unfortunately I only have the early stages of the project, the code from later stages of the project is lost. This is a useful demonstration of how rsyncd.conf can be configured and accessed, how a variety of SMB / CIFS file servers can be accessed and mounted via fstab, and a simple loop and switch is used to fork processes that execute the individual rsync backups.

## Powershell
1. __3rd Party Scripts__: a few scripts I'd saved from one place or another.
    * __RADTool__ by Ryan Abbott; an example of setting up a console menu program in Powershell.
    * __User Creation__ by Rich Prescott; example using XML data and using winforms windows.
    * __View-Cats__ by unknown author; example use of com objects and interacting with an API.
    * __WPMonsterDomainReport__ by Michael Lindsley; Very large report on all domain controllers in a domain, has a number of useful examples using the ActiveDirectory powershell module.
2. __Active Directory Discovery__: A few common scripts I've used to discover and report on Active Directory environments.
    * __Check FSMO Roles__ by @Barmp; Will check Forest/Domain operational level and role holders and print a formatted list.
3. __DNS Management__: Basic script using dnscmd to remove and recreate DNS entries - intended for use in a DR scenario.

## Printer Deployment
1. __Configure_Workstation_Printers.bat__ by @Barmp; utilizes built in printer management vbs scripts in Windows 7 to configure printer ports, drivers and installed printers.
2. __HP_Universal_Driver_Remote_Install.bat__ by @Barmp; saved the command to remote install the HP universal driver (assuming the local user account has sufficient rights to do so). 
