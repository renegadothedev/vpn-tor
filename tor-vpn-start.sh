#!/bin/bash
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${GREEN}🔹 Desativando IPv6...\033[0m"
sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1 2>/dev/null
sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1 2>/dev/null

echo -e "${GREEN}🔹 Limpando regras antigas de firewall...\033[0m"
sudo iptables -F 2>/dev/null
sudo iptables -t nat -F 2>/dev/null

echo -e "${GREEN}🔹 Aplicando regras Tor VPN...\033[0m"
sudo iptables -A INPUT -i lo -j ACCEPT
sudo iptables -A OUTPUT -o lo -j ACCEPT
sudo iptables -A OUTPUT -m owner --uid-owner debian-tor -j ACCEPT
sudo iptables -t nat -A OUTPUT -p udp --dport 53 -j REDIRECT --to-ports 5353
sudo iptables -t nat -A OUTPUT -p tcp --syn -j REDIRECT --to-ports 9040

echo -e "${GREEN}✅ Tor VPN ativada! Teste seu IP:"
curl -s ifconfig.me
