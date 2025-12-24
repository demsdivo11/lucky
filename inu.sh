#!/bin/bash

RED="\e[31m"
GREEN="\e[32m"
ENDCOLOR="\e[0m"

clear
echo -e "${GREEN}Installing Proxy...${ENDCOLOR}"
sleep 1

if [ -f "LuckyProxy" ]; then
    echo -e "${RED}Deleting old proxy...${ENDCOLOR}"
    rm LuckyProxy
    sleep 1
    echo -e "${GREEN}Getting new proxy...${ENDCOLOR}"
fi

wget -q https://github.com/demsdivo11/lucky/raw/main/LuckyProxy

sleep 1
echo -e "${GREEN}Proxy Installed${ENDCOLOR}"
echo -e "${GREEN}Execute proxy with this command: ./LuckyProxy${ENDCOLOR}"
chmod +x LuckyProxy

echo -e "${GREEN}Checking items.dat...${ENDCOLOR}"
sleep 1

items_url="https://github.com/demsdivo11/lucky/raw/main/items.dat"
local_size=0
if [ -f "items.dat" ]; then
    local_size=$(wc -c < items.dat 2>/dev/null)
fi
remote_size=$(curl -sI -L "$items_url" | awk 'tolower($1)=="content-length:" {print $2}' | tail -n1 | tr -d '\r')

if [ -n "$remote_size" ] && [ "$local_size" -eq "$remote_size" ]; then
    echo -e "${GREEN}items.dat up to date, skip download.${ENDCOLOR}"
else
    echo -e "${GREEN}Downloading items.dat...${ENDCOLOR}"
    wget -q -O items.dat "$items_url"
fi

if [ -f "items.dat" ]; then
    echo -e "${GREEN}items.dat successfully downloaded!${ENDCOLOR}"
else
    echo -e "${RED}Failed to download items.dat.${ENDCOLOR}"
fi
