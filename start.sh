#!/usr/bin/env bash
set -euo pipefail

export DISPLAY=:1
export HOME=/home/app
mkdir -p "$HOME/.config/openbox" "$HOME/.local/share/applications" "$HOME/Desktop"

cat > "$HOME/.config/openbox/autostart" <<'EOF'
xsetroot -solid "#1e1e1e" || true
xterm -geometry 120x30+20+20 -fa Monospace -fs 10 &
pcmanfm --desktop --profile=default &
firefox-esr --new-window about:blank &
EOF

cat > "$HOME/.config/openbox/menu.xml" <<'EOF'
<openbox_menu>
  <menu id="root-menu" label="Applications">
    <item label="Terminal"><action name="Execute"><command>xterm</command></action></item>
    <item label="File Manager"><action name="Execute"><command>pcmanfm</command></action></item>
    <item label="Firefox"><action name="Execute"><command>firefox-esr</command></action></item>
    <separator/>
    <item label="Restart Openbox"><action name="Restart"/></item>
    <item label="Exit"><action name="Exit"/></item>
  </menu>
</openbox_menu>
EOF

cat > "$HOME/.config/openbox/rc.xml" <<'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<openbox_config xmlns="http://openbox.org/3.4/rc">
  <theme>
    <name>Onyx</name>
    <titleLayout>NLIMC</titleLayout>
  </theme>
  <desktops>
    <number>1</number>
  </desktops>
  <keyboard>
    <keybind key="A-F2">
      <action name="Execute">
        <command>xterm</command>
      </action>
    </keybind>
  </keyboard>
</openbox_config>
EOF

# Lightweight desktop shortcuts
cat > "$HOME/Desktop/Terminal.desktop" <<'EOF'
[Desktop Entry]
Type=Application
Name=Terminal
Exec=xterm
Icon=utilities-terminal
Terminal=false
EOF

cat > "$HOME/Desktop/Firefox.desktop" <<'EOF'
[Desktop Entry]
Type=Application
Name=Firefox
Exec=firefox-esr
Icon=firefox-esr
Terminal=false
EOF

chmod +x "$HOME/Desktop/"*.desktop || true
chown -R app:app "$HOME"

# Keep container alive for supervisor-managed services
tail -f /dev/null
