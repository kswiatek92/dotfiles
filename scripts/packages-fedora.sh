#!/bin/bash
# packages-fedora.sh — instalacja pakietów na Fedorze

set -e
echo "🐧 Instalacja pakietów Fedora..."

# ── DNF — narzędzia systemowe ─────────────────────────────────────────────────

echo ""
echo "→ Pakiety dnf"

sudo dnf install -y \
    git \
    curl \
    wget \
    zsh \
    vim \
    btop \
    lazygit \
    gh \
    docker \
    docker-compose \
    direnv

echo "  ✓ Pakiety dnf"

# ── Ghostty ───────────────────────────────────────────────────────────────────

echo ""
echo "→ Ghostty (przez COPR)"
sudo dnf copr enable -y scottames/ghostty
sudo dnf install -y ghostty
echo "  ✓ Ghostty"

# ── oh-my-zsh ─────────────────────────────────────────────────────────────────

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo ""
    echo "→ Instalacja oh-my-zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    echo "  ✓ oh-my-zsh"
fi

# ── oh-my-zsh pluginy ─────────────────────────────────────────────────────────

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions \
        "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
    echo "  ✓ zsh-autosuggestions"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting \
        "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
    echo "  ✓ zsh-syntax-highlighting"
fi

# ── pyenv ─────────────────────────────────────────────────────────────────────

if [ ! -d "$HOME/.pyenv" ]; then
    echo ""
    echo "→ Instalacja pyenv"
    curl https://pyenv.run | bash
    echo "  ✓ pyenv"
fi

# ── pnpm ──────────────────────────────────────────────────────────────────────

echo ""
echo "→ pnpm"
if ! command -v pnpm &>/dev/null; then
    curl -fsSL https://get.pnpm.io/install.sh | sh -
    echo "  ✓ pnpm"
else
    echo "  – pnpm już zainstalowany"
fi

# ── Node.js przez npm ─────────────────────────────────────────────────────────

echo ""
echo "→ Node.js i npm globals"
sudo dnf install -y nodejs npm

npm config set prefix ~/.npm-global
npm install -g @anthropic-ai/claude-code
echo "  ✓ Claude Code"

# ── Flatpaki ──────────────────────────────────────────────────────────────────

echo ""
echo "→ Flatpaki"

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

flatpaks=(
    # Komunikacja
    "com.discordapp.Discord"
    "com.slack.Slack"
    "org.signal.Signal"

    # Media / rozrywka
    "com.spotify.Client"
    "org.jellyfin.JellyfinDesktop"
    "io.github.streetpea.Chiaki4deck"   # PS Remote Play

    # Gaming
    "com.valvesoftware.Steam"
    "io.github.sharkwouter.Minigalaxy"  # GOG
    "com.usebottles.bottles"            # Wine/Proton manager
    "net.davidotek.pupgui2"             # ProtonUp-Qt

    # Przeglądarka
    "io.gitlab.librewolf-community"

    # Narzędzia
    "it.mijorus.gearlever"              # AppImage manager
    "com.prof18.feedflow"               # RSS
    "io.github.sharkwouter.Minigalaxy"  # torrent
)

for app in "${flatpaks[@]}"; do
    flatpak install --noninteractive flathub "$app" 2>/dev/null && \
        echo "  ✓ $app" || \
        echo "  – błąd lub już zainstalowane: $app"
done

echo ""
echo "✅ Pakiety Fedora zainstalowane"
