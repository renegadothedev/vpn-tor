#!/bin/bash
RED='\033[0;31m'
NC='\033[0m'
SUDO_CMD="sudo"

echo -e "${RED}🔹 Restaurando IPv6...\033[0m"
$SUDO_CMD sysctl -w net.ipv6.conf.all.disable_ipv6=0 2>/dev/null
$SUDO_CMD sysctl -w net.ipv6.conf.default.disable_ipv6=0 2>/dev/null

echo -e "${RED}🔹 Limpando regras de firewall...\033[0m"
$SUDO_CMD iptables -F 2>/dev/null
$SUDO_CMD iptables -t nat -F 2>/dev/null

echo -e "${RED}❌ Tor VPN desativada! Tráfego voltou ao normal.\033[0m"
