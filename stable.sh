#!/usr/bin/env bash

clear
echo "Installing Proxy..."
sleep 1

if [ -f "Lucky271" ]; then
    echo "Deleting old proxy..."
    rm Lucky271
    sleep 1
    echo "Getting new proxy..."
fi

wget -q https://github.com/demsdivo11/lucky/raw/main/Lucky271

sleep 1
echo "Proxy Installed"
echo "Execute proxy with this command: ./Lucky271"
chmod +x Lucky271
