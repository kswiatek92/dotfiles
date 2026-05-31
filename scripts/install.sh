#!/bin/bash
# install.sh — główny skrypt instalacyjny dotfiles
# Uruchamiany automatycznie przez chezmoi po zastosowaniu dotfiles
#
# Można też uruchomić ręcznie:
#   bash ~/.local/share/chezmoi/scripts/install.sh

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OS="$(uname -s)"

echo "╔══════════════════════════════════════════╗"
echo "║         Instalacja środowiska            ║"
echo "╚══════════════════════════════════════════╝"
echo ""
echo "System: $OS"
echo "Dotfiles: $DOTFILES_DIR"
echo ""

# ── Wykryj OS i uruchom odpowiedni skrypt ─────────────────────────────────────

case "$OS" in
    Linux)
        if command -v dnf &>/dev/null; then
            echo "Wykryto: Fedora Linux"
            bash "$DOTFILES_DIR/scripts/packages-fedora.sh"
        else
            echo "⚠️  Nieznana dystrybucja Linux — uruchom packages-fedora.sh ręcznie"
            exit 1
        fi
        ;;
    Darwin)
        echo "Wykryto: macOS"
        bash "$DOTFILES_DIR/scripts/packages-macos.sh"
        ;;
    *)
        echo "❌ Nieznany system: $OS"
        exit 1
        ;;
esac

# ── VSCode rozszerzenia (wspólne) ─────────────────────────────────────────────

echo ""
if command -v code &>/dev/null; then
    bash "$DOTFILES_DIR/scripts/vscode-extensions.sh"
else
    echo "⚠️  VSCode nie znaleziony — pomiń rozszerzenia"
fi

# ── Ustaw zsh jako domyślny shell ─────────────────────────────────────────────

echo ""
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "→ Ustawiam zsh jako domyślny shell"
    chsh -s "$(which zsh)"
    echo "  ✓ zsh ustawiony (restart terminala wymagany)"
fi

# ── Uprawnienia SSH ───────────────────────────────────────────────────────────

if [ -f "$HOME/.ssh/config" ]; then
    chmod 600 "$HOME/.ssh/config"
    echo "→ Uprawnienia ~/.ssh/config ustawione"
fi

echo ""
echo "╔══════════════════════════════════════════╗"
echo "║           Instalacja gotowa! ✅           ║"
echo "╚══════════════════════════════════════════╝"
echo ""
echo "Kolejne kroki:"
echo "  1. Uruchom ponownie terminal (lub: exec zsh)"
echo "  2. Sprawdź: chezmoi diff"
echo "  3. Dodaj klucze SSH: ssh-keygen -t ed25519 -C \"twój@email.com\""
