#!/bin/bash

# Keymap-drawer test script - uses virtual environment for safety
echo "🔧 Testing keymap-drawer in virtual environment..."

# Activate virtual environment
if [ -f "/home/re1983/.venv/default/bin/activate" ]; then
    source /home/re1983/.venv/default/bin/activate
    echo "✅ Virtual environment activated: $VIRTUAL_ENV"
else
    echo "❌ Virtual environment not found at /home/re1983/.venv/default/bin/activate"
    exit 1
fi

# Check if keymap-drawer is installed in venv
if ! command -v keymap &> /dev/null; then
    echo "❌ keymap-drawer not installed in virtual environment, installing..."
    pip install keymap-drawer
else
    echo "✅ keymap-drawer found: $(keymap --version)"
fi

# Test configuration
echo "📝 Testing configuration file..."
if python3 -c "import yaml; yaml.safe_load(open('keymap_drawer.config.yaml'))" 2>/dev/null; then
    echo "✅ Configuration file is valid"
else
    echo "❌ Configuration file has errors"
    exit 1
fi

# Create test output directory
mkdir -p keymap-drawer/test

echo "📝 Parsing keymap files..."

# Parse corne.keymap
if [ -f "config/corne.keymap" ]; then
    echo "Parsing config/corne.keymap..."
    keymap -c keymap_drawer.config.yaml parse -z config/corne.keymap > keymap-drawer/test/corne_test.yaml 2>/dev/null
    if [ $? -eq 0 ]; then
        echo "✅ Parsing corne.keymap completed"
    else
        echo "⚠️  Parsing corne.keymap had issues (this is expected with some ZMK features)"
    fi
else
    echo "❌ config/corne.keymap not found"
fi

# Parse miryoku keymap if exists
if [ -f "miryoku/corne.keymap" ]; then
    echo "Parsing miryoku/corne.keymap..."
    keymap -c keymap_drawer.config.yaml parse -z miryoku/corne.keymap > keymap-drawer/test/miryoku_corne_test.yaml 2>/dev/null
    if [ $? -eq 0 ]; then
        echo "✅ Parsing miryoku/corne.keymap completed"
    else
        echo "⚠️  Parsing miryoku/corne.keymap had issues (this is expected with some ZMK features)"
    fi
fi

echo "🎨 Testing SVG generation..."

# Generate test SVGs if YAML files exist
for yaml_file in keymap-drawer/test/*_test.yaml; do
    if [ -f "$yaml_file" ]; then
        base_name=$(basename "$yaml_file" _test.yaml)
        echo "Generating SVG for $base_name..."
        keymap -c keymap_drawer.config.yaml draw "$yaml_file" > "keymap-drawer/test/${base_name}_test.svg" 2>/dev/null
        if [ $? -eq 0 ]; then
            echo "✅ Generated ${base_name}_test.svg"
        else
            echo "❌ Failed to generate ${base_name}_test.svg"
        fi
    fi
done

echo ""
echo "🎉 Virtual environment testing completed!"
echo "📁 Check test files in keymap-drawer/test/ directory"
echo "🔍 Test files have '_test' suffix to avoid conflicts with GitHub Actions"
echo ""
echo "📋 Summary:"
ls -la keymap-drawer/test/ 2>/dev/null || echo "No test files generated"
