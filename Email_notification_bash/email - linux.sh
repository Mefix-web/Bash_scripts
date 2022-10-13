#!/bin/bash
# Email Noification
#
# Description: This shell script will automatically send an email to PLW team to release disk space
#       Script will be run by crontab.
#

# Seting the environment for crontab jobs

        HOST=`/bin/hostname`               ; export HOST

        PATH=/usr/lib64/qt-3.3/bin:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/appl/usf/perl/cur/bin
        PATH=$PATH:/appl/usf/sdi/cur/bin:/appl/usf/stu_common/cur/bin:/appl/usf/sysinfo/cur/bin

# Declaring to who should be sent an email

        CC=email@gmail.com
        TO=to@gmail.com

# Greping diskspace with partition name

        df -h | grep /planisware | awk '{print$5,$4}' | while read output;

do
# Functions for partition and for disk space taken
        used=$(echo $output | awk '{print$2}' | sed s/%//g)
        partition=$(echo $output | awk '{print$1}')

# Checking if disk space is over 90%

if [ $used -ge 90 ]; then

# Sending an email if disk space is over 90%

        echo -e "The partition $partition on $(hostname) has $used% of used space at $(date) \n
Please clean up disk space" | mailx -s "Free space missing on $(hostname)" -r "email@gmail.com" -S smtp="smtp_server" -c $CC $TO
fi
done

