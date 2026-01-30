-- fzf-lua: Fast fuzzy finder for files, grep, buffers, and more
return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    "<leader>ff", "<leader>fg", "<leader>fG", "<leader>ft", "<leader>fb", "<leader>fh", "<leader>fr",
    "<leader>fc", "<leader>/", "<leader>gs", "<leader>gc", "<leader>gb",
    "<leader>ss", "<leader>sS", "<leader>st",
    { "<C-p>", mode = "n" },
  },
  config = function()
    local fzf = require("fzf-lua")

    -- Base rg options (shared across profiles)
    local rg_base = "--column --line-number --no-heading --color=always --smart-case --hidden -g '!.git/' -g '!.github/' -g '!node_modules/' -g '!dist/' -g '!build/' -g '!lyfe/static/js/' -g '!*.min.js' -g '!poetry.lock' -g '!scripts/'"

    -- Search profiles
    local search_profiles = {
      -- Default: excludes test files
      default = rg_base .. " -g '!**/test_*.py' -g '!**/tests/' -g '!**/*.test.ts' -g '!**/*.test.tsx' -g '!**/*.spec.ts' -g '!**/*.spec.tsx' -g '!**/__tests__/'",
      -- Tests only: only search test files
      tests = rg_base .. " -g '**/test_*.py' -g '**/tests/**' -g '**/*.test.ts' -g '**/*.test.tsx' -g '**/*.spec.ts' -g '**/*.spec.tsx' -g '**/__tests__/**'",
      -- All files (no test filtering)
      all = rg_base,
    }

    fzf.setup({
      "default-title",
      winopts = {
        height = 0.85,
        width = 0.80,
        row = 0.35,
        col = 0.50,
        preview = {
          layout = "flex",
          flip_columns = 120,
        },
      },
      keymap = {
        fzf = {
          ["ctrl-q"] = "select-all+accept",
        },
        builtin = {
          ["<C-j>"] = "preview-page-down",
          ["<C-k>"] = "preview-page-up",
        },
      },
      files = {
        fd_opts = "--color=never --type f --hidden --follow --exclude .git --exclude .github --exclude node_modules --exclude dist --exclude build --exclude 'lyfe/static/js' --exclude '*.min.js' --exclude poetry.lock --exclude scripts",
      },
      grep = {
        rg_opts = search_profiles.default,
        rg_glob = true,           -- enable `-- glob` syntax
        glob_flag = "--iglob",    -- case-insensitive globs
        glob_separator = "%s%-%-", -- separator is " --"
      },
      tags = {
        file_icons = true,
        git_icons = false,
        cwd_only = false,             -- Show all tags (paths are absolute in tags file)
        fzf_opts = {
          ["--exact"] = "",           -- Exact match instead of fuzzy
          ["--nth"] = "1",            -- Only search the first field (symbol name)
        },
      },
      btags = {
        file_icons = true,
        git_icons = false,
      },
      lsp = {
        symbols = {
          symbol_icons = {
            File = "󰈙",
            Module = "",
            Namespace = "󰌗",
            Package = "",
            Class = "󰌗",
            Method = "󰆧",
            Property = "",
            Field = "",
            Constructor = "",
            Enum = "",
            Interface = "󰜰",
            Function = "󰊕",
            Variable = "󰆧",
            Constant = "󰏿",
            String = "󰀬",
            Number = "󰎠",
            Boolean = "◩",
            Array = "󰅪",
            Object = "󰅩",
            Key = "󰌋",
            Null = "󰟢",
            EnumMember = "",
            Struct = "󰌗",
            Event = "",
            Operator = "󰆕",
            TypeParameter = "󰊄",
          },
        },
      },
    })

    -- Keymaps
    local keymap = vim.keymap.set

    -- File finding
    keymap("n", "<leader>ff", fzf.files, { desc = "Find files" })
    keymap("n", "<leader>fg", fzf.live_grep, { desc = "Live grep (excludes tests)" })
    keymap("n", "<leader>fG", function()
      fzf.live_grep({ rg_opts = search_profiles.all })
    end, { desc = "Live grep (all files)" })
    keymap("n", "<leader>ft", function()
      fzf.live_grep({ rg_opts = search_profiles.tests })
    end, { desc = "Live grep (tests only)" })
    keymap("n", "<leader>fb", fzf.buffers, { desc = "Find buffers" })
    keymap("n", "<leader>fh", fzf.help_tags, { desc = "Help tags" })
    keymap("n", "<leader>fr", fzf.oldfiles, { desc = "Recent files" })
    keymap("n", "<leader>fc", fzf.grep_cword, { desc = "Find word under cursor" })
    keymap("n", "<leader>/", fzf.blines, { desc = "Search in buffer" })
    keymap("n", "<C-p>", fzf.files, { desc = "Quick open file" })

    -- Git
    keymap("n", "<leader>gs", fzf.git_status, { desc = "Git status" })
    keymap("n", "<leader>gc", fzf.git_commits, { desc = "Git commits" })
    keymap("n", "<leader>gb", fzf.git_branches, { desc = "Git branches" })

    -- Symbols (LSP)
    keymap("n", "<leader>ss", fzf.lsp_document_symbols, { desc = "Document symbols" })
    keymap("n", "<leader>sS", fzf.lsp_live_workspace_symbols, { desc = "Workspace symbols" })

    -- Tags (for indexed search - run 'ctags -R .' to generate)
    keymap("n", "<leader>st", fzf.tags, { desc = "Search tags (indexed)" })
  end,
}
