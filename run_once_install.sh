#!/bin/bash
# run_once_install.sh
# chezmoi uruchamia ten skrypt automatycznie TYLKO RAZ przy pierwszym `chezmoi apply`
# Nazwa "run_once_" to specjalna konwencja chezmoi

CHEZMOI_DIR="$(chezmoi source-path)"

echo "🚀 Pierwsze uruchomienie — instalacja środowiska..."
bash "$CHEZMOI_DIR/scripts/install.sh" || {
    echo "⚠️  install.sh zakończył się błędem — sprawdź logi powyżej"
    echo "    Możesz uruchomić ręcznie: bash ~/.local/share/chezmoi/scripts/install.sh"
}
