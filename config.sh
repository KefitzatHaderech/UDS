#!/bin/bash

# Check if 'code' command is available
if ! command -v code &> /dev/null
then
    echo "VS Code is not installed or 'code' command is not in PATH."
    exit 1
fi

# Install the extension
code --install-extension vectorgroup.capl

# Check if the installation was successful
if [ $? -eq 0 ]; then
    echo "Extension 'vectorgroup.capl' installed successfully."
else
    echo "Failed to install extension 'vectorgroup.capl'."
    exit 1
fi
