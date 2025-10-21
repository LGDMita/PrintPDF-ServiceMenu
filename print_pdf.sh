#!/bin/bash
# Print PDF with mandatory color and duplex selection

# Get available printers
mapfile -t printers < <(lpstat -a 2>/dev/null | awk '{print $1}')
if [ "${#printers[@]}" -eq 0 ]; then
    kdialog --title "Print PDFs" --sorry "No printers available."
    exit 1
fi

# Select printer
if [ "${#printers[@]}" -eq 1 ]; then
    printer="${printers[0]}"
else
    printer=$(kdialog --title "Print PDFs" --combobox "Select printer:" "${printers[@]}" --no-cancel)
fi

# Select color mode (mandatory)
color_choice=$(kdialog --title "Print PDFs" --combobox "Color mode:" "Color" "Black & White" --no-cancel)

# Select duplex mode (mandatory)
duplex_choice=$(kdialog --title "Print PDFs" --combobox "Print type:" "Duplex" "Single-sided" --no-cancel)

# Build lp options
lp_opts=""
if [ "$color_choice" = "Black & White" ]; then
    lp_opts="$lp_opts -o ColorModel=Gray"
fi
if [ "$duplex_choice" = "Duplex" ]; then
    lp_opts="$lp_opts -o sides=two-sided-long-edge"
elif [ "$duplex_choice" = "Single-sided" ]; then
    lp_opts="$lp_opts -o sides=one-sided"
fi

# Print selected files
for f in "$@"; do
    if [ -e "$f" ]; then
        lp -d "$printer" $lp_opts -- "$f" || \
            kdialog --title "Print PDFs" --error "Error printing file: $f"
    else
        kdialog --title "Print PDFs" --error "File not found: $f"
    fi
done

kdialog --title "Print PDFs" --msgbox "Print job(s) submitted."
