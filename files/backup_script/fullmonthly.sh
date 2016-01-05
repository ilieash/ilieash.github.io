export PASSPHRASE=''
export FTP_PASSWORD=''

# doing a monthly full backup (1M)
duplicity --full-if-older-than 1M /etc ftp://sd-70029@dedibackup-dc3.online.net/etc
# exclude /var/tmp from the backup
duplicity --full-if-older-than 1M --exclude /var/tmp --exclude /var/www/owncloud/data /var/www ftp://sd-70029@dedibackup-dc3.online.net/var/www
duplicity --full-if-older-than 1M /home ftp://sd-70029@dedibackup-dc3.online.net/home
duplicity --full-if-older-than 1M /opt/plexWatch ftp://sd-70029@dedibackup-dc3.online.net/opt/plexWatch
duplicity --full-if-older-than 1M --exclude /media/rt/staging --exclude /media/rt/owncloud --exclude /media/rt/watchfolder --exclude /media/rt/.rtorrent-session --exclude /media/rt/media /media/rt ftp://sd-70029@dedibackup-dc3.online.net/media/rt

# cleaning the remote backup space (deleting backups older than 6 months (6M, alternatives would 1Y fo 1 year etc.)
duplicity remove-older-than 6M --force ftp://sd-70029@dedibackup-dc3.online.net/etc
duplicity remove-older-than 6M --force ftp://sd-70029@dedibackup-dc3.online.net/var/www
duplicity remove-older-than 6M --force ftp://sd-70029@dedibackup-dc3.online.net/home

unset PASSPHRASE
unset FTP_PASSWORD
