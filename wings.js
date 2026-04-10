#!/bin/bash

clear
echo "======================================="
echo "   AUTO INSTALL NODE + WINGS 🚀"
echo "======================================="
echo ""

# ================= INPUT =================
read -p "Masukkan nama lokasi: " location_name
read -p "Masukkan deskripsi lokasi: " location_description
read -p "Masukkan domain: " domain
read -p "Masukkan nama node: " node_name
read -p "Masukkan RAM (MB): " ram
read -p "Masukkan Disk Space (MB): " disk_space
read -p "Masukkan Locid: " locid

echo ""
echo "⏳ Memproses..."

# ================= MASUK KE PANEL =================
cd /var/www/pterodactyl || { echo "❌ Direktori panel tidak ditemukan"; exit 1; }

# ================= BUAT LOKASI =================
echo "📍 Membuat lokasi..."
php artisan p:location:make <<EOF
$location_name
$location_description
EOF

# ================= BUAT NODE =================
echo "🖥️ Membuat node..."
php artisan p:node:make <<EOF
$node_name
$location_description
$locid
https
$domain
yes
no
no
$ram
$ram
$disk_space
$disk_space
100
8080
2022
/var/lib/pterodactyl/volumes
EOF

# ================= AMBIL NODE ID =================
echo "🔍 Mengambil Node ID..."
NODE_ID=$(php artisan tinker --execute="echo optional(\Pterodactyl\Models\Node::latest()->first())->id;" | grep -E '^[0-9]+$' | tail -n 1)

if [ -z "$NODE_ID" ]; then
    echo "❌ Gagal mendapatkan Node ID!"
    exit 1
fi

echo "✅ Node ID: $NODE_ID"

# ================= CONFIG WINGS =================
echo "⚙️ Membuat konfigurasi Wings..."
mkdir -p /etc/pterodactyl
php artisan p:node:configuration $NODE_ID > /etc/pterodactyl/config.yml

# ================= START WINGS =================
echo "🚀 Menyalakan Wings..."
systemctl daemon-reexec
systemctl daemon-reload
systemctl enable wings
systemctl restart wings

sleep 5

# ================= STATUS =================
echo ""
echo "=============================="
echo "   STATUS INSTALL"
echo "=============================="

if systemctl is-active --quiet wings; then
    echo -e "\e[1;32m[SUKSES] Node & Wings berhasil ONLINE 🚀\e[0m"
else
    echo -e "\e[1;31m[ERROR] Wings gagal berjalan!\e[0m"
    echo "Cek manual: systemctl status wings"
fi

echo ""
echo "🎉 INSTALL SELESAI!"
