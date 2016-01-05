export PASSPHRASE='BuL-?F3rx@Jx*3jF=wvjhLdSxKPYqk4Rxat$&yNhV+9^K5#2CEE%gGXKGksjY28wdK4#ww-YKEE-Wnd$VQTh+78GEmjLX5Tr4^*W'
export FTP_PASSWORD='KillBill2015'
duplicity list-current-files ftp://sd-70029@dedibackup-dc3.online.net/etc
duplicity list-current-files ftp://sd-70029@dedibackup-dc3.online.net/media/rt
unset PASSPHRASE
unset FTP_PASSWORD
