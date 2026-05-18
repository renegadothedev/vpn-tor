@echo off
setlocal
title VPN Manager

echo.
echo --------------------------------------------------------------
echo VPN Manager 2.0.0
echo Interactive VPN manager for OpenVPN and NetworkManager.
echo --------------------------------------------------------------
echo.
echo Detected system: Windows
echo.
echo Windows was not designed to run this script directly.
echo.
echo This project uses Linux commands such as openvpn, nmcli, ip,
echo pgrep, pkill and sudo/root. On native Windows these commands
echo do not control the real system VPN.
echo.
echo Correct usage:
echo   1. Run it on Linux or Termux.
echo   2. Use your VPN provider's official client on Windows.
echo   3. Use WSL only for reading/testing, not as the main VPN.
echo.
echo The script opened, recognized the system and stopped safely.
echo.

if /i not "%VPN_MANAGER_NO_PAUSE%"=="1" pause
exit /b 0
