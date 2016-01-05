#!/bin/bash
TORRENT_PATH=$1
TORRENT_NAME=$2
TORRENT_LABEL=$3


/media/rt/bin/subliminal_script/Subliminal.py -S /media/rt/staging -k -L /media/rt/bin/subliminal_script/incronrun.log
sleep 10
filebot -script fn:amc --output "$HOME/media" --log-file amc.log --action move --conflict auto -non-strict --def clean=y unsorted=y pushbullet=dTYbfhCycFiG25lYOBtFNzbxeMKQRwSB  "ut_dir=$TORRENT_PATH" "ut_kind=multi" "ut_title=$TORRENT_NAME" "ut_label=$TORRENT_LABEL" &
