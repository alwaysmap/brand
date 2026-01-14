#!/bin/bash

# SVG to PNG Converter using resvg
#
# This script converts all SVG files from svg/ directory to PNG format with
# faithful font rendering, outputting to png/ directory.
# It downloads the Josefin Sans font from Google Fonts and explicitly loads it
# into resvg to ensure accurate rendering.
#
# Prerequisites: resvg must be installed (brew install resvg)
#
# Usage: ./generate-pngs.sh

set -e

SVG_DIR="svg"
PNG_DIR="png"
FONT_DIR=".fonts"
FONT_URL="https://fonts.googleapis.com/css2?family=Josefin+Sans:wght@400&display=swap"
FONT_PATH="$FONT_DIR/JosefinSans-Regular.ttf"

echo "SVG to PNG Converter"
echo "=================================================="
echo ""

# Check if resvg is installed
if ! command -v resvg &> /dev/null; then
    echo "❌ Error: resvg is not installed"
    echo ""
    echo "Please install resvg:"
    echo "  macOS:   brew install resvg"
    echo "  Linux:   See https://github.com/RazrFalcon/resvg"
    exit 1
fi

echo "✓ resvg is installed"
echo ""

# Download font if needed
if [ ! -f "$FONT_PATH" ]; then
    echo "Downloading Josefin Sans font..."
    mkdir -p "$FONT_DIR"

    # Fetch the CSS to get the actual font URL
    FONT_CSS=$(curl -s "$FONT_URL")

    # Extract the TTF URL using grep and sed
    ACTUAL_FONT_URL=$(echo "$FONT_CSS" | grep -o 'https://fonts.gstatic.com[^)]*\.ttf' | head -n 1)

    if [ -z "$ACTUAL_FONT_URL" ]; then
        # Try woff2 if ttf not found
        ACTUAL_FONT_URL=$(echo "$FONT_CSS" | grep -o 'https://fonts.gstatic.com[^)]*\.woff2' | head -n 1)
        if [ -n "$ACTUAL_FONT_URL" ]; then
            FONT_PATH="$FONT_DIR/JosefinSans-Regular.woff2"
        fi
    fi

    if [ -z "$ACTUAL_FONT_URL" ]; then
        echo "❌ Could not find font URL in Google Fonts CSS"
        exit 1
    fi

    echo "Downloading from: $ACTUAL_FONT_URL"
    curl -s -o "$FONT_PATH" "$ACTUAL_FONT_URL"
    echo "✓ Font saved to $FONT_PATH"
else
    echo "✓ Font already downloaded"
fi

echo ""

# Check if svg directory exists
if [ ! -d "$SVG_DIR" ]; then
    echo "❌ Error: $SVG_DIR directory not found"
    exit 1
fi

# Create png directory if it doesn't exist
mkdir -p "$PNG_DIR"

# Find all SVG files in svg directory
SVG_FILES=$(find "$SVG_DIR" -maxdepth 1 -name "*.svg" -type f | sort)

if [ -z "$SVG_FILES" ]; then
    echo "No SVG files found in $SVG_DIR directory."
    exit 0
fi

# Count files
FILE_COUNT=$(echo "$SVG_FILES" | wc -l | tr -d ' ')
echo "Found $FILE_COUNT SVG file(s) in $SVG_DIR/:"
echo "$SVG_FILES" | sed "s|^|  - |"
echo ""

# Convert each SVG
for svg_file in $SVG_FILES; do
    # Get base name without directory and extension
    base_name=$(basename "$svg_file" .svg)

    echo "Converting $(basename "$svg_file")..."

    # Generate 1x PNG
    output_1x="$PNG_DIR/${base_name}.png"
    resvg "$svg_file" "$output_1x" \
        --skip-system-fonts \
        --use-font-file "$FONT_PATH" \
        2>/dev/null
    echo "  ✓ Created $output_1x"

    # Generate 2x PNG
    output_2x="$PNG_DIR/${base_name}@2x.png"
    resvg "$svg_file" "$output_2x" \
        --zoom 2 \
        --skip-system-fonts \
        --use-font-file "$FONT_PATH" \
        2>/dev/null
    echo "  ✓ Created $output_2x"
done

echo ""
echo "✨ All conversions complete!"
echo ""
echo "Note: Downloaded fonts are stored in $FONT_DIR/"
echo "You can add this directory to .gitignore"
