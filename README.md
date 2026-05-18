# VPN Manager

VPN Manager is an interactive Bash tool for VPN connections on Linux and
Termux. It organizes OpenVPN profiles (`.ovpn`) and NetworkManager connections
(`nmcli`) in a simple menu with diagnostics, history, local repair and
dependency validation.

The project also recognizes Windows, Git Bash, MSYS2, Cygwin, WSL and macOS.
Those systems receive an explanatory screen and the script stops safely because
real VPN management depends on Linux networking tools and permissions.

## What It Does

- Connects and disconnects VPNs through OpenVPN.
- Connects and disconnects VPNs through NetworkManager.
- Detects Linux, Termux, Windows, WSL, macOS and unknown systems.
- Stops on Windows with a clear message: Windows was not designed to run this
  script directly.
- Checks VPN status through processes, active connections and `tun`, `tap`,
  `ppp` and `wg` interfaces.
- Looks up the public IP address with a fallback provider.
- Saves local settings safely without executing the settings file as shell code.
- Keeps an activity history.
- Keeps a separate OpenVPN log.
- Repairs local files and permissions.
- Offers automatic dependency installation when a supported package manager is
  available.
- Includes a large, objective quick guide inside the menu.

## Supported Systems

| System | Status | Note |
| --- | --- | --- |
| Linux | Supported | Main project environment. |
| Termux | Supported | Uses `pkg` when available. |
| Windows | Recognized | Shows a warning and stops safely. |
| Git Bash / MSYS2 / Cygwin | Recognized | Does not control the real Windows VPN. |
| WSL | Recognized | Useful for reading/testing, not for the main Windows VPN. |
| macOS | Recognized | Not supported yet. |

## Why Windows Is Blocked

VPN Manager uses Linux tools:

- `openvpn` to start `.ovpn` profiles.
- `nmcli` to control NetworkManager connections.
- `ip` to inspect network interfaces.
- `pgrep` and `pkill` to locate processes.
- `sudo` or root for privileged operations.

On native Windows, these commands do not manage the system network stack. The
script may open in some terminals, but that does not mean it can control a
Windows VPN. That is why it detects the system and explains the reason.

For Windows, use your VPN provider's official client.

## Installation

Clone or download the repository and make the script executable:

```bash
chmod +x vpn-manager
./vpn-manager
```

Optional system-wide installation:

```bash
sudo install -m 755 vpn-manager /usr/local/bin/vpn-manager
vpn-manager
```

On Windows, open `vpn-manager.cmd` to see the compatibility message.

## Quick Commands

```bash
./vpn-manager
./vpn-manager --help
./vpn-manager --version
./vpn-manager --check-platform
```

## Main Menu

```text
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
```

## First Use

1. Run `./vpn-manager`.
2. Open `Configure connection`.
3. Choose a method:
   - `OpenVPN (.ovpn)` for a configuration file.
   - `NetworkManager (nmcli)` for an existing connection.
4. Enter the `.ovpn` file path or the exact connection name.
5. Adjust retries and timeout if needed.
6. Return to the menu and choose `Connect`.
7. Use `Status` or `Diagnostics` to confirm the result.

## Dependencies

Common dependencies:

- `bash`
- `openvpn`
- `curl`
- `pgrep`
- `ip` on Linux
- `nmcli` when using NetworkManager
- `sudo` when the action requires administrative privileges

Recognized package managers:

- `apt-get`
- `dnf`
- `yum`
- `pacman`
- `zypper`
- `pkg` on Termux

## Local Files

VPN Manager stores everything in the user's directory:

```text
~/.vpn-manager/settings
~/.vpn-manager/activity.log
~/.vpn-manager/openvpn.log
~/.vpn-manager/openvpn.pid
```

If your `HOME` directory cannot be written to, choose another directory:

```bash
VPN_MANAGER_CONFIG_DIR=/tmp/vpn-manager ./vpn-manager
```

Local permissions are adjusted when possible:

- Directory: `700`
- Sensitive files: `600`

## Repair Installation

The `Repair installation` option does the following:

- Recreates the local directory if missing.
- Recreates settings and log files.
- Adjusts permissions.
- Checks required commands.
- Offers to install missing dependencies when the package manager is supported.

It helps with local problems, but it cannot fix invalid credentials, provider
blocks, blocked networks, broken `.ovpn` files or missing administrative
permissions.

## Security

- Do not run as root unless your environment requires it.
- On Linux, privileged actions use `sudo` when possible.
- The `settings` file is read as data, not shell code.
- Logs stay inside `~/.vpn-manager`.
- File paths and connection names are validated before connection attempts.

## Troubleshooting

If the VPN does not connect:

1. Run `Diagnostics`.
2. Run `Repair installation`.
3. Confirm that the `.ovpn` file exists and is readable.
4. Confirm that the `nmcli` connection name is correct.
5. Check `~/.vpn-manager/openvpn.log`.
6. Verify that your user can run commands through `sudo`.
7. Test the VPN with the provider's official client to rule out external issues.

## License

MIT. See [LICENSE.txt](LICENSE.txt).

## Author

Created by [renegadothedev](https://github.com/renegadothedev).
