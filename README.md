# dotfiles

Konfiguracja środowiska dla **Fedora** i **macOS** zarządzana przez [chezmoi](https://chezmoi.io).

## Szybki start (jeden command)

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply github.com/kswiatek92/dotfiles
```

To polecenie:
1. Instaluje chezmoi
2. Klonuje repo
3. Aplikuje wszystkie dotfiles
4. Uruchamia skrypt instalacyjny (pakiety, aplikacje, VSCode extensions)

## Struktura repo

```
dotfiles/
├── dot_zshrc.tmpl            # → ~/.zshrc (z sekcjami per macOS/Fedora)
├── dot_gitconfig.tmpl        # → ~/.gitconfig
├── dot_ssh/
│   └── config.tmpl           # → ~/.ssh/config
├── dot_config/
│   ├── ghostty/
│   │   └── config            # → ~/.config/ghostty/config
│   ├── Code/User/
│   │   └── settings.json     # → ~/.config/Code/User/settings.json
│   └── lazygit/
│       └── config.yml        # → ~/.config/lazygit/config.yml
├── scripts/
│   ├── install.sh            # główny skrypt — wykrywa OS
│   ├── packages-fedora.sh    # dnf + flatpak + Ghostty (COPR)
│   ├── packages-macos.sh     # brew + brew cask
│   └── vscode-extensions.sh  # rozszerzenia VSCode (wspólne)
├── run_once_install.sh       # uruchamiany przez chezmoi tylko raz
└── .chezmoi.toml.tmpl        # konfiguracja chezmoi (wykrywa OS)
```

## Obsługiwane systemy

| System | Pakiety | Terminal | Przeglądarka |
|---|---|---|---|
| Fedora | dnf + flatpak | Ghostty (COPR) | Brave + Librewolf |
| macOS M2 | Homebrew | Ghostty | Brave + Librewolf |

## Ręczna aktualizacja dotfiles

```bash
# Zastosuj zmiany z repo
chezmoi update

# Dodaj nowy plik do śledzenia
chezmoi add ~/.nazwa_pliku

# Edytuj plik przez chezmoi
chezmoi edit ~/.zshrc

# Podejrzyj co się zmieni przed aplikacją
chezmoi diff
```

## Aliasy

| Alias | Komenda |
|---|---|
| `cz` | `chezmoi` |
| `cza` | `chezmoi apply` |
| `czd` | `chezmoi diff` |
| `czu` | `chezmoi update` |
| `update` | `sudo dnf upgrade --refresh && flatpak update -y` (Fedora) / `brew update && brew upgrade` (macOS) |
| `ll` | `ls -la` |
| `gs` | `git status` |
| `gp` | `git push` |
| `gpl` | `git pull` |

## Po instalacji

1. Uruchom ponownie terminal: `exec zsh`
2. Wygeneruj klucz SSH: `ssh-keygen -t ed25519 -C "dredu71@gmail.com"`
3. Dodaj klucz do GitHub: `cat ~/.ssh/id_ed25519.pub`
