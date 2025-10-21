#!/bin/bash
# Universal installer for KDE Print PDF Service Menu

# Service menu folder
SERVICE_DIR="$HOME/.local/share/kservices5/ServiceMenus"
mkdir -p "$SERVICE_DIR"

# Copy the service menu
cp print_pdf.desktop "$SERVICE_DIR/"

# Copy the script
if [ -w "$HOME/.local/bin" ]; then
    mkdir -p "$HOME/.local/bin"
    cp print_pdf.sh "$HOME/.local/bin/"
    chmod +x "$HOME/.local/bin/print_pdf.sh"
    echo "Script installed in ~/.local/bin/"
else
    sudo cp print_pdf.sh /usr/local/bin/
    sudo chmod +x /usr/local/bin/print_pdf.sh
    echo "Script installed in /usr/local/bin/ (root required)"
fi

echo "Installation complete! Restart Dolphin if needed."
