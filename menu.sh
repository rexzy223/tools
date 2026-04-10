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

# ================= LOADING =================
loading() {
    echo -ne "${CYAN}Processing"
    for i in {1..3}; do
        echo -ne "."
        sleep 0.4
    done
    echo -e "${NC}"
}

# ================= RUN SCRIPT =================
run_script() {
    url=$1

    echo ""
    read -p "$(echo -e ${YELLOW}Ketik '0' untuk batal / Enter untuk lanjut:${NC} ) " konfirmasi
    if [[ "$konfirmasi" == "0" ]]; then
        echo -e "${RED}Dibatalkan!${NC}"
        sleep 1
        return
    fi

    loading
    echo -e "${GREEN}Menjalankan script...${NC}"
    bash <(curl -s $url)

    echo ""
    read -p "$(echo -e ${CYAN}Ketik '0' untuk menu atau 'exit' untuk keluar:${NC} ) " after
    if [[ "$after" == "exit" ]]; then
        echo -e "${RED}Keluar...${NC}"
        exit 0
    fi
}

# ================= MENU =================
while true; do
    header

    echo -e "${GREEN}1.${NC} Reinstall Panel"
    echo -e "${GREEN}2.${NC} Uninstall Panel"
    echo -e "${GREEN}3.${NC} Create Node"
    echo -e "${GREEN}4.${NC} Start Wings"
    echo -e "${GREEN}5.${NC} Lock VPS"
    echo ""
    echo -e "${YELLOW}Ketik 'exit' untuk keluar${NC}"
    echo -e "${BLUE}======================================${NC}"

    read -p "$(echo -e ${WHITE}Pilih menu [1-5 / exit]:${NC} ) " pilih

    case $pilih in
        1)
            run_script "https://raw.githubusercontent.com/rexzy223/tools/main/reinstall.sh"
            ;;
        2)
            run_script "https://raw.githubusercontent.com/rexzy223/tools/main/uninstall.sh"
            ;;
        3)
            run_script "https://raw.githubusercontent.com/rexzy223/tools/main/wings.sh"
            ;;
        4)
            run_script "https://raw.githubusercontent.com/rexzy223/tools/main/swings.sh"
            ;;
        5)
            run_script "https://raw.githubusercontent.com/rexzy223/tools/main/lock.sh"
            ;;
        exit)
            echo -e "${RED}Keluar...${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}Pilihan tidak valid!${NC}"
            sleep 1
            ;;
    esac
done
