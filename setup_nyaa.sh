#!/bin/bash
#
# Configuration modifier for the nyaa.si docker image.
#
# Variables:
#
# MYSQL_HOST: Defines the host/server for the database instance. Fallback to SQLite if not defined.
# MYSQL_USER: Defines the user having access to the said database.
# MYSQL_PASS: Defines the MYSQL_USER password to be used.
# SITE_FLAVOR: Defines the variant of the website. (nyaa or sukebei)
# Note: MYSQL_USER and MYSQL_PASS can be left blank if desired but they depend on MYSQL_HOST being defined.
#
# Other Note: Ensure that the database container is accessible first before modifying any of these.

if [ ! -f .database_created ] ; then

    # Copy the config
    cp config.example.py config.py

    # Set the database information as defined by the user
    if [ -n "$MYSQL_HOST" ] ; then
        if [[ -n "$MYSQL_USER" && -n "$MYSQL_PASS" ]] ; then
            sed -i "/mysql:\/\/test:test123@localhost\/nyaav2?charset=utf8mb4/ s/test:test123@localhost/$MYSQL_USER:$MYSQL_PASS@$MYSQL_HOST/g" config.py
        elif [ -n "$MYSQL_USER" ] ; then
            sed -i "/mysql:\/\/test:test123@localhost\/nyaav2?charset=utf8mb4/ s/test:test123@localhost/$MYSQL_USER:test123@$MYSQL_HOST/g" config.py
        elif [ -n "$MYSQL_PASS" ] ; then
            sed -i "/mysql:\/\/test:test123@localhost\/nyaav2?charset=utf8mb4/ s/test:test123@localhost/test:$MYSQL_PASS@$MYSQL_HOST/g" config.py
        else
            sed -i "/mysql:\/\/test:test123@localhost\/nyaav2?charset=utf8mb4/ s/test:test123@localhost/test:test123@$MYSQL_HOST/g" config.py
        fi
    else
        # Fallback to sqlite even though it is not really recommended...
        sed -i '/USE_MYSQL/ s/True/False/g' config.py
    fi

    # Only modify the flavor if the user set sukebei
    if [ "$SITE_FLAVOR" = "sukebei" ] ; then
        sed -i "/SITE_FLAVOR/ s/'nyaa'/'sukebei'/1" config.py
    fi

    touch .database_created
    python db_create.py
    python db_migrate.py stamp head
fi

python run.py