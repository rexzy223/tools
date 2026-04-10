#!/bin/bash

clear
echo "======================================"
echo "     EXECUTE TOKEN WINGS 🚀"
echo "======================================"
echo ""

# Input token
read -p "Masukkan TOKEN NODE: " TOKEN

# Validasi
if [[ -z "$TOKEN" ]]; then
  echo "❌ Token kosong!"
  exit 1
fi

echo ""
echo "🔄 Menjalankan perintah..."

# Jalankan dulu command
bash -c "$TOKEN && systemctl start wings"

# Setelah itu kirim 'y'
echo "y" | bash

echo ""
echo "✅ Selesai!"
