# 🛡 Tor VPN Installer

Instalador simples e eficiente de **Tor VPN** para **Linux (Debian/Ubuntu)** e **Termux (Android)**.  
Permite configurar o Tor como **proxy transparente** e fornece scripts para **ativar/desativar** a VPN rapidamente.

---

## 📌 Funcionalidades

- Verificação automática de dependências (`tor`, `iptables`, `curl`, `nano`, `net-tools`).  
- Configuração do Tor para **Transparent Proxy** (Linux).  
- Criação de scripts:
  - `tor-vpn-start.sh` → Ativa o Tor VPN, desativa IPv6 e aplica regras de firewall.  
  - `tor-vpn-stop.sh` → Desativa o Tor VPN e restaura IPv6.  
- Suporte para **Linux** e **Termux (Android)**.  
- Interface colorida com mensagens claras e emojis para melhor visualização.

---

## ⚙️ Requisitos

- Sistema Linux baseado em Debian/Ubuntu **ou** Termux no Android.  
- Permissões de sudo (Linux) ou pacote `pkg` (Termux).  
- Conexão à internet ativa.

---

## 🛠 Instalação

1. Faça o download do script:
   ```bash
   wget https://exemplo.com/tor-vpn-installer.sh

