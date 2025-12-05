#!/bin/bash

RED="\e[31m"
GREEN="\e[32m"
ENDCOLOR="\e[0m"

clear
echo -e "${GREEN}Installing Proxy...${ENDCOLOR}"
sleep 1

if [ -f "Lucky271" ]; then
    echo -e "${RED}Deleting old proxy...${ENDCOLOR}"
    rm Lucky271
    sleep 1
    echo -e "${GREEN}Getting new proxy...${ENDCOLOR}"
fi

wget -q https://github.com/demsdivo11/lucky/raw/main/Lucky271

sleep 1
echo -e "${GREEN}Proxy Installed${ENDCOLOR}"
echo -e "${GREEN}Execute proxy with this command: ./Lucky271${ENDCOLOR}"
chmod +x Lucky271
