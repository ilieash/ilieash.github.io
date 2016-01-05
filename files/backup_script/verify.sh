export PASSPHRASE=''
export FTP_PASSWORD=''
duplicity verify ftp://sd-70029@dedibackup-dc3.online.net/etc /etc
duplicity verify ftp://sd-70029@dedibackup-dc3.online.net/var/www /var/www
unset PASSPHRASE
unset FTP_PASSWORD
