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

**[lazy.nvim](https://github.com/folke/lazy.nvim)** - Plugin manager
- Change detection notifications disabled

**[plenary.nvim](https://github.com/nvim-lua/plenary.nvim)** - Lua utility library (dependency)

### LSP & Completion

**[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)** - LSP client configurations
- Custom diagnostic signs (nerdfont icons)
- LSP keymaps use fzf-lua for definitions, references, implementations
- Server-specific configs:
  - `lua_ls`: Neovim runtime detection, `vim` global recognized
  - `pyright`: Basic type checking, unused import/variable warnings disabled (handled by ruff)
  - `ruff`: Line length 100, select rules: E, F, W, I, UP, B, C4, SIM
  - `yamlls`: SchemaStore enabled, custom schemas for GitHub workflows, docker-compose, pre-commit

**[mason.nvim](https://github.com/williamboman/mason.nvim)** - LSP/DAP/linter installer
- Auto-installs: lua_ls, ts_ls, pyright, ruff, rust_analyzer, html, cssls, jsonls, yamlls, taplo

**[nvim-cmp](https://github.com/hrsh7th/nvim-cmp)** - Autocompletion engine
- `<C-j>`/`<C-k>` to navigate suggestions
- `<CR>` confirms (no auto-select)
- `<Tab>`/`<S-Tab>` for snippet jumping
- Bordered completion and documentation windows
- Sources: LSP → snippets → buffer → path

**[lspkind.nvim](https://github.com/onsails/lspkind.nvim)** - Completion icons
- Symbol + text mode, max width 50

### Syntax & Treesitter

**[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)** - Syntax highlighting
- Auto-installs: python, lua, javascript, typescript, json, yaml, html, css, bash, markdown
- Uses `vim.treesitter.start()` for Neovim 0.11+ compatibility

**[nvim-treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context)** - Sticky context
- Max 5 lines of context
- Multiline threshold 1 (truncates to first line only)
- `[c` jumps to context

### Fuzzy Finding

**[fzf-lua](https://github.com/ibhagwan/fzf-lua)** - Fuzzy finder
- 3 search profiles:
  - Default (`<leader>fg`): Excludes test files (`test_*.py`, `*.test.ts`, `__tests__/`)
  - Tests only (`<leader>ft`): Only test files
  - All (`<leader>fG`): No filtering
- Excludes from all searches: `.git/`, `node_modules/`, `dist/`, `build/`, `*.min.js`, `poetry.lock`
- `Ctrl-q` sends all results to quickfix
- `Ctrl-j`/`Ctrl-k` scrolls preview
- Custom LSP symbol icons

**[vim-gutentags](https://github.com/ludovicchabant/vim-gutentags)** - Auto ctags
- Tags stored in `~/.cache/nvim/tags/` (not in project)
- Project root markers: `.git`, `pyproject.toml`, `setup.py`, `package.json`, `Makefile`
- Extensive exclusions: tests, node_modules, build artifacts, media files, lockfiles
- Python: only classes, functions, methods
- Uses absolute paths for central cache compatibility

### Git

**[gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)** - Git integration
- Custom signs: `│` for add/change, `_` for delete
- Keymaps: `]h`/`[h` navigate hunks, `<leader>hs` stage, `<leader>hr` reset, `<leader>hp` preview, `<leader>hb` blame

### UI

**[tokyodark.nvim](https://github.com/tiagovla/tokyodark.nvim)** - Colorscheme
- Italic comments, keywords, identifiers
- Terminal colors enabled

**[lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)** - Statusline
- Theme: catppuccin
- Shows: mode, branch, diff, diagnostics, filename (relative path), copilot status, encoding, filetype, progress, location

**[neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)** - File explorer
- Width: 30
- Follows current file
- Shows dotfiles and gitignored files
- Space disabled (used as leader)
- Closes if last window

**[aerial.nvim](https://github.com/stevearc/aerial.nvim)** - Code outline
- Backends: LSP → treesitter → markdown
- Position: right edge, width 30-40
- Filtered to: Class, Constructor, Enum, Function, Interface, Module, Method, Struct
- `<leader>a` toggles, `{`/`}` navigate symbols

**[indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)** - Indent guides
- Character: `│`
- Scope highlighting enabled

**[which-key.nvim](https://github.com/folke/which-key.nvim)** - Keybinding hints
- Rounded border
- Groups: Find/Files, Git, Git Hunks, LSP, Buffers, Code, Splits/Symbols

### Editing

**[nvim-autopairs](https://github.com/windwp/nvim-autopairs)** - Auto pairs
- Integrated with nvim-cmp

**[Comment.nvim](https://github.com/numToStr/Comment.nvim)** - Comments
- Default config (`gcc` line, `gc` visual)

**[nvim-surround](https://github.com/kylechui/nvim-surround)** - Surround
- Default config (`ys`, `ds`, `cs`)

**[bufdelete.nvim](https://github.com/famiu/bufdelete.nvim)** - Buffer management
- `<leader>bd` deletes buffer

### AI

**[copilot.lua](https://github.com/zbirenbaum/copilot.lua)** - GitHub Copilot
- Auto-trigger enabled
- `<Tab>` accepts, `<C-Right>` accepts word, `<C-e>` accepts line
- `<M-]>`/`<M-[>` cycles suggestions
- Panel: `<M-CR>` opens, `[[`/`]]` navigates
- Disabled for: help, gitrebase

**[copilot-lualine](https://github.com/AndreM222/copilot-lualine)** - Statusline integration

### Python

**[nvim-lint](https://github.com/mfussenegger/nvim-lint)** - Async linting
- Custom `ty` linter (Astral's type checker)
- Runs on: BufEnter, BufWritePost, InsertLeave
- `<leader>ll` manual trigger
- Only runs if `ty` executable exists

**[conform.nvim](https://github.com/stevearc/conform.nvim)** - Formatting
- Format on save (500ms timeout)
- Formatters:
  - Python: ruff_format + ruff_organize_imports
  - Lua: stylua
  - JS/TS/JSON/YAML/Markdown: prettier
- Disabled for: sql, java
- `<leader>lf` manual format

### Session

**[auto-session](https://github.com/rmagatti/auto-session)** - Session management
- Auto save/restore enabled
- Suppressed dirs: `~/`, `~/Downloads`, `/`
- Closes neo-tree before saving (prevents buffer conflicts)
- `<leader>ss` save, `<leader>sr` restore, `<leader>sd` delete

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
