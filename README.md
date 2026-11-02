# VPN Manager

**Version 2.1.0** — an interactive VPN controller for Linux, using OpenVPN profiles or existing NetworkManager VPN connections.

> Connection safety is the priority: disconnect operations target only the managed OpenVPN process or the explicitly selected NetworkManager VPN UUID. Other VPN sessions are not intentionally stopped.

## What it does

- Starts OpenVPN with an existing provider `.ovpn` configuration.
- Starts and stops existing NetworkManager VPN or WireGuard profiles using `nmcli`.
- Checks the **selected** connection, not every VPN interface on the machine.
- Supports 1–10 retries with connection timeouts of 5–120 seconds.
- Saves private local settings, activity history and OpenVPN output.
- Can offer to install the required tool for the selected connection method.
- Checks the operating system and refuses unsupported native Windows, WSL and macOS setups.
- Uses HTTPS for public IP lookup; the IP lookup is **not proof of VPN protection**.

**Important:** This project does not create a VPN server, provide VPN credentials, include a kill switch or configure Tor. Despite the repository name, it is not a Tor client. Always check DNS, IPv4, IPv6 and traffic routing independently when privacy matters.

## Platforms

| Platform | Support |
| --- | --- |
| Linux (Ubuntu, Debian, Fedora, Arch, openSUSE, etc.) | Supported with OpenVPN or NetworkManager and appropriate permissions |
| Termux | Experimental OpenVPN-only; needs a functional TUN device and VPN privileges, typically root. Standard unrooted Termux cannot establish system VPN tunnels. |
| Native Windows, Git Bash, Cygwin, MSYS2 | Compatibility notice only; use a native VPN application |
| WSL | Compatibility notice only; cannot be used to configure the host Windows VPN |
| macOS | Unsupported |

## Install

```bash
git clone https://github.com/renegadothedev/vpn-tor.git
cd vpn-tor
chmod +x vpn-manager
./vpn-manager
```

Optional system-wide installation:

```bash
sudo install -m 755 vpn-manager /usr/local/bin/vpn-manager
vpn-manager
```

Available flags:

```bash
./vpn-manager --help
./vpn-manager --version
./vpn-manager --check-platform
```

## Configure and connect

1. Open the interactive menu and select **Configure connection**.
2. For OpenVPN, select a valid `.ovpn` file supplied by a trusted provider. For NetworkManager, enter an existing VPN connection's exact name.
3. Choose the retry count (1–10) and timeout (5–120 seconds).
4. Choose **Connect** and authorize system-level actions only when you trust the profile and have administrative privileges.
5. Use **Status** and **Diagnostics** to verify the configured VPN's state.
6. Choose **Disconnect** to stop the configured VPN.

### How status checks work

- **OpenVPN:** reads the saved PID, verifies that its process command matches `openvpn --config <configured-file>`, and checks for `Initialization Sequence Completed` in the current session log.
- **NetworkManager:** identifies the connection UUID and checks whether that UUID is active.
- **Other VPNs:** ignored. A random active tunnel will not make this application's configured VPN appear connected.

On Linux, OpenVPN process verification relies on `/proc/<pid>/cmdline`. If the system hides that information, disconnect fails conservatively rather than killing an unverified process.

## Local data

The program creates `~/.vpn-manager` with restricted permissions:

| File | Role |
| --- | --- |
| `settings` | VPN method, selected profile, retries and timeout |
| `activity.log` | Connection activity |
| `openvpn.log` | OpenVPN output for the most recent attempt |
| `openvpn.pid` | Process ID of the OpenVPN instance started by this tool |

Set `VPN_MANAGER_CONFIG_DIR=/your/private/path` to use an alternate location.

Settings are parsed as data, not executed as shell code. Updates use a temporary file and atomic rename. The manager refuses symlinks at the configured local file paths. **Use a private, trusted configuration directory.** Symlink checks do not eliminate every possible race condition if another user can write to a parent directory.

## Dependencies

- Bash
- OpenVPN for the OpenVPN connection method, or `nmcli` for NetworkManager
- `sudo` or suitable system privileges when needed
- `curl` only when using the public IP feature
- Standard shell utilities

Dependency installation is optional and asks first. Supported package managers include `apt-get`, `dnf`, `yum`, `pacman`, `zypper` and Termux `pkg`.

## Tests

Run the offline suite without a real VPN connection:

```bash
bash -n vpn-manager
bash tests/test.sh
```

GitHub Actions runs the offline checks on pushes and pull requests. This does **not** replace testing a real VPN connection or validating that traffic takes a secure route.

## Troubleshooting

- **Cannot connect:** inspect the OpenVPN log, profile, provider credentials and required TUN or administrator permissions.
- **Status shows inactive:** the configured connection may be unavailable or the managed process cannot be verified.
- **Cannot disconnect:** the manager deliberately refuses to signal an unidentified process. Inspect the OpenVPN PID and process manually.
- **NetworkManager not found:** import your VPN first and select its exact connection name.
- **Termux fails:** most Android installations do not allow creating a VPN tunnel directly from an unrooted terminal. Use Android's VPN APIs through an appropriate application.
- **Windows shows an informational message:** intentional; this Bash project manages Linux networking.

## License

MIT. See [LICENSE.txt](LICENSE.txt). The original copyright attribution is preserved.

## Author

[renegadothedev](https://github.com/renegadothedev) — open-source tools, Linux and automation.
