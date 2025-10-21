# Print PDF Service Menu for KDE

This package provides a **Dolphin Service Menu** to print PDF files with **color and duplex options** using KDE-native dialogs (`kdialog`). It works on any Linux distribution with KDE Plasma.

---

## Features

- Select printer if multiple are available
- Choose **Color** or **Black & White**
- Choose **Duplex** (front/back) or **Single-sided**
- Fully KDE style (`kdialog`), no GNOME dialogs
- Automatic installation via `install.sh`

---

## Installation

1. Extract the package:

```bash
tar xzvf PrintPDF-ServiceMenu.tar.gz
cd PrintPDF-ServiceMenu
```

2. Make the installer executable and run it:
```bash
chmod +x install.sh
./install.sh
```
- The service menu will be installed in `~/.local/share/kservices5/ServiceMenus/`
- The script will be installed in `~/.local/bin/` (for non-root users) or `/usr/local/bin/`(if root)
- Make sure `print_pdf.sh` is executable (`chmod +x`)

3. Restart Dolphin (if open) to see the new menu entry.