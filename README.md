# VPN Manager

VPN Manager is an interactive Bash tool for managing VPN connections on Linux and Termux. It supports OpenVPN configuration files and NetworkManager connections, keeps a local activity log, validates settings before connecting, and includes repair and diagnostics actions for common setup problems.

## Features

- OpenVPN support through `.ovpn` files.
- NetworkManager support through `nmcli`.
- Linux and Termux environment detection.
- Guided connection setup.
- Automatic local configuration repair.
- Optional dependency installation when a supported package manager is available.
- Connection retries with configurable timeout.
- Safer settings loading without executing the settings file.
- Activity log and separate OpenVPN log.
- Diagnostics screen with environment, profile, and status details.
- Public IP lookup with fallback provider.

## Requirements

VPN Manager needs Bash and the tools required by your selected VPN method.

Common dependencies:

- `openvpn` for OpenVPN profiles.
- `nmcli` for NetworkManager profiles.
- `curl` for public IP lookup.
- `ip` for Linux interface checks.
- `pgrep` for process checks.
- `sudo` on Linux when privileged VPN actions are required.

Supported package managers for automatic dependency installation:

- `apt-get`
- `dnf`
- `yum`
- `pacman`
- `zypper`
- `pkg` on Termux

## Installation

```bash
chmod +x vpn-manager
./vpn-manager
```

Optional system-wide installation:

```bash
sudo install -m 755 vpn-manager /usr/local/bin/vpn-manager
vpn-manager
```

## Usage

Run the script and choose an action from the menu:

```bash
./vpn-manager
```

Menu options:

1. Connect
2. Disconnect
3. Check status
4. Show public IP
5. Configure connection
6. View history
7. Diagnostics
8. Repair installation
9. Exit

## First Setup

Choose `Configure connection`, then select one of the supported methods:

- `OpenVPN (.ovpn file)`: provide the full path to your `.ovpn` file.
- `NetworkManager`: choose an existing NetworkManager connection name.

You can also configure:

- Connection retry count.
- Connection timeout in seconds.

Settings are saved in:

```text
~/.vpn-manager/settings
```

## Logs

VPN Manager stores logs locally:

```text
~/.vpn-manager/activity.log
~/.vpn-manager/openvpn.log
```

Use `View history` for recent activity, or `Diagnostics` to see the active profile and environment details.

## Repair Behavior

The `Repair installation` option:

- Recreates missing local configuration files.
- Fixes local file permissions where possible.
- Checks required commands for the selected VPN method.
- Offers automatic dependency installation when supported.

The script can recover from common local problems, but it cannot guarantee success when the failure is outside its control, such as invalid VPN credentials, blocked networks, missing kernel VPN support, broken provider configuration, or denied administrator permissions.

## Security Notes

- Do not run the script as root unless your environment specifically requires it.
- On Linux, privileged actions are executed through `sudo` when needed.
- The settings file is parsed safely and is not sourced as executable shell code.
- Logs remain local under `~/.vpn-manager`.

## Troubleshooting

If connection fails:

1. Run `Diagnostics`.
2. Run `Repair installation`.
3. Confirm that the `.ovpn` file or NetworkManager profile is valid.
4. Check `~/.vpn-manager/openvpn.log` for provider or authentication errors.
5. Confirm that your user can run privileged VPN commands through `sudo`.

## License

MIT. See [LICENSE.txt](LICENSE.txt).

## Author

Created by [renegadothedev](https://github.com/renegadothedev).
