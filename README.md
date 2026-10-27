# Ma config Neovim (LazyVim + gadgets)

LazyVim avec l'extra C/C++ (clangd) et un lot de gadgets dans `nvim/lua/plugins/gadgets.lua`.

## Installation (Pop!_OS / Ubuntu / Debian)

```bash
git clone https://github.com/toochigit/nvim-config ~/nvim-config
cd ~/nvim-config
./install.sh
```

Le script installe les dépendances, Neovim (binaire officiel), lazygit, tree-sitter-cli
et la Nerd Font, puis lie `~/.config/nvim` vers ce dépôt. Une config existante est sauvegardée.

Ensuite : choisis « JetBrainsMono Nerd Font » dans ton terminal et lance `nvim`.

## Installation manuelle (autre distro)

Installe Neovim >= 0.11, git, un compilateur C, ripgrep, fd, fzf, node/npm,
`tree-sitter-cli` et une Nerd Font, puis :

```bash
ln -s ~/nvim-config/nvim ~/.config/nvim
```

## Structure

```
nvim/
├── init.lua
├── lazyvim.json            # extras LazyVim activés
└── lua/
    ├── config/             # options, keymaps, autocmds, bootstrap lazy
    └── plugins/gadgets.lua # tes plugins
```

## Mettre à jour

```bash
cd ~/nvim-config && git pull
```
Dans nvim : `:Lazy sync`.

## Gadgets

| Raccourci | Effet |
|---|---|
| `<espace> m r` | Le code tombe en pluie |
| `<espace> m g` | Game of life |
| `<espace> d d` / `d k` | Canard / retirer le canard |
| `:VimBeGood` | Mini-jeux pour les motions |
| `:Hardtime toggle` | Couper le blocage hjkl |
