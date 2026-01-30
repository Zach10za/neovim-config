# neovim-config

Personal Neovim configuration using lazy.nvim.

## Requirements

- Neovim 0.10+
- [ripgrep](https://github.com/BurntSushi/ripgrep) - live grep
- [fd](https://github.com/sharkdp/fd) - file finder
- [fzf](https://github.com/junegunn/fzf) - fuzzy finder
- [universal-ctags](https://github.com/universal-ctags/ctags) - tag generation
- [Nerd Font](https://www.nerdfonts.com/) - icons

## Install

```bash
git clone git@github.com:Zach10za/neovim-config.git ~/.config/nvim
nvim
```

Plugins install automatically on first launch.

## Structure

```
~/.config/nvim/
├── init.lua              # Core settings, keymaps, lazy.nvim bootstrap
├── lazy-lock.json        # Pinned plugin versions
└── lua/plugins/          # Plugin configs (auto-loaded by lazy.nvim)
    ├── lsp.lua           # LSP servers (pyright, ruff, lua_ls, ts_ls, etc.)
    ├── cmp.lua           # Autocompletion
    ├── fzf-lua.lua       # Fuzzy finder
    ├── treesitter.lua    # Syntax highlighting
    ├── copilot.lua       # GitHub Copilot
    ├── ui.lua            # Statusline, file explorer, gitsigns
    └── ...
```

## Key Bindings

Leader: `<Space>`

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep (excludes tests) |
| `<leader>fG` | Live grep (all files) |
| `<leader>fb` | Buffers |
| `<leader>e` | Toggle file explorer |
| `gd` | Go to definition |
| `gr` | Find references |
| `K` | Hover docs |
| `<leader>ca` | Code actions |
| `<leader>rn` | Rename symbol |
| `<leader>a` | Toggle code outline |
| `gcc` | Toggle comment |

Run `:WhichKey` or press `<leader>` and wait for the popup.

## Post-Install

```vim
:Copilot auth          " Authenticate GitHub Copilot
:Mason                 " Manage LSP servers
:Lazy                  " Manage plugins
```
