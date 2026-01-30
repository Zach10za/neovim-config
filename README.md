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

## Plugins

### Core
| Plugin | Purpose |
|--------|---------|
| [lazy.nvim](https://github.com/folke/lazy.nvim) | Plugin manager |
| [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) | Lua utility library (dependency) |

### LSP & Completion
| Plugin | Purpose |
|--------|---------|
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP client configurations |
| [mason.nvim](https://github.com/williamboman/mason.nvim) | LSP/DAP/linter installer |
| [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) | Mason + lspconfig bridge |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | Autocompletion engine |
| [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp) | LSP completion source |
| [cmp-buffer](https://github.com/hrsh7th/cmp-buffer) | Buffer words completion |
| [cmp-path](https://github.com/hrsh7th/cmp-path) | File path completion |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip) | Snippet engine |
| [cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip) | Snippet completion source |
| [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) | Snippet collection |
| [lspkind.nvim](https://github.com/onsails/lspkind.nvim) | VS Code-style completion icons |

### Syntax & Treesitter
| Plugin | Purpose |
|--------|---------|
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax highlighting, parsing |
| [nvim-treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context) | Sticky scroll showing current function/class |

### Fuzzy Finding
| Plugin | Purpose |
|--------|---------|
| [fzf-lua](https://github.com/ibhagwan/fzf-lua) | Fuzzy finder for files, grep, buffers, LSP |
| [vim-gutentags](https://github.com/ludovicchabant/vim-gutentags) | Automatic ctags generation |

### Git
| Plugin | Purpose |
|--------|---------|
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git signs in gutter, hunk actions |

### UI
| Plugin | Purpose |
|--------|---------|
| [tokyodark.nvim](https://github.com/tiagovla/tokyodark.nvim) | Colorscheme |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Statusline |
| [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) | File explorer |
| [aerial.nvim](https://github.com/stevearc/aerial.nvim) | Code outline/symbol navigation |
| [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | Indent guides |
| [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) | File icons |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | Keybinding hints popup |
| [nui.nvim](https://github.com/MunifTanjim/nui.nvim) | UI component library (dependency) |

### Editing
| Plugin | Purpose |
|--------|---------|
| [nvim-autopairs](https://github.com/windwp/nvim-autopairs) | Auto-close brackets, quotes |
| [Comment.nvim](https://github.com/numToStr/Comment.nvim) | Toggle comments (`gcc`, `gc`) |
| [nvim-surround](https://github.com/kylechui/nvim-surround) | Add/change/delete surroundings |
| [bufdelete.nvim](https://github.com/famiu/bufdelete.nvim) | Close buffers without closing windows |

### AI
| Plugin | Purpose |
|--------|---------|
| [copilot.lua](https://github.com/zbirenbaum/copilot.lua) | GitHub Copilot |
| [copilot-lualine](https://github.com/AndreM222/copilot-lualine) | Copilot status in statusline |

### Python
| Plugin | Purpose |
|--------|---------|
| [nvim-lint](https://github.com/mfussenegger/nvim-lint) | Async linting (ty type checker) |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Formatting (ruff, prettier, stylua) |

### Session
| Plugin | Purpose |
|--------|---------|
| [auto-session](https://github.com/rmagatti/auto-session) | Auto save/restore sessions per directory |

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
