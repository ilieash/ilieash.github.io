#
# Script created on 12-1-2005
#
# This script was created to make Duplicity backups.
# Full backups are made on the 1st day of each month.
# Then incremental backups are made on the other days.
#

# Loading the day of the month in a variable.
date=`date +%d`

# Setting the pass phrase to encrypt the backup files.
export PASSPHRASE=''
export PASSPHRASE

# Setting the password for the FTP account that the
# backup files will be transferred to.
FTP_PASSWORD=''
export FTP_PASSWORD

# Check to see if we're at the first of the month.
# If we are on the 1st day of the month, then run
# a full backup.  If not, then run an incremental
# backup.
if [ $date = 01 ]
then
        duplicity full --no-encryption /home/friendsco/backup_script/passphrase ftp://sd-70029@dedibackup-dc3.online.net/passwords >>/var/log/duplicity/passwords.log
        duplicity full /home ftp://sd-70029@dedibackup-dc3.online.net/home >>/var/log/duplicity/personal.log
        duplicity full /etc ftp://sd-70029@dedibackup-dc3.online.net/etc >>/var/log/duplicity/etc.log
else
        duplicity --no-encryption /home/friendsco/backup_script/passphrase ftp://sd-70029@dedibackup-dc3.online.net/passwords >>/var/log/duplicity/passwords.log
        duplicity /home ftp://sd-70029@dedibackup-dc3.online.net/home >>/var/log/duplicity/personal.log
        duplicity /etc ftp://sd-70029@dedibackup-dc3.online.net/etc >>/var/log/duplicity/etc.log
fi
# Check http://www.nongnu.org/duplicity/duplicity.1.html
# for all the options available for Duplicity.

# Deleting old backups
        duplicity remove-older-than 1Y --force ftp://sd-70029@dedibackup-dc3.online.net/passwords >>/var/log/duplicity/passwords.log
        duplicity remove-older-than 1Y --force ftp://sd-70029@dedibackup-dc3.online.net/home >>/var/log/duplicity/personal.log
        duplicity remove-older-than 1Y --force ftp://sd-70029@dedibackup-dc3.online.net/etc >>/var/log/duplicity/etc.log

# Unsetting the confidential variables so they are
# gone for sure.
unset PASSPHRASE
unset FTP_PASSWORD

exit 0
