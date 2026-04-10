#!/bin/bash
set -e

clear
echo "======================================="
echo "   AUTO TERMINAL LOCK SYSTEM 🔐"
echo "======================================="
echo ""

# ================= INPUT PASSWORD (HIDDEN 100%) =================
echo -n "Set Password Terminal: "
stty -echo
read PASSWORD
stty echo
echo ""

echo -n "Konfirmasi Password: "
stty -echo
read CONFIRM
stty echo
echo ""

# ================= VALIDASI =================
if [ "$PASSWORD" != "$CONFIRM" ]; then
  echo "❌ Password tidak sama!"
  exit 1
fi

echo ""
echo "🚀 Menginstall..."

# ================= HAPUS SCRIPT LAMA =================
sed -i '/REXZY TERMINAL LOCK SYSTEM/,+20d' ~/.bashrc 2>/dev/null || true

# ================= INSTALL KE BASHRC =================
cat << EOF >> ~/.bashrc

# --- REXZY TERMINAL LOCK SYSTEM (AUTO-KICK) ---
PASSWORD="${PASSWORD}"

echo -e "\e[31m"
echo "  _      _____ _____ ______ _   _  _____ ______ "
echo " | |    |_   _/ ____|  ____| \ | |/ ____|  ____|"
echo " | |      | || |    | |__  |  \| | |    | |__   "
echo " | |      | || |    |  __| | . \` | |    |  __|  "
echo " | |____ _| || |____| |____| |\  | |____| |____ "
echo " |______|_____\_____|______|_| \_|\_____|______|"
echo -e "\e[0m"

echo -e "\e[33mChecking System Authorization...\e[0m"
echo -n "Password: "
stty -echo
read inputpass
stty echo
echo ""

if [ "\$inputpass" = "\$PASSWORD" ]; then
    echo -e "\e[32mAccess Granted. Welcome!\e[0m"
else
    echo -e "\e[31mAccess Denied! Terminal will close.\e[0m"
    sleep 1
    exit
fi
# ----------------------------------------------

EOF

# ================= APPLY =================
source ~/.bashrc

echo ""
echo "======================================="
echo "✅ INSTALL SUCCESS!"
echo "======================================="
echo "🔐 Terminal sekarang terkunci"
echo "⚠️ Setiap login wajib password"
echo "======================================="
