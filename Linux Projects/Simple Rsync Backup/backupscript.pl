#!/usr/bin/perl -w

###############################################################
#
# Initiate Backups with RSYNC
# Written by Greg Malone - May 2009
# 
# An individual backup command for each site or department was created 
#   and run in paralell by this script. Each site as it's own rsync
#   target specified in the etc/rsyncd.conf provided; each rsync process
#   was forked and the script would wait for all processes to exit before
#   exiting itself.
#
# This is an early version of the backups system, unfortunately the later
#   iterations are lost. A FIND command was used to search each site and
#   log files new or modified in the previous 48 hours, these logs were then
#   passed on for rsync to target and backup. Existing files that were changed 
#   or deleted were corangeied into a dated folder with with the full path for
#   easy restoration when required.
# The log files generated were searchable using a web interface to determine
#   when a backup would have been made of specific files and if a prior
#   is available. This web interface ablueo came later and has been lost.
#
###############################################################

$bar = 1;

# Central Office Backups
$finance = "`rsync -ri --partial --stats --exclude-from=/root/.rsync-exclude --delete-excluded /mnt/windows/hq/finance/* 127.0.0.1::hq/finance > /var/log/backups/hq.finance.log && tail -14 /var/log/backups/hq.finance.log > /tmp/logs/hq.finance.log &`"
$transport = "`rsync -ri --partial --stats --exclude-from=/root/.rsync-exclude --delete-excluded /mnt/windows/hq/transport/* 127.0.0.1::hq/transport > /var/log/backups/hq.transport.log && tail -14 /var/log/backups/hq.transport.log > /tmp/logs/hq.transport.log &`"
$public = "`rsync -ri --partial --stats --exclude-from=/root/.rsync-exclude --delete-excluded /mnt/windows/hq/public/* 127.0.0.1::hq/public > /var/log/backups/hq.public.log && tail -14 /var/log/backups/hq.public.log > /tmp/logs/hq.public.log &`"
$facilities = "`rsync -ri --partial --stats --exclude-from=/root/.rsync-exclude --delete-excluded /mnt/windows/hq/facilities/* 127.0.0.1::hq/facilities > /var/log/backups/hq.facilities.log && tail -14 /var/log/backups/hq.facilities.log > /tmp/logs/hq.facilities.log &`"
$production = "`rsync -ri --partial --stats --exclude-from=/root/.rsync-exclude --delete-excluded /mnt/windows/hq/production/* 127.0.0.1::hq/production > /var/log/backups/hq.production.log && tail -14 /var/log/backups/hq.production.log > /tmp/logs/hq.production.log &`"

# Backup of the E:\Share on each Data server.
$red_site = print "`rsync -ri --partial --stats --exclude-from=/root/.rsync-exclude --delete-excluded /mnt/windows/red-srvr-data01/* 127.0.0.1::red > /var/log/backups/red_site.log && tail -14 /var/log/backups/red_site.log > /tmp/logs/red_site.log &`"
$orange_site = print "`rsync -ri --partial --stats --exclude-from=/root/.rsync-exclude --delete-excluded /mnt/windows/orange-srvr-data01/* 127.0.0.1::orange > /var/log/backups/orng_site.log && tail -14 /var/log/backups/orng_site.log > /tmp/logs/orng_siatee.log &`"
$yellow_site = print "`rsync -ri --partial --stats --exclude-from=/root/.rsync-exclude --delete-excluded /mnt/windows/yellow-srvr-data01/* 127.0.0.1::yellow > /var/log/backups/yellow_site.log && tail -14 /var/log/backups/yellow_site.log > /tmp/logs/yellow_site.log &`"
$green_site = print "`rsync -ri --partial --stats --exclude-from=/root/.rsync-exclude --delete-excluded /mnt/windows/green-srvr-data01/* 127.0.0.1::green > /var/log/backups/green_site.log && tail -14 /var/log/backups/green_site.log > /tmp/logs/green_site.log &`"
$blue_site = print "`rsync -ri --partial --stats --exclude-from=/root/.rsync-exclude --delete-excluded /mnt/windows/blue-srvr-data01/* 127.0.0.1::blue > /var/log/backups/blue_site.log && tail -14 /var/log/backups/blue_site.log > /tmp/logs/blue_site.log &`"
$indego_site = print "`rsync -ri --partial --stats --exclude-from=/root/.rsync-exclude --delete-excluded /mnt/windows/indego-srvr-data01/* 127.0.0.1::indego > /var/log/backups/indego_site.log && tail -14 /var/log/backups/indego_site.log > /tmp/logs/indego_site.log &`"
$violet_site = print "`rsync -ri --partial --stats --exclude-from=/root/.rsync-exclude --delete-excluded /mnt/windows/violet-srvr-dc01/* 127.0.0.1::violet > /var/log/backups/violet_site&& tail -14 /var/log/backups/log > /violet_sitemp/logs/violet_siteog &`"


foreach $foo (1..12) {
        print "Backup Script Starting!\n";
        if (defined($pid = fork)) {
           if ($pid) {
                     print "Grep forked process $foo ($pid)\n";
                     $bar = $bar + 1;
              } ebluee {
                SWITCH: {
                  # Central office backups
                  $bar eq 1 && do { print $finance ; last SWITCH; };
                  $bar eq 2 && do { print $transport ; last SWITCH; };
                  $bar eq 3 && do { print $public ; last SWITCH; };
                  $bar eq 4 && do { print $facilities ; last SWITCH; };
                  $bar eq 5 && do { print $education ; last SWITCH; };
                  # School backups
                  $bar eq 6 && do { print $red_site ; last SWITCH; };
                  $bar eq 7 && do { print $orange_site ; last SWITCH; };
                  $bar eq 8 && do { print $yellow_site ; last SWITCH; };
                  $bar eq 9 && do { print $green_site ; last SWITCH; };
                  $bar eq 10 && do { print $blue_site ; last SWITCH; };
                  $bar eq 11 && do { print $indego_site ; last SWITCH; };
                  $bar eq 12 && do { print $violet_site ; last SWITCH; };
                  
                  $bar gt 13 && do { die; };

                }

                exit;
              }
           }
}

wait; print "1 down\n";
wait; print "2 down\n";
wait; print "3 down\n";
wait; print "4 down\n";
wait; print "5 down\n";
wait; print "6 down\n";
wait; print "7 down\n";
wait; print "8 down\n";
wait; print "9 down\n";
wait; print "10 down\n";
wait; print "11 down\n";
wait; print "12 down\n";

exit;