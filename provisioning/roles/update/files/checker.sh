#!/bin/bash

if [ $(curl -sL -w "%{http_code}\\n" "https://devopstest.gigmedia.tech" -o /dev/null)  != "200" ]; then
    echo "Wordpress is not healthy: Non-200 response"; exit 1;
fi

if [ $(curl "https://devopstest.gigmedia.tech/version.txt")  != "1.0.0" ]; then
    echo "Wordpress is not healthy: version.txt does not match"; exit 1;
fi

exit 0