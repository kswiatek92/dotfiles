#!/bin/bash
# packages-macos.sh — instalacja pakietów na macOS (M2)

set -e
echo "🍎 Instalacja pakietów macOS..."

# ── Homebrew ──────────────────────────────────────────────────────────────────

if ! command -v brew &>/dev/null; then
    echo "→ Instalacja Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# ── CLI narzędzia ─────────────────────────────────────────────────────────────

echo ""
echo "→ Pakiety brew (CLI)"

brew install \
    git \
    curl \
    wget \
    zsh \
    vim \
    btop \
    lazygit \
    gh \
    direnv \
    node \
    pnpm

echo "  ✓ CLI tools"

# ── oh-my-zsh ─────────────────────────────────────────────────────────────────

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo ""
    echo "→ Instalacja oh-my-zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions \
        "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting \
        "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

echo "  ✓ oh-my-zsh + pluginy"

# ── pyenv ─────────────────────────────────────────────────────────────────────

if ! command -v pyenv &>/dev/null; then
    echo ""
    echo "→ Instalacja pyenv"
    brew install pyenv
fi

# ── Claude Code ───────────────────────────────────────────────────────────────

echo ""
echo "→ npm globals"
npm config set prefix ~/.npm-global
npm install -g @anthropic-ai/claude-code
echo "  ✓ Claude Code"

# ── Aplikacje (brew cask) ─────────────────────────────────────────────────────

echo ""
echo "→ Aplikacje (brew cask)"

brew install --cask \
    visual-studio-code \
    brave-browser \
    ghostty \
    discord \
    slack \
    signal \
    spotify \
    librewolf \
    docker

# Jellyfin Media Player (macOS)
brew install --cask jellyfin-media-player 2>/dev/null && \
    echo "  ✓ Jellyfin Media Player" || \
    echo "  – Jellyfin: zainstaluj ręcznie z jellyfin.org"

# Steam
brew install --cask steam
echo "  ✓ Steam"

echo ""
echo "⚠️  Aplikacje niedostępne na macOS:"
echo "   - Chiaki4deck (PS Remote Play) — pobierz z: https://github.com/streetpea/chiaki4deck"
echo "   - Minigalaxy (GOG) — użyj GOG Galaxy lub Heroic"
echo "   - ProtonUp-Qt — tylko Linux"
echo "   - Bottles — tylko Linux"

echo ""
echo "✅ Pakiety macOS zainstalowane"
