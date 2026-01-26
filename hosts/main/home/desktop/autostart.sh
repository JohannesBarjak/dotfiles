# Start portals.
systemctl --user start xdg-desktop-portal
systemctl --user start xdg-desktop-portal-wlr
systemctl --user start xdg-desktop-portal-gtk

# Ensure that system services are started.
systemctl --user start waybar
systemctl --user start swayidle
