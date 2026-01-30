-- Treesitter: Parser installation and context
-- Neovim 0.11+ requires explicit vim.treesitter.start()
return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({})

      -- Install common parsers
      require("nvim-treesitter").install({
        "python", "lua", "javascript", "typescript",
        "json", "yaml", "html", "css", "bash",
        "markdown", "markdown_inline",
      })

      -- Enable treesitter highlighting for all supported filetypes
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })
    end,
  },

  -- Sticky scroll: shows current function/class context at top of window
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    lazy = false,
    config = function()
      require("treesitter-context").setup({
        enable = true,
        max_lines = 5,            -- Allow room for nested contexts (class + method)
        min_window_height = 0,
        line_numbers = true,
        multiline_threshold = 1,  -- Truncate to first line only (no args spillover)
        trim_scope = "inner",     -- Keep outer context (class) when trimming
        mode = "cursor",
        separator = nil,
      })

      vim.keymap.set("n", "[c", function()
        require("treesitter-context").go_to_context(vim.v.count1)
      end, { desc = "Jump to context", silent = true })
    end,
  },
}
