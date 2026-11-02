@echo off
setlocal
title VPN Manager — Windows Compatibility Notice
echo.
echo VPN Manager 2.1.0
echo.
echo This VPN manager runs on Linux.
echo Windows, Git Bash, MSYS2, Cygwin and WSL cannot use this
echo script to safely configure the host Windows VPN stack.
echo.
echo Please use your VPN provider's official Windows application.
echo For Linux, run ./vpn-manager inside a Bash terminal.
echo.
if /i not "%VPN_MANAGER_NO_PAUSE%"=="1" pause
exit /b 0
