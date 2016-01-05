export PASSPHRASE=''
export FTP_PASSWORD=''
duplicity /home ftp://sd-70029@dedibackup-dc3.online.net/home
duplicity /etc ftp://sd-70029@dedibackup-dc3.online.net/etc
duplicity --exclude /var/tmp --exclude /var/www/owncloud/data /var/www ftp://sd-70029@dedibackup-dc3.online.net/var/www
duplicity /opt/plexWatch ftp://sd-70029@dedibackup-dc3.online.net/opt/plexWatch
duplicity --exclude /media/rt/owncloud --exclude /media/rt/staging --exclude /media/rt/watchfolder --exclude /media/rt/.rtorrent-session --exclude /media/rt/media /media/rt ftp://sd-70029@dedibackup-dc3.online.net/media/rt
unset PASSPHRASE
unset FTP_PASSWORD
