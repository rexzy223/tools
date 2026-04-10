#!/bin/bash
set -e

clear
echo "======================================="
echo "        UNINSTALL PANEL"
echo "======================================="
echo ""

# ================= INPUT =================
read -p "UNINSTALL PANEL (y/N): " REMOVE_PANEL
read -p "UNINSTALL WINGS (y/N): " REMOVE_WINGS

echo ""
echo "⚠️ Proses uninstall akan dijalankan sesuai pilihan!"
read -p "Lanjut? (y/N): " confirm
[[ "$confirm" != "y" && "$confirm" != "Y" ]] && exit

echo ""
echo "🚀 Memproses uninstall..."
sleep 1

# ================= REMOVE WINGS =================
if [[ "$REMOVE_WINGS" == "y" || "$REMOVE_WINGS" == "Y" ]]; then
  echo "🛑 UNINSTALL WINGS..."

  systemctl stop wings 2>/dev/null || true
  systemctl disable wings 2>/dev/null || true
  rm -f /etc/systemd/system/wings.service
  rm -f /usr/local/bin/wings
  rm -rf /etc/pterodactyl
  rm -rf /var/lib/pterodactyl

  fuser -k 8080/tcp 2>/dev/null || true
  fuser -k 2022/tcp 2>/dev/null || true

  echo "✅ Wings berhasil diuninstall"
fi

# ================= REMOVE PANEL =================
if [[ "$REMOVE_PANEL" == "y" || "$REMOVE_PANEL" == "Y" ]]; then
  echo "📦 UNINSTALL PANEL & DOMAIN..."

  rm -rf /etc/nginx/sites-enabled/* || true
  rm -rf /etc/nginx/sites-available/* || true
  rm -rf /etc/letsencrypt/live/* || true
  rm -rf /etc/letsencrypt/archive/* || true
  rm -rf /etc/letsencrypt/renewal/* || true

  rm -rf /var/www/pterodactyl/* || true
  rm -rf /var/www/html/* || true
  rm -rf /root/.acme.sh/* || true

  systemctl reload nginx 2>/dev/null || true
  systemctl restart nginx 2>/dev/null || true

  pm2 delete all 2>/dev/null || true

  echo "⬇️ Download installer..."
  curl -s https://pterodactyl-installer.se -o /tmp/ptero.sh
  chmod +x /tmp/ptero.sh

  echo "💀 Menjalankan UNINSTALL PANEL..."

  bash /tmp/ptero.sh <<EOF
6
y
y
y

y
y
EOF

  echo "✅ Panel berhasil diuninstall"
fi

# ================= FINAL =================
echo ""
echo "======================================="
echo "✅ UNINSTALL SUCCESS!"
echo "======================================="

if [[ "$REMOVE_PANEL" == "y" || "$REMOVE_PANEL" == "Y" ]]; then
  echo "💀 Panel diuninstall"
fi

if [[ "$REMOVE_WINGS" == "y" || "$REMOVE_WINGS" == "Y" ]]; then
  echo "💀 Wings diuninstall"
fi

echo "🚀 VPS siap digunakan kembali"
echo "======================================="
