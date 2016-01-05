export PASSPHRASE=''
export FTP_PASSWORD=''
duplicity list-current-files ftp://sd-70029@dedibackup-dc3.online.net/etc
duplicity list-current-files ftp://sd-70029@dedibackup-dc3.online.net/media/rt
unset PASSPHRASE
unset FTP_PASSWORD
