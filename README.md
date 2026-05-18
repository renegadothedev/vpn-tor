# 🛡️ VPN Manager

<p align="center">
  <strong>A polished interactive VPN manager for Linux and Termux.</strong>
</p>

<p align="center">
  <img alt="Shell" src="https://img.shields.io/badge/Shell-Bash-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white">
  <img alt="Linux" src="https://img.shields.io/badge/Linux-Supported-FCC624?style=for-the-badge&logo=linux&logoColor=black">
  <img alt="Termux" src="https://img.shields.io/badge/Termux-Supported-000000?style=for-the-badge&logo=android&logoColor=3DDC84">
  <img alt="Windows" src="https://img.shields.io/badge/Windows-Detected%20%26%20Blocked-0078D4?style=for-the-badge&logo=windows&logoColor=white">
  <img alt="License" src="https://img.shields.io/badge/License-MIT-blue?style=for-the-badge">
</p>

---

<a id="overview"></a>

## ✨ Overview

**VPN Manager** is an interactive Bash tool for managing VPN connections on
**Linux** and **Termux**. It gives you a clean terminal menu for OpenVPN
profiles, NetworkManager VPN connections, diagnostics, public IP checks, local
repair actions, dependency validation and activity logs.

It also detects **Windows**, **Git Bash**, **MSYS2**, **Cygwin**, **WSL** and
**macOS**. Unsupported systems receive a clear explanation instead of a confusing
failure. On Windows, the script tells the user that Windows was not designed to
run this script directly and stops safely.

> ✅ Built for Linux and Termux.
> 🪟 Windows is recognized, explained and safely blocked.
> 🧰 Designed to be understandable for beginners and useful for power users.

---

## 📚 Table of Contents

