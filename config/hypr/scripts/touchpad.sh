 #!/bin/bash

# CONFIG_DIR="$HOME/.config/hypr/scripts"
# TOUCHPAD_CONFIG="touchpad.conf"
CONFIG_FILE="$HOME/.config/hypr/scripts/touchpad.conf"

# Check if the touchpad is currently enabled or disabled
enabled=$(grep -o "enabled\s*=\s*[01]" "$CONFIG_FILE")

# Toggle the touchpad state
if [ "$enabled" == "enabled = 0" ]; then
	sed -i "s/enabled\s*=\s*0/enabled = 1/" "$CONFIG_FILE"
	state="enabled"
else
	sed -i "s/enabled\s*=\s*1/enabled = 0/" "$CONFIG_FILE"
	state="disabled"
fi

if [ "$state" == "enabled" ]; then
	notify-send -u low "Touchpad Enabled" "The touchpad has been enabled."
else
	notify-send -u low "Touchpad Disabled" "The touchpad has been disabled."
fi

echo "Touchpad state toggled." 
