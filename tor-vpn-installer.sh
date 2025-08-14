#!/bin/bash
# tor-vpn-installer.sh
# Instalador Tor VPN híbrido para Linux e Termux

# Cores
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m' # Sem cor

clear
echo -e "${CYAN}╔════════════════════════════════════════════╗"
echo -e "║        🛡  Instalador Tor VPN Híbrido       ║"
echo -e "╚════════════════════════════════════════════╝${NC}"
sleep 0.5

# Detectar ambiente automaticamente
if [ "$PREFIX" = "/data/data/com.termux/files/usr" ]; then
    ENV="2"
    echo -e "${CYAN}⚙️  Detectado Termux...${NC}"
    PACKAGE_MANAGER="pkg"
    TOR_USER="tor"
    SUDO_CMD=""
else
    ENV="1"
    echo -e "${CYAN}⚙️  Detectado Linux...${NC}"
    PACKAGE_MANAGER="apt"
    TOR_USER="debian-tor"
    SUDO_CMD="sudo"
fi
sleep 0.5

# Função para checar comando
check_command() {
    if ! command -v "$1" &> /dev/null; then
        echo -e "${YELLOW}⚠️ $1 não encontrado. Instalando...${NC}"
        $SUDO_CMD $PACKAGE_MANAGER install -y "$1" >/dev/null 2>&1
        echo -e "${GREEN}✔ $1 instalado!${NC}"
        sleep 0.3
    else
        echo -e "${GREEN}✔ $1 já está instalado${NC}"
        sleep 0.2
    fi
}

# Atualizar pacotes
echo -e "${YELLOW}🔄 Atualizando lista de pacotes...${NC}"
$SUDO_CMD $PACKAGE_MANAGER update -y >/dev/null
echo -e "${GREEN}✔ Pacotes atualizados!${NC}"
sleep 0.3

# Instalar dependências
DEPS="tor iptables nano curl net-tools"
for pkg in $DEPS; do
    check_command "$pkg"
done

# Configurar Tor no Linux para TransPort e DNSPort
if [ "$ENV" == "1" ]; then
    echo -e "${YELLOW}⚙️ Configurando Tor para Transparent Proxy...${NC}"
    if ! grep -q "TransPort 9040" /etc/tor/torrc; then
        $SUDO_CMD bash -c 'cat >> /etc/tor/torrc <<EOF
VirtualAddrNetworkIPv4 10.192.0.0/10
AutomapHostsOnResolve 1
TransPort 9040
DNSPort 5353
EOF'
        echo -e "${GREEN}✔ Tor configurado!${NC}"
    else
        echo -e "${GREEN}✔ Tor já estava configurado!${NC}"
    fi
    sleep 0.3
    echo -e "${YELLOW}♻️ Reiniciando Tor...${NC}"
    $SUDO_CMD systemctl restart tor
    $SUDO_CMD systemctl enable tor >/dev/null
    echo -e "${GREEN}✔ Tor iniciado!${NC}"
fi

# Criar script de ativar VPN híbrido
echo -e "${YELLOW}🛠 Criando script tor-vpn-start.sh...${NC}"
cat > tor-vpn-start.sh <<EOF
#!/bin/bash

GREEN='\\033[0;32m'
NC='\\033[0m'

# Detectar sudo
if [ "\$PREFIX" = "/data/data/com.termux/files/usr" ]; then
    SUDO_CMD=""
else
    SUDO_CMD="sudo"
fi

echo -e "\${GREEN}🔹 Desativando IPv6...\${NC}"
\$SUDO_CMD sysctl -w net.ipv6.conf.all.disable_ipv6=1 2>/dev/null
\$SUDO_CMD sysctl -w net.ipv6.conf.default.disable_ipv6=1 2>/dev/null

echo -e "\${GREEN}🔹 Limpando regras antigas de firewall...\${NC}"
\$SUDO_CMD iptables -F 2>/dev/null
\$SUDO_CMD iptables -t nat -F 2>/dev/null

echo -e "\${GREEN}🔹 Aplicando regras Tor VPN...\${NC}"
\$SUDO_CMD iptables -A INPUT -i lo -j ACCEPT
\$SUDO_CMD iptables -A OUTPUT -o lo -j ACCEPT
\$SUDO_CMD iptables -A OUTPUT -m owner --uid-owner $TOR_USER -j ACCEPT
\$SUDO_CMD iptables -t nat -A OUTPUT -p udp --dport 53 -j REDIRECT --to-ports 5353
\$SUDO_CMD iptables -t nat -A OUTPUT -p tcp --syn -j REDIRECT --to-ports 9040

echo -e "\${GREEN}✅ Tor VPN ativada! Teste seu IP:"
curl -s ifconfig.me
EOF
chmod +x tor-vpn-start.sh
echo -e "${GREEN}✔ tor-vpn-start.sh criado!${NC}"

# Criar script de desativar VPN híbrido
echo -e "${YELLOW}🛠 Criando script tor-vpn-stop.sh...${NC}"
cat > tor-vpn-stop.sh <<EOF
#!/bin/bash

RED='\\033[0;31m'
NC='\\033[0m'

# Detectar sudo
if [ "\$PREFIX" = "/data/data/com.termux/files/usr" ]; then
    SUDO_CMD=""
else
    SUDO_CMD="sudo"
fi

echo -e "\${RED}🔹 Restaurando IPv6...\${NC}"
\$SUDO_CMD sysctl -w net.ipv6.conf.all.disable_ipv6=0 2>/dev/null
\$SUDO_CMD sysctl -w net.ipv6.conf.default.disable_ipv6=0 2>/dev/null

echo -e "\${RED}🔹 Limpando regras de firewall...\${NC}"
\$SUDO_CMD iptables -F 2>/dev/null
\$SUDO_CMD iptables -t nat -F 2>/dev/null

echo -e "\${RED}❌ Tor VPN desativada! Tráfego voltou ao normal.\${NC}"
EOF
chmod +x tor-vpn-stop.sh
echo -e "${GREEN}✔ tor-vpn-stop.sh criado!${NC}"

# Finalização
echo -e "${CYAN}╔════════════════════════════════════════════╗"
echo -e "║  ${GREEN}Instalação concluída com sucesso!${CYAN}         ║"
echo -e "║  ${YELLOW}Para ativar:${NC} ./tor-vpn-start.sh ${CYAN}              ║"
echo -e "║  ${YELLOW}Para desativar:${NC} ./tor-vpn-stop.sh ${CYAN}             ║"
echo -e "╚════════════════════════════════════════════╝${NC}"
