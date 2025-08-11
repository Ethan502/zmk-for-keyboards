#!/bin/bash
# Local testing script for keymap-drawer

echo "🔧 Testing keymap-drawer locally..."

# Check if keymap-drawer is installed
if ! command -v keymap &> /dev/null; then
    echo "❌ keymap-drawer not installed, installing..."
    if command -v pipx &> /dev/null; then
        pipx install keymap-drawer
    elif command -v pip &> /dev/null; then
        pip install --user keymap-drawer
    else
        echo "❌ Please install pip or pipx first"
        exit 1
    fi
fi

# Create output directory
mkdir -p keymap-drawer

echo "📝 Parsing keymap files..."

# Parse corne.keymap
if [ -f "config/corne.keymap" ]; then
    keymap -c keymap_drawer.config.yaml parse -z config/corne.keymap > keymap-drawer/corne.yaml
    echo "✅ Parsing corne.keymap completed"
fi

# Parse miryoku/corne.keymap
if [ -f "config/miryoku/corne.keymap" ]; then
    keymap -c keymap_drawer.config.yaml parse -z config/miryoku/corne.keymap > keymap-drawer/miryoku_corne.yaml
    echo "✅ Parsing miryoku/corne.keymap completed"
fi

echo "🎨 Generating SVG diagrams..."

# Generate SVGs
for yaml_file in keymap-drawer/*.yaml; do
    if [ -f "$yaml_file" ]; then
        base_name=$(basename "$yaml_file" .yaml)
        keymap -c keymap_drawer.config.yaml draw "$yaml_file" > "keymap-drawer/${base_name}.svg"
        echo "✅ Generated ${base_name}.svg completed"
    fi
done

echo "🎉 Local testing completed! Check files in keymap-drawer/ directory."
