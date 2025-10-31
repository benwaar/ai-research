#!/bin/zsh
# Activate Python virtual environment and run a Python script from src/

VENV_PATH="$(pwd)/.venv/bin/activate"
PYTHON_BIN="$(pwd)/.venv/bin/python"
SCRIPT_PATH="src/agent.py"

if [ -f "$VENV_PATH" ]; then
    source "$VENV_PATH"
    $PYTHON_BIN "$SCRIPT_PATH"
else
    echo "Virtual environment not found. Please set up .venv first."
    exit 1
fi
