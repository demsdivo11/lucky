
#!/bin/bash
set -e

RED="\e[31m"
GREEN="\e[32m"
ENDCOLOR="\e[0m"
RAW_BASE="https://raw.githubusercontent.com/demsdivo11/lucky/main"

download_file() {
    local url="$1"
    local out="$2"

    if command -v curl >/dev/null 2>&1; then
        curl -fsSL "$url" -o "$out" && return 0
    fi
    if command -v wget >/dev/null 2>&1; then
        wget -q -O "$out" "$url" && return 0
    fi
    return 1
}

download_first() {
    local out="$1"
    shift
    local tmp="${out}.tmp"
    local url
    for url in "$@"; do
        if download_file "$url" "$tmp"; then
            mv "$tmp" "$out"
            return 0
        fi
    done
    rm -f "$tmp"
    return 1
}

clear
echo -e "${GREEN}Installing Proxy...${ENDCOLOR}"
sleep 1

rm -f LuckyProxy
rm -rf arm64-v8a armeabi-v7a

echo -e "${GREEN}Downloading launcher/binary...${ENDCOLOR}"
download_file "${RAW_BASE}/LuckyProxy" "LuckyProxy" || {
    echo -e "${RED}Failed to download LuckyProxy.${ENDCOLOR}"
    exit 1
}
chmod 755 LuckyProxy

# If LuckyProxy is a launcher script, also pull both ABI binaries and set +x.
if grep -q "arm64-v8a/LuckyProxy\|armeabi-v7a/LuckyProxy" LuckyProxy 2>/dev/null; then
    echo -e "${GREEN}Detected multi-ABI launcher. Downloading binaries...${ENDCOLOR}"
    for abi in arm64-v8a armeabi-v7a; do
        mkdir -p "$abi"
        if download_first "$abi/LuckyProxy" \
            "${RAW_BASE}/out/android/${abi}/LuckyProxy" \
            "${RAW_BASE}/${abi}/LuckyProxy"; then
            chmod 755 "$abi/LuckyProxy"
        else
            echo -e "${RED}Failed to download ${abi}/LuckyProxy.${ENDCOLOR}"
            echo -e "${RED}Upload binary to one of:${ENDCOLOR}"
            echo -e "${RED}  ${RAW_BASE}/out/android/${abi}/LuckyProxy${ENDCOLOR}"
            echo -e "${RED}  ${RAW_BASE}/${abi}/LuckyProxy${ENDCOLOR}"
            exit 1
        fi
    done
fi

echo -e "${GREEN}Proxy Installed${ENDCOLOR}"
echo -e "${GREEN}Execute proxy with this command: ./LuckyProxy${ENDCOLOR}"

echo -e "${GREEN}Checking items.dat...${ENDCOLOR}"
sleep 1

items_url="${RAW_BASE}/items.dat"
local_size=0
if [ -f "items.dat" ]; then
    local_size=$(wc -c < items.dat 2>/dev/null)
fi
remote_size=$(curl -sI -L "$items_url" | awk 'tolower($1)=="content-length:" {print $2}' | tail -n1 | tr -d '\r')

if [ -n "$remote_size" ] && [ "$local_size" -eq "$remote_size" ]; then
    echo -e "${GREEN}items.dat up to date, skip download.${ENDCOLOR}"
else
    echo -e "${GREEN}Downloading items.dat...${ENDCOLOR}"
    download_file "$items_url" "items.dat" || {
        echo -e "${RED}Failed to download items.dat.${ENDCOLOR}"
        exit 1
    }
fi

if [ -f "items.dat" ]; then
    echo -e "${GREEN}items.dat successfully downloaded!${ENDCOLOR}"
else
    echo -e "${RED}Failed to download items.dat.${ENDCOLOR}"
fi
