export PASSPHRASE='BuL-?F3rx@Jx*3jF=wvjhLdSxKPYqk4Rxat$&yNhV+9^K5#2CEE%gGXKGksjY28wdK4#ww-YKEE-Wnd$VQTh+78GEmjLX5Tr4^*W'
export FTP_PASSWORD='KillBill2015'
duplicity verify ftp://sd-70029@dedibackup-dc3.online.net/etc /etc
duplicity verify ftp://sd-70029@dedibackup-dc3.online.net/var/www /var/www
unset PASSPHRASE
unset FTP_PASSWORD
