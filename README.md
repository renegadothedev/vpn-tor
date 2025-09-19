# 🔒 VPN Manager - Solução Completa de Gestão de VPN

[![GitHub](https://img.shields.io/badge/GitHub-renegadothedev-blue?logo=github)](https://github.com/renegadothedev)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform: Linux](https://img.shields.io/badge/Platform-Linux%20%7C%20Termux-green.svg)](https://ubuntu.com/)
[![Shell: Bash](https://img.shields.io/badge/Shell-Bash4.0+-lightgrey.svg)](https://www.gnu.org/software/bash/)

## 📖 Índice

1. [📋 Visão Geral](#-visão-geral)
2. [✨ Funcionalidades](#-funcionalidades)
3. [🚀 Começar Rápido](#-começar-rápido)
4. [📦 Requisitos do Sistema](#-requisitos-do-sistema)
5. [🔧 Instalação Detalhada](#-instalação-detalhada)
6. [🎮 Guia de Utilização](#-guia-de-utilização)
7. [⚙️ Configuração Avançada](#-configuração-avançada)
8. [🔍 Métodos de Conexão Suportados](#-métodos-de-conexão-suportados)
9. [📊 Estrutura de Ficheiros](#-estrutura-de-ficheiros)
10. [🐛 Resolução de Problemas](#-resolução-de-problemas)
11. [🔒 Considerações de Segurança](#-considerações-de-segurança)
12. [🤝 Contribuindo](#-contribuindo)
13. [❓ Perguntas Frequentes](#-perguntas-frequentes)
14. [📞 Suporte](#-suporte)
15. [📄 Licença](#-licença)
16. [👥 Autor](#-autor)

## 📋 Visão Geral

O **VPN Manager** é uma solução abrangente e altamente personalizável para gestão de conexões VPN em ambientes Linux e Termux. Desenvolvido com foco em simplicidade, segurança e eficiência, esta ferramenta elimina a complexidade tradicional associada à gestão manual de VPNs através de linha de comando.

Com uma interface intuitiva baseada em menus, gestão automática de configurações, e suporte para múltiplos protocolos, o VPN Manager torna-se a ferramenta ideal tanto para utilizadores iniciantes como avançados que necessitam de uma gestão fiável e consistente das suas conexões VPN.

---

## ✨ Funcionalidades

### 🔄 Gestão de Conexões
- **Ativação/Desativação Instantânea** com verificação automática de estado
- **Suporte Multiplataforma** completo para Linux desktop e ambiente Termux
- **Reconexão Automática** em caso de falha de conexão
- **Gestão de Múltiplos Perfis** com configuração persistente

### 🎯 Interface de Utilizador
- **Menu Interativo Intuitivo** com opções numeradas
- **Feedback Visual Colorido** para fácil identificação de estados
- **Logs Detalhados** com carimbo de data/hora
- **Progresso em Tempo Real** durante operações

### 🔧 Configuração
- **Configuração Guiada** na primeira execução
- **Armazenamento Persistente** de definições entre sessões
- **Suporte para Múltiplos Métodos** de conexão VPN
- **Backup Automático** de configurações

### 📊 Monitorização
- **Verificação de Estado** em tempo real da conexão VPN
- **Deteção Automática** de interfaces de rede
- **Teste de Conectividade** integrado
- **Visualização de IP Público** com múltiplos fornecedores

### 🔒 Segurança
- **Execução sem Privilégios Root** por padrão
- **Gestão Segura** de processos
- **Logs Locais** sem transmissão de dados
- **Validação Rigorosa** de configurações

---

## 🚀 Começar Rápido

### Instalação em 4 Passos:

```bash
# 1. Transferir o script
git clone https://github.com/renegadothedev/vpn-tor/tree/main

# 2. Entrar no diretorio
cd vpn-tor

# 3. Tornar executável
chmod +x vpn-manager

# 4. Executar
./vpn-manager
