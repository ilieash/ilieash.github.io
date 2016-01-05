export PASSPHRASE=''
export FTP_PASSWORD=''
duplicity --file-to-restore /media/rt/.rtorrent.rc ftp://sd-70029@dedibackup-dc3.online.net/media/rt /home/friendsco/rtorrnt.rc.dr
unset PASSPHRASE
unset FTP_PASSWORD
