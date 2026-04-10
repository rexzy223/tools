#!/bin/bash

# ================= WARNA =================
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
WHITE='\033[1;37m'
NC='\033[0m'

# ================= HEADER =================
header() {
clear
echo -e "\033[1;31m"
echo "████████╗ ██████╗  ██████╗ ██╗     ███████╗"
echo "╚══██╔══╝██╔═══██╗██╔═══██╗██║     ██╔════╝"
echo "   ██║   ██║   ██║██║   ██║██║     ███████╗"
echo "   ██║   ██║   ██║██║   ██║██║     ╚════██║"
echo "   ██║   ╚██████╔╝╚██████╔╝███████╗███████║"
echo "   ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝╚══════╝"
echo -e "\033[0m"
echo -e "${BLUE}======================================${NC}"
echo -e "${CYAN}        PANEL CONTROL MENU 🚀${NC}"
echo -e "${BLUE}======================================${NC}"
}

# ================= LOOP MENU =================
while true; do
    header

    echo -e "${GREEN}1.${NC} Reinstall Panel"
    echo -e "${GREEN}2.${NC} Uninstall Panel"
    echo -e "${GREEN}3.${NC} Create Node"
    echo -e "${GREEN}4.${NC} Start Wings"
    echo -e "${GREEN}5.${NC} Lock VPS"
    echo ""
    echo -e "${YELLOW}Ketik CTRL+C untuk keluar${NC}"
    echo -e "${BLUE}======================================${NC}"

    read -p "$(echo -e ${WHITE}Pilih menu [1-5]:${NC} ) " pilih

    case $pilih in
        1)
            bash <(curl -s https://raw.githubusercontent.com/rexzy223/tools/main/reinstall.sh)
            ;;
        2)
            bash <(curl -s https://raw.githubusercontent.com/rexzy223/tools/main/uninstall.sh)
            ;;
        3)
            bash <(curl -s https://raw.githubusercontent.com/rexzy223/tools/main/wings.sh)
            ;;
        4)
            bash <(curl -s https://raw.githubusercontent.com/rexzy223/tools/main/swings.sh)
            ;;
        5)
            bash <(curl -s https://raw.githubusercontent.com/rexzy223/tools/main/lock.sh)
            ;;
        *)
            echo -e "${RED}Pilihan tidak valid!${NC}"
            sleep 1
            ;;
    esac
done
