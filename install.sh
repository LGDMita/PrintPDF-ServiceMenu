#!/bin/bash
# Universal installer for KDE Print PDF Service Menu

# Service menu folder
SERVICE_DIR="$HOME/.local/share/kio/servicemenus"
mkdir -p "$SERVICE_DIR"

# Copy the service menu
cp print_pdf.desktop "$SERVICE_DIR/"
echo "Service menu installed in $SERVICE_DIR/"

# Copy the script
LOCAL_BIN="$HOME/.local/bin"
if [ -w "$LOCAL_BIN" ] || mkdir -p "$LOCAL_BIN"; then
    cp print_pdf.sh "$LOCAL_BIN/"
    chmod +x "$LOCAL_BIN/print_pdf.sh"
    echo "Script installed in $LOCAL_BIN/"
else
    sudo cp print_pdf.sh /usr/local/bin/
    sudo chmod +x /usr/local/bin/print_pdf.sh
    echo "Script installed in /usr/local/bin/ (root required)"
fi

echo "Installation complete! Restart Dolphin if needed."
