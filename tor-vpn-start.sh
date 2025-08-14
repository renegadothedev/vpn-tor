#!/bin/bash

GREEN='\033[0;32m'
NC='\033[0m'

# Função para checar se comando existe
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

echo -e "${GREEN}🔹 Iniciando configuração Tor VPN híbrida...\033[0m"

# Verifica se está no Termux
if [ "$PREFIX" = "/data/data/com.termux/files/usr" ]; then
    echo -e "${GREEN}⚡ Detectado Termux...\033[0m"
    SUDO_CMD=""
else
    echo -e "${GREEN}⚡ Detectado Linux normal...\033[0m"
    SUDO_CMD="sudo"
fi

# Desativar IPv6
echo -e "${GREEN}🔹 Desativando IPv6...\033[0m"
if command_exists sysctl; then
    $SUDO_CMD sysctl -w net.ipv6.conf.all.disable_ipv6=1 2>/dev/null
    $SUDO_CMD sysctl -w net.ipv6.conf.default.disable_ipv6=1 2>/dev/null
else
    echo -e "${GREEN}⚠ sysctl não encontrado, pulando IPv6...\033[0m"
fi

# Limpar regras antigas de firewall
echo -e "${GREEN}🔹 Limpando regras antigas de firewall...\033[0m"
if command_exists iptables; then
    $SUDO_CMD iptables -F 2>/dev/null
    $SUDO_CMD iptables -t nat -F 2>/dev/null
else
    echo -e "${GREEN}⚠ iptables não encontrado, pulando limpeza...\033[0m"
fi

# Aplicar regras Tor VPN
echo -e "${GREEN}🔹 Aplicando regras Tor VPN...\033[0m"
if command_exists iptables; then
    $SUDO_CMD iptables -A INPUT -i lo -j ACCEPT
    $SUDO_CMD iptables -A OUTPUT -o lo -j ACCEPT

    # Verifica se usuário debian-tor existe
    if id "debian-tor" >/dev/null 2>&1; then
        $SUDO_CMD iptables -A OUTPUT -m owner --uid-owner debian-tor -j ACCEPT
    fi

    $SUDO_CMD iptables -t nat -A OUTPUT -p udp --dport 53 -j REDIRECT --to-ports 5353
    $SUDO_CMD iptables -t nat -A OUTPUT -p tcp --syn -j REDIRECT --to-ports 9040
else
    echo -e "${GREEN}⚠ iptables não disponível, regras não aplicadas...\033[0m"
fi

# Mostrar IP público
echo -e "${GREEN}✅ Tor VPN ativada! Teste seu IP:\033[0m"
if command_exists curl; then
    curl -s ifconfig.me
else
    echo -e "${GREEN}⚠ curl não encontrado, não é possível mostrar IP...\033[0m"
fi
