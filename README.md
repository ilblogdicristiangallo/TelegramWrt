# TelegramWrt

<img src="https://raw.githubusercontent.com/ilblogdicristiangallo/TelegraWrt/main/logo_telegramwrt.jpg" alt="TelegramWrt OpenWRT Logo" width="400">

TelegramWrt is a modular package for OpenWrt that integrates a Telegram bot with advanced diagnostics, monitoring, and remote control capabilities. Each plugin is designed to be extensible, reproducible, and compatible across multiple architectures.

## 📦 Requirements V.1.0, V1.0.1 and V1.0.2 (Manual install dependency)

Before using TelegramWrt, make sure the following packages are installed:
<pre>
opkg update
opkg install wget
opkg install jq
opkg install curl
opkg install bash
opkg install tcpdump
</pre>

## 📦 Requirements V1.0.5 (Dependency auto-install)
<pre>opkg update
opkg /tmp/install telegramwrt_1.0.5_all.ipk</pre>

⚙️ Initial Configuration
After installation, configure the bot by editing the file:
<pre>vi /usr/lib/TelegramWrt/config
</pre>

Insert your TOKEN and CHATID:

<pre>TOKEN="123456789:ABCdefGhIjKlMnOpQrStUvWxYz"
CHAT_ID="987654321"
</pre>

# 🔐 The TOKEN is generated via BotFather on Telegram. The CHATID can be retrieved by sending a message to the bot and reading the response via logging or diagnostic plugins.

# 🚀 Installation
Install the .ipk package with:
<pre>opkg install /tmp/telegramwrt_1.0.5_all.ipk
</pre>

The package installs the bot and all plugins under /usr/lib/TelegramWrt/.

🧩 Supported Telegram Commands
TelegramWrt includes the following modules, each triggered via a Telegram command:

<markdown-accessiblity-table data-catalyst="">
  <table border="1" style="border-collapse: collapse; width: 100%;">
    <thead>
      <tr>
        <th scope="col" style="text-align: left; padding: 8px;">Telegram Command</th>
        <th scope="col" style="text-align: left; padding: 8px;">Function</th>
      </tr>
    </thead>
    <tbody>
      <tr><td style="padding: 8px;">/ssh_status</td><td style="padding: 8px;">Check if SSH is active and which port is used</td></tr>
      <tr><td style="padding: 8px;">/open_ports</td><td style="padding: 8px;">List open ports and active services</td></tr>
      <tr><td style="padding: 8px;">/firewall_rules</td><td style="padding: 8px;">Show current firewall rules</td></tr>
      <tr><td style="padding: 8px;">/block_ip</td><td style="padding: 8px;">Block a specific IP address</td></tr>
      <tr><td style="padding: 8px;">/mac_watch</td><td style="padding: 8px;">Alert if unknown MAC addresses connect</td></tr>
      <tr><td style="padding: 8px;">/vpn_status</td><td style="padding: 8px;">Show VPN connection status</td></tr>
      <tr><td style="padding: 8px;">/vpn_start</td><td style="padding: 8px;">Enable VPN auto-start at boot, restart interfaces, and display public IP</td></tr>
      <tr><td style="padding: 8px;">/vpn_stop</td><td style="padding: 8px;">Stop VPN interfaces and disable auto-start (with router reboot)</td></tr>
      <tr><td style="padding: 8px;">/vpn_restart</td><td style="padding: 8px;">Restart VPN interfaces and show public IP</td></tr>
      <tr><td style="padding: 8px;">/devices</td><td style="padding: 8px;">List connected devices via DHCP and Wi-Fi</td></tr>
      <tr><td style="padding: 8px;">/wifi_enable</td><td style="padding: 8px;">Enable the router's Wi-Fi interface</td></tr>
      <tr><td style="padding: 8px;">/wifi_disable</td><td style="padding: 8px;">Disable the router's Wi-Fi interface</td></tr>
      <tr><td style="padding: 8px;">/restart_wifi</td><td style="padding: 8px;">Restart the router's Wi-Fi interface (useful to renew connection)</td></tr>
      <tr><td style="padding: 8px;">/restart_wan</td><td style="padding: 8px;">Restart the router's WAN interface (renew Internet connection)</td></tr>
      <tr><td style="padding: 8px;">/wan_stop</td><td style="padding: 8px;">Disable the router's WAN interface (stop Internet connection)</td></tr>
      <tr><td style="padding: 8px;">/wifi_status</td><td style="padding: 8px;">Show wireless interface status</td></tr>
      <tr><td style="padding: 8px;">/wan_ip</td><td style="padding: 8px;">Display public IP and gateway</td></tr>
      <tr><td style="padding: 8px;">/ping_sweep</td><td style="padding: 8px;">Scan subnet for active IPs</td></tr>
      <tr><td style="padding: 8px;">/ping_test</td><td style="padding: 8px;">Run a ping test to an external host</td></tr>
      <tr><td style="padding: 8px;">/dns_status</td><td style="padding: 8px;">Show current DNS configuration</td></tr>
      <tr><td style="padding: 8px;">/dhcp_leases</td><td style="padding: 8px;">List active DHCP leases</td></tr>
      <tr><td style="padding: 8px;">/sms_receive</td><td style="padding: 8px;">Read SMS messages received by the modem (with automatic fallback)</td></tr>
      <tr><td style="padding: 8px;">/sms_delete</td><td style="padding: 8px;">Delete all SMS messages from modem and SIM memory (with port-aware verification)</td></tr>
      <tr><td style="padding: 8px;">/tcpdump_dns</td><td style="padding: 8px;">Capture DNS traffic briefly. Shows client IP, DNS server, and requested domain (only if DNS is not encrypted)</td></tr>
      <tr><td style="padding: 8px;">/status</td><td style="padding: 8px;">Show bot status and connection</td></tr>
      <tr><td style="padding: 8px;">/uptime</td><td style="padding: 8px;">Display router uptime</td></tr>
      <tr><td style="padding: 8px;">/cpu_load</td><td style="padding: 8px;">Show CPU load and temperature</td></tr>
      <tr><td style="padding: 8px;">/ram_usage</td><td style="padding: 8px;">Display memory usage</td></tr>
      <tr><td style="padding: 8px;">/disk_space</td><td style="padding: 8px;">Show available disk space</td></tr>
      <tr><td style="padding: 8px;">/log_tail</td><td style="padding: 8px;">Show last system log entries</td></tr>
      <tr><td style="padding: 8px;">/reboot</td><td style="padding: 8px;">Reboot the router</td></tr>
      <tr><td style="padding: 8px;">/restart_bot</td><td style="padding: 8px;">Restart the Telegram bot</td></tr>
      <tr><td style="padding: 8px;">/update_bot</td><td style="padding: 8px;">Update bot script from remote source</td></tr>
      <tr><td style="padding: 8px;">/backup_config</td><td style="padding: 8px;">Backup OpenWrt configuration</td></tr>
      <tr><td style="padding: 8px;">/restore_config</td><td style="padding: 8px;">Restore configuration from backup</td></tr>
      <tr><td style="padding: 8px;">/start</td><td style="padding: 8px;">Show this command list</td></tr>
      <tr><td style="padding: 8px;">/help</td><td style="padding: 8px;">Extended command descriptions</td></tr>
      <tr><td style="padding: 8px;">/opkg_installed</td><td style="padding: 8px;">List installed packages (names only)</td></tr>
      <tr><td style="padding: 8px;">/opkg_update</td><td style="padding: 8px;">Update package repositories</td></tr>
      <tr><td style="padding: 8px;">/opkg_install</td><td style="padding: 8px;">Install a package from repository by name</td></tr>
      <tr><td style="padding: 8px;">/opkg_remove</td><td style="padding: 8px;">Remove an installed package by name</td></tr>
    </tbody>
  </table>
