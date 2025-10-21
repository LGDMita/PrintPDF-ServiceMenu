#!/bin/bash
# Print PDF keeping printer defaults, allow optional color and duplex override

# Get available printers
mapfile -t printers < <(lpstat -a 2>/dev/null | awk '{print $1}')
if [ "${#printers[@]}" -eq 0 ]; then
    kdialog --title "Print PDFs" --sorry "No printers available."
    exit 1
fi

# If only one printer, use it automatically
if [ "${#printers[@]}" -eq 1 ]; then
    printer="${printers[0]}"
else
    printer=$(kdialog --title "Print PDFs" --combobox "Select printer:" "${printers[@]}")
    proceed=$?
    if [ $proceed -ne 0 ] || [ -z "$printer" ]; then
        kdialog --title "Print PDFs" --sorry "Printing cancelled."
        exit 0
    fi
fi

# Ask user if they want to override color
color_choice=$(kdialog --title "Print PDFs" --combobox "Color mode (leave default to keep printer settings):" \
    "Default" "Color" "Black & White")
proceed=$?
if [ $proceed -ne 0 ] || [ -z "$color_choice" ]; then
    kdialog --title "Print PDFs" --sorry "Printing cancelled."
    exit 0
fi

# Ask user if they want to override duplex
duplex_choice=$(kdialog --title "Print PDFs" --combobox "Print type (leave default to keep printer settings):" \
    "Default" "Duplex" "Single-sided")
proceed=$?
if [ $proceed -ne 0 ] || [ -z "$duplex_choice" ]; then
    kdialog --title "Print PDFs" --sorry "Printing cancelled."
    exit 0
fi

# Build lp options
lp_opts=""

# Only add color option if user overrides
if [ "$color_choice" = "Color" ]; then
    lp_opts="$lp_opts -o ColorModel=Color"
elif [ "$color_choice" = "Black & White" ]; then
    lp_opts="$lp_opts -o ColorModel=Gray"
fi

# Only add duplex option if user overrides
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
