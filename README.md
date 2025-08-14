<div align="center">

# 🛡️ Tor VPN Installer

**Instalador simples e eficiente do Tor VPN para Linux e Termux (Android)**
Transforme sua conexão em um **proxy transparente** com apenas alguns comandos.

![Shell Script](https://img.shields.io/badge/Shell_Script-121011?style=for-the-badge\&logo=gnu-bash\&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge\&logo=linux\&logoColor=black)
![Android](https://img.shields.io/badge/Termux-000000?style=for-the-badge\&logo=android\&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)

</div>

---

## ✨ Recursos

* 🔍 **Verificação automática de dependências**: `tor`, `iptables`, `curl`, `nano`, `net-tools`.
* 🌐 **Configuração transparente do Tor** (Transparent Proxy).
* ⚡ **Scripts prontos para uso**:

  * `tor-vpn-start.sh` → Ativa o Tor VPN, desativa IPv6 e aplica regras de firewall.
  * `tor-vpn-stop.sh` → Desativa o Tor VPN e restaura IPv6.
* 💻 **Compatibilidade**: Linux (Debian/Ubuntu) e Termux (Android).
* 🎨 **Interface colorida** com mensagens claras e emojis.

---

## 📦 Pré-requisitos

* Linux baseado em **Debian/Ubuntu** ou **Termux** no Android.
* Permissões de **sudo** (Linux) ou pacote `pkg` (Termux).
* Conexão com a internet.

---

## 🚀 Instalação

```bash
# 1. Baixe o instalador
wget https://exemplo.com/tor-vpn-installer.sh

# 2. Dê permissão de execução
chmod +x tor-vpn-installer.sh

# 3. Execute o script
./tor-vpn-installer.sh
```

---

## 📚 Uso Rápido

```bash
# Ativar Tor VPN
./tor-vpn-start.sh

# Desativar Tor VPN
./tor-vpn-stop.sh
```

---

## 📂 Estrutura do Projeto

```
📦 TorVPN
 ├── tor-vpn-installer.sh   # Instalador principal
 ├── tor-vpn-start.sh       # Script de ativação
 ├── tor-vpn-stop.sh        # Script de desativação
 └── README.md
```

---

## ⚠️ Aviso Legal

Este projeto é fornecido **apenas para fins educacionais**.
O uso indevido pode violar leis locais.
**Você é responsável por como utilizar este software.**

---

<div align="center">
Feito por <a href="[Renegado](https://github.com/joaobarbosa0m)"></a>
</div>
