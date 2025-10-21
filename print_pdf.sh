#!/bin/bash
# Script to print PDF with printer, color, and duplex options
# KDE style, two separate comboboxes

# Get available printers
mapfile -t printers < <(lpstat -a 2>/dev/null | awk '{print $1}')
if [ "${#printers[@]}" -eq 0 ]; then
    kdialog --sorry "No printers available."
    exit 1
fi

# If only one printer, use it automatically
if [ "${#printers[@]}" -eq 1 ]; then
    printer="${printers[0]}"
else
    printer=$(kdialog --combobox "Select printer:" "${printers[@]}")
    proceed=$?
    if [ $proceed -ne 0 ] || [ -z "$printer" ]; then
        kdialog --sorry "Printing cancelled."
        exit 0
    fi
fi

# Combobox for color mode (no default)
color_choice=$(kdialog --combobox "Color mode:" "Color" "Black & White")
proceed=$?
if [ $proceed -ne 0 ] || [ -z "$color_choice" ]; then
    kdialog --sorry "Printing cancelled."
    exit 0
fi

# Combobox for duplex mode (no default)
duplex_choice=$(kdialog --combobox "Print type:" "Duplex" "Single-sided")
proceed=$?
if [ $proceed -ne 0 ] || [ -z "$duplex_choice" ]; then
    kdialog --sorry "Printing cancelled."
    exit 0
fi

# Set lp options
if [ "$color_choice" = "Black & White" ]; then
    color_opt="-o ColorModel=Gray"
else
    color_opt=""
fi

if [ "$duplex_choice" = "Duplex" ]; then
    duplex_opt="-o sides=two-sided-long-edge"
else
    duplex_opt="-o sides=one-sided"
fi

# Print selected files
for f in "$@"; do
    if [ -e "$f" ]; then
        lp -d "$printer" $color_opt $duplex_opt -- "$f" || \
            kdialog --error "Error printing file: $f"
    else
        kdialog --error "File not found: $f"
    fi
done
kdialog --msgbox "Print job(s) submitted."