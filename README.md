# Print PDF Service Menu for KDE

This package provides a **Dolphin Service Menu** for printing PDF files on KDE Plasma with **mandatory color and duplex selection**, while keeping the printer’s default settings for everything else (paper size, margins, scaling, autofit, etc.).

---

## Features

- Select printer if multiple are available (automatically uses the only printer if there’s just one)  
- Mandatory selection of **Color** or **Black & White**  
- Mandatory selection of **Duplex** (front/back) or **Single-sided**  
- Keeps all other printer defaults intact (no forced scaling, margins, or page fitting)  
- Fully KDE style dialogs using `kdialog` (no GNOME dialogs)  
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