#!/usr/bin/env bash
# Installe Neovim + dépendances + ta config LazyVim.
# Cible : Pop!_OS / Ubuntu / Debian (x86_64). Relançable sans risque.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NVIM_CFG="$HOME/.config/nvim"

say() { printf '\n\033[1;36m==> %s\033[0m\n' "$*"; }

if ! command -v apt >/dev/null; then
  echo "Ce script gère apt (Pop!_OS/Ubuntu/Debian). Pour une autre distro, adapte l'étape 1." >&2
  exit 1
fi

say "1/6 Dépendances"
sudo apt update
sudo apt install -y git build-essential curl unzip ripgrep fd-find xclip fzf nodejs npm

mkdir -p "$HOME/.local/bin"
if command -v fdfind >/dev/null && [ ! -e "$HOME/.local/bin/fd" ]; then
  ln -s "$(command -v fdfind)" "$HOME/.local/bin/fd"
fi

say "2/6 Neovim (binaire officiel)"
cd /tmp
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
rm -f nvim-linux-x86_64.tar.gz

say "3/6 PATH (bash et zsh)"
LINE='export PATH="$PATH:/opt/nvim-linux-x86_64/bin:$HOME/.local/bin"'
for rc in "$HOME/.bashrc" "$HOME/.zshrc"; do
  [ -f "$rc" ] || continue
  grep -qF '/opt/nvim-linux-x86_64/bin' "$rc" || echo "$LINE" >> "$rc"
done
export PATH="$PATH:/opt/nvim-linux-x86_64/bin:$HOME/.local/bin"

say "4/6 lazygit + tree-sitter-cli"
if ! command -v lazygit >/dev/null; then
  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": *"v\K[^"]*')
  curl -Lo /tmp/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
  tar xf /tmp/lazygit.tar.gz -C /tmp lazygit
  sudo install /tmp/lazygit -D -t /usr/local/bin/
  rm -f /tmp/lazygit /tmp/lazygit.tar.gz
fi
command -v tree-sitter >/dev/null || sudo npm install -g tree-sitter-cli

say "5/6 JetBrainsMono Nerd Font"
if ! fc-list | grep -qi "JetBrainsMono Nerd"; then
  mkdir -p "$HOME/.local/share/fonts"
  curl -Lo /tmp/JetBrainsMono.zip https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
  unzip -o /tmp/JetBrainsMono.zip -d "$HOME/.local/share/fonts" >/dev/null
  rm -f /tmp/JetBrainsMono.zip
  fc-cache -f
fi

say "6/6 Config Neovim"
if [ -e "$NVIM_CFG" ] && [ ! -L "$NVIM_CFG" ]; then
  BACKUP="$NVIM_CFG.bak.$(date +%Y%m%d%H%M%S)"
  echo "Ancienne config sauvegardée dans $BACKUP"
  mv "$NVIM_CFG" "$BACKUP"
fi
mkdir -p "$HOME/.config"
ln -sfn "$REPO_DIR/nvim" "$NVIM_CFG"

say "Terminé"
echo "Ouvre un nouveau terminal, choisis la police « JetBrainsMono Nerd Font », puis lance : nvim"
echo "Le premier démarrage installe les plugins tout seul."
