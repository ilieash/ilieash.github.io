# This is a script that will grep a log file and send an email when a specified patter is encountered.
# Author: Salman Bayat
errors=$(grep "CRITICAL" /media/rt/.flexget/flexget.log)
echo "$errors" > /tmp/current-errors.log

if      [ -e "/tmp/prior-errors.log" ]
         then echo "prior-errors.log Exists" > /dev/null
else
        touch /tmp/prior-errors.log | echo "" > /tmp/prior-errors.log
fi

newentries=$(diff --suppress-common-lines -u /tmp/prior-errors.log /tmp/current-errors.log | grep '\+[0-9]')

if
                test "$newentries" != "" && test "$errors" = ""
                then echo "No New Errors" > /dev/null
        elif
                test "$newentries" != ""
                then echo "$errors" | python /media/rt/bin/pushbullet-script-for-flexget-error.py
                echo "$errors" > /tmp/prior-errors.log
fi
