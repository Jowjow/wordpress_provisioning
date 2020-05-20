#!/bin/bash

if [ $(curl -sL -w "%{http_code}\\n" "https://localhost:80/version.txt" -o /dev/null)  != "200" ]; then
    echo "Wordpress is not healthy1"; exit 1;
fi

if [ $(curl "https://localhost:80/version.txt")  != "1.0.0" ]; then
    echo "Wordpress is not healthy2"; exit 1;
fi

exit 0