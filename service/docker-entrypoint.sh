#!/bin/sh

user=$(ls /home)
if [ ! $DASFLAG ]; then
    if [ ! $FLAG ]; then
        if [ ! $GZCTF_FLAG ]; then
            echo flag{TEST_DASFLAG} | tee /home/$user/flag /flag
        else
            echo $GZCTF_FLAG > /home/$user/flag
            export $GZCTF_FLAG=no_FLAG
            GZCTF_FLAG=no_FLAG
        fi
    else
        echo $FLAG > /home/$user/flag
        export $FLAG=no_FLAG
        FLAG=no_FLAG
    fi
else
    echo $DASFLAG > /home/$user/flag
    export $DASFLAG=no_FLAG
    DASFLAG=no_FLAG
fi

chmod 720 /home/$user/flag

/etc/init.d/ssh start
rm -f /docker-entrypoint.sh
tail -f /dev/null 