#!/bin/bash
# vscode-extensions.sh — instalacja rozszerzeń VSCode
# Uruchamiane automatycznie przez install.sh

echo "→ Instalacja rozszerzeń VSCode..."

extensions=(
    # AI
    "anthropic.claude-code"
    "github.copilot-chat"

    # Git
    "eamodio.gitlens"
    "github.vscode-github-actions"

    # Python
    "ms-python.python"
    "ms-python.vscode-pylance"
    "ms-python.debugpy"
    "ms-python.isort"
    "ms-python.vscode-python-envs"
    "charliermarsh.ruff"

    # JavaScript / React
    "dsznajder.es7-react-js-snippets"
    "dbaeumer.vscode-eslint"
    "esbenp.prettier-vscode"

    # Docker
    "ms-azuretools.vscode-docker"
    "ms-azuretools.vscode-containers"
    "ms-vscode-remote.remote-containers"

    # Ogólne
    "christian-kohler.path-intellisense"
    "gruntfuggly.todo-tree"
    "wayou.vscode-todo-highlight"
    "usernamehw.errorlens"
    "johnpapa.vscode-peacock"
)

for ext in "${extensions[@]}"; do
    code --install-extension "$ext" --force 2>/dev/null && \
        echo "  ✓ $ext" || \
        echo "  – błąd: $ext"
done

echo "✅ Rozszerzenia VSCode zainstalowane"