</markdown-accessiblity-table>



# 📤 Usage Example

Once configured, send a command to the bot:
<pre>/status
</pre>

# 🔁 Automatic Bot Startup

To ensure that TelegramWrt starts automatically every time your OpenWrt device reboots, add the following command to the rc.local file:
<pre>bash /usr/lib/TelegramWrt/telegram.sh &
</pre>
# or 
<pre>sh /usr/lib/TelegramWrt/telegram.sh &</pre>

# 📌 Steps:

Open the rc.local file with a text editor:

<pre>vi /etc/rc.local</pre>

Insert the command before the line exit 0:

<pre>bash /usr/lib/TelegramWrt/telegram.sh &</pre>
# News v1.0.2 message_reboot
<pre>bash /usr/lib/TelegramWrt/plugins/message_router &</pre>
# or 
<pre>sh /usr/lib/TelegramWrt/plugins/message_router &</pre>

Save and exit (ctrt+c, then :wq!).

# ✅ The & symbol is essential: it runs the bot in the background, preventing it from blocking the boot process.

# 🖥️ Installing TelegramWrt with WinSCP
WinSCP is a Windows SFTP client that allows easy file transfers between your PC and OpenWrt router using a graphical interface.

# Requirements
OpenWrt router with SSH access enabled

WinSCP installed on your PC: Download WinSCP

telegramwrt_1.0.0_all.ipk file saved on your computer

# 📌 Steps
Launch WinSCP and create a new connection:

Protocol: SCP or SFTP

Host name: Router IP (e.g., 192.168.1.1)

Username: root

Password: (your router password)

Connect and navigate to the /tmp directory on the router.

Drag and drop the telegramwrt_1.0.3_all.ipk file from your PC into the router’s /tmp folder.

Open a terminal session directly from WinSCP (menu “Commands” → “Open Terminal”) or use PuTTY.

Install the package with the command:

<pre>opkg install /tmp/telegramwrt_1.0.3_all.ipk
</pre>

# Screen use TelegramWrt_V1.0.5

<img src="https://github.com/ilblogdicristiangallo/TelegramWrt/blob/main/ScreenShot/telegramwrt-v.1.0.4.png?raw=true" 
     alt="TelegramWrt bot interface screenshot" 
     width="600" />

<img src="https://github.com/ilblogdicristiangallo/TelegramWrt/blob/main/ScreenShot/telegramwrt-v.1.0.4_1.png?raw=true" 
     alt="TelegramWrt bot interface second screenshot" 
     width="600" />

<img src="https://github.com/ilblogdicristiangallo/TelegramWrt/blob/main/ScreenShot/telegramwrt-v.1.0.4_2.png?raw=true" 
     alt="TelegramWrt bot interface second screenshot" 
     width="600" />

# News reboot message V1.0.2

<img src="https://github.com/ilblogdicristiangallo/TelegramWrt/blob/main/ScreenTelegramWrt1.0.2._3.png?raw=true" 
     alt="TelegramWrt reboot message screenshot" 
     width="600" />

# News sms V1.0.3
<img src="https://github.com/ilblogdicristiangallo/TelegramWrt/blob/main/telegramwrt_1.0.3_sms_screen.png?raw=true"
     alt="TelegramWrt sms message screenshot" 
     width="600" />

# Visit my blog
https://www.ilblogdicristiangallo.com
