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

if [ -f "items.dat" ]; then
    echo -e "${RED}Old items.dat found. Deleting...${ENDCOLOR}"
    rm items.dat
    sleep 1
fi

echo -e "${GREEN}Downloading items.dat...${ENDCOLOR}"
wget -q https://github.com/demsdivo11/lucky/raw/main/items.dat

if [ -f "items.dat" ]; then
    echo -e "${GREEN}items.dat successfully downloaded!${ENDCOLOR}"
else
    echo -e "${RED}Failed to download items.dat.${ENDCOLOR}"
fi
