export PASSPHRASE='BuL-?F3rx@Jx*3jF=wvjhLdSxKPYqk4Rxat$&yNhV+9^K5#2CEE%gGXKGksjY28wdK4#ww-YKEE-Wnd$VQTh+78GEmjLX5Tr4^*W'
export FTP_PASSWORD='KillBill2015'
duplicity --file-to-restore /media/rt/.rtorrent.rc ftp://sd-70029@dedibackup-dc3.online.net/media/rt /home/friendsco/rtorrnt.rc.dr
unset PASSPHRASE
unset FTP_PASSWORD