- [✨ Overview](#overview)
- [🚀 Features](#features)
- [🧭 Supported Systems](#supported-systems)
- [🪟 Why Windows Is Blocked](#why-windows-is-blocked)
- [📦 Installation](#installation)
- [⚡ Quick Commands](#quick-commands)
- [🖥️ Menu Preview](#menu-preview)
- [🧩 First Setup](#first-setup)
- [🔧 Dependencies](#dependencies)
- [📁 Local Files](#local-files)
- [🩹 Repair Mode](#repair-mode)
- [🔐 Security Notes](#security-notes)
- [🧪 Troubleshooting](#troubleshooting)
- [🧠 Project Philosophy](#project-philosophy)
- [📜 License](#license)
- [👤 Author](#author)

---

<a id="features"></a>

## 🚀 Features

| Feature | Description |
| --- | --- |
| 🟢 OpenVPN support | Connect using `.ovpn` configuration files. |
| 🌐 NetworkManager support | Use existing `nmcli` VPN connections. |
| 🧠 System detection | Detects Linux, Termux, Windows, WSL, macOS and unknown systems. |
| 🪟 Windows safety notice | Explains why native Windows is not supported and exits safely. |
| 🔁 Connection retries | Retries failed connections with a configurable timeout. |
| 📡 Public IP check | Shows your current public IP using a fallback provider. |
| 🧾 Activity history | Stores connection and repair activity locally. |
| 🪵 OpenVPN log | Keeps OpenVPN output in a separate log file. |
| 🧰 Repair mode | Recreates local files, fixes permissions and checks dependencies. |
| 📦 Dependency helper | Offers package installation when a supported package manager exists. |
| 🔒 Safer settings parser | Reads settings as data instead of sourcing shell code. |
| 🧭 Built-in quick guide | Includes a full explanation inside the terminal menu. |

---

<a id="supported-systems"></a>

## 🧭 Supported Systems

| System | Status | What Happens |
| --- | --- | --- |
| 🐧 Linux | ✅ Supported | Full VPN management through OpenVPN or NetworkManager. |
| 🤖 Termux | ✅ Supported | Works with Termux tools and `pkg` when available. |
| 🪟 Windows | ⚠️ Recognized | Shows a clear warning and stops safely. |
| 🧰 Git Bash / MSYS2 / Cygwin | ⚠️ Recognized | Explains that these shells do not control the real Windows VPN stack. |
| 🧪 WSL | ⚠️ Recognized | Useful for reading/testing, not for controlling the Windows VPN. |
| 🍎 macOS | 🚧 Not supported yet | Detected and stopped with an explanation. |
| ❓ Unknown | 🚧 Not supported | Stopped safely with a compatibility message. |

---

<a id="why-windows-is-blocked"></a>

## 🪟 Why Windows Is Blocked

VPN Manager depends on Linux networking behavior and tools:

- `openvpn` to start `.ovpn` profiles.
- `nmcli` to control NetworkManager VPN connections.
- `ip` to inspect network interfaces.
- `pgrep` and `pkill` to find and stop processes.
- `sudo` or root permissions for privileged network operations.

On native Windows, those tools do not manage the real Windows network stack.
Even if the script opens in Git Bash, MSYS2 or Cygwin, the VPN itself is still
controlled by Windows.

That is why VPN Manager does this:

```text
Detected system: Windows

Windows was not designed to run this script directly.
The script ran, recognized the system and stopped safely.
```

✅ For Windows, use your VPN provider's official client.
✅ For this project, use Linux or Termux.

---

<a id="installation"></a>

## 📦 Installation

Clone or download the repository, then make the script executable:

```bash
chmod +x vpn-manager
./vpn-manager
```

Optional system-wide installation:

```bash
sudo install -m 755 vpn-manager /usr/local/bin/vpn-manager
vpn-manager
```

On Windows, open:

```text
vpn-manager.cmd
```

It will show the compatibility message and stop safely.

---

<a id="quick-commands"></a>

## ⚡ Quick Commands

```bash
./vpn-manager
```

Start the interactive menu.

```bash
./vpn-manager --help
```

Show command usage and supported systems.

```bash
./vpn-manager --version
```

Show the current VPN Manager version.

```bash
./vpn-manager --check-platform
```

Print the detected platform and whether it is supported.

---

<a id="menu-preview"></a>

## 🖥️ Menu Preview

```text
----------------------------------------------------------------------------
VPN Manager 2.0.0
Interactive VPN manager for OpenVPN and NetworkManager.
Author: https://github.com/renegadothedev
----------------------------------------------------------------------------
  System:                      Linux
  Profile:                     OpenVPN (.ovpn) - missing .ovpn file
  Local directory:             ~/.vpn-manager

  1) Connect
  2) Disconnect
  3) Status
  4) Show public IP
  5) Configure connection
  6) History
  7) Diagnostics
  8) Repair installation
  9) Quick guide
  0) Exit

Choose an option:
```

---

<a id="first-setup"></a>

## 🧩 First Setup

1. Run the script:

   ```bash
   ./vpn-manager
   ```

2. Open:

   ```text
   Configure connection
   ```

3. Choose your VPN method:

   | Method | Use When |
   | --- | --- |
   | `OpenVPN (.ovpn)` | You have a VPN provider configuration file. |
   | `NetworkManager (nmcli)` | Your VPN already exists as a NetworkManager connection. |

4. Provide the required information:

   - For OpenVPN: the full path to your `.ovpn` file.
   - For NetworkManager: the exact connection name from `nmcli`.

5. Adjust connection retries and timeout if needed.

6. Return to the menu and choose:

   ```text
   Connect
   ```

7. Confirm the result with:

   ```text
   Status
   Diagnostics
   Show public IP
   ```

---

<a id="dependencies"></a>

## 🔧 Dependencies

### Common Tools

| Tool | Purpose |
| --- | --- |
| `bash` | Runs the script. |
| `openvpn` | Starts OpenVPN profiles. |
| `curl` | Looks up the public IP address. |
| `pgrep` | Checks running processes. |
| `ip` | Checks VPN interfaces on Linux. |
| `nmcli` | Controls NetworkManager connections. |
| `sudo` | Runs privileged actions when needed. |

### Supported Package Managers

VPN Manager can offer automatic dependency installation when one of these is
available:

| Package Manager | Environment |
| --- | --- |
| `apt-get` | Debian, Ubuntu and derivatives |
| `dnf` | Fedora and modern RPM systems |
| `yum` | Older RPM systems |
| `pacman` | Arch Linux and derivatives |
| `zypper` | openSUSE |
| `pkg` | Termux |

---

<a id="local-files"></a>

## 📁 Local Files

VPN Manager stores its local data inside the user's home directory:

```text
~/.vpn-manager/settings
~/.vpn-manager/activity.log
~/.vpn-manager/openvpn.log
~/.vpn-manager/openvpn.pid
```

### What Each File Does

| File | Purpose |
| --- | --- |
| `settings` | Stores the selected method, profile path, retries and timeout. |
| `activity.log` | Stores high-level activity history. |
| `openvpn.log` | Stores OpenVPN runtime output. |
| `openvpn.pid` | Stores the OpenVPN process ID when started by the script. |

### Custom Config Directory

If your `HOME` directory cannot be written to, choose another directory:

```bash
VPN_MANAGER_CONFIG_DIR=/tmp/vpn-manager ./vpn-manager
```

Local permissions are adjusted when possible:

```text
Directory:       700
Sensitive files: 600
```

---

<a id="repair-mode"></a>

## 🩹 Repair Mode

The **Repair installation** option is designed for local cleanup and sanity
checks.

It can:

- Recreate the local configuration directory.
- Recreate missing settings and log files.
- Adjust local file permissions.
- Check required commands.
- Offer automatic dependency installation.
- Confirm that the selected VPN method has the tools it needs.

It cannot fix:

- Invalid VPN credentials.
- Broken provider configuration files.
- Blocked networks.
- Provider-side outages.
- Missing kernel support.
- Administrator permission denial.

---

<a id="security-notes"></a>

## 🔐 Security Notes

- Do not run the script as root unless your environment specifically requires
  it.
- On Linux, privileged actions use `sudo` when possible.
- The `settings` file is parsed safely and is not executed as shell code.
- Logs stay local under `~/.vpn-manager`.
- File paths and connection names are validated before connection attempts.
- Windows is blocked intentionally to avoid pretending that a Unix-like shell can
  control the real Windows VPN stack.

---

<a id="troubleshooting"></a>

## 🧪 Troubleshooting

### The VPN does not connect

Try this sequence:

1. Run `Diagnostics`.
2. Run `Repair installation`.
3. Confirm that the `.ovpn` file exists and is readable.
4. Confirm that the `nmcli` connection name is exact.
5. Check `~/.vpn-manager/openvpn.log`.
6. Make sure your user can run privileged commands through `sudo`.
7. Test the VPN with your provider's official client.

### Windows opens the script but does not connect

That is expected. Windows is detected and blocked on purpose.

Use:

```text
vpn-manager.cmd
```

It displays the compatibility explanation clearly.

### My home directory is read-only

Use a custom configuration directory:

```bash
VPN_MANAGER_CONFIG_DIR=/tmp/vpn-manager ./vpn-manager
```

### I do not know which method to choose

Use this rule:

| Situation | Choose |
| --- | --- |
| You have a `.ovpn` file | OpenVPN |
| Your VPN already appears in NetworkManager | NetworkManager |
| You are on Windows | Official Windows VPN client |
| You are on Termux | OpenVPN |

---

<a id="project-philosophy"></a>

## 🧠 Project Philosophy

VPN Manager is meant to be:

- **Clear**: every unsupported platform gets an explanation.
- **Practical**: common VPN tasks stay one menu away.
- **Recoverable**: local repair actions are built in.
- **Safe**: settings are not executed as shell code.
- **Honest**: Windows support is not faked.

---

<a id="license"></a>

## 📜 License

This project is released under the **MIT License**.

See [LICENSE.txt](LICENSE.txt) for details.

---

<a id="author"></a>

## 👤 Author

Created by [renegadothedev](https://github.com/renegadothedev).

If this project helped you, consider starring the repository ⭐
