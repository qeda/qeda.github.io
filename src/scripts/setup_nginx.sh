#!/bin/bash

HTML_ROOT=$(cd "$( dirname "${BASH_SOURCE[0]}" )/../.." && pwd)
CONF_FILE=qeda.org.conf

echo "server {
	listen localhost:9009;
	root $HTML_ROOT;
	index index.html;
	location / { try_files \$uri \$uri/ =404; }
}" > $CONF_FILE

sudo mv -v -f $CONF_FILE /etc/nginx/sites-available/

if [ ! -f /etc/nginx/sites-enabled/$CONF_FILE ]; then
    sudo ln -s /etc/nginx/sites-available/$CONF_FILE /etc/nginx/sites-enabled/$CONF_FILE
fi

sudo /etc/init.d/nginx restart
