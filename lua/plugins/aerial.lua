-- Aerial: Code outline / symbol navigation
return {
  "stevearc/aerial.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("aerial").setup({
      -- Priority list of backends (LSP preferred, treesitter fallback)
      backends = { "lsp", "treesitter", "markdown", "man" },

      layout = {
        -- Width of the aerial window
        max_width = { 40, 0.2 },
        min_width = 30,

        -- Position: prefer right side like file explorer
        default_direction = "prefer_right",

        -- Place aerial on the right of the current window
        placement = "edge",
      },

      -- Highlight the symbol in the source buffer when cursor moves
      highlight_on_hover = true,

      -- Automatically open aerial when entering a buffer
      open_automatic = false,

      -- Show box drawing characters for the tree
      show_guides = true,

      -- Filter symbols shown
      filter_kind = {
        "Class",
        "Constructor",
        "Enum",
        "Function",
        "Interface",
        "Module",
        "Method",
        "Struct",
      },

      -- Keymaps in the aerial window
      keymaps = {
        ["?"] = "actions.show_help",
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.jump",
        ["<2-LeftMouse>"] = "actions.jump",
        ["<C-v>"] = "actions.jump_vsplit",
        ["<C-s>"] = "actions.jump_split",
        ["p"] = "actions.scroll",
        ["<C-j>"] = "actions.down_and_scroll",
        ["<C-k>"] = "actions.up_and_scroll",
        ["{"] = "actions.prev",
        ["}"] = "actions.next",
        ["[["] = "actions.prev_up",
        ["]]"] = "actions.next_up",
        ["q"] = "actions.close",
        ["o"] = "actions.tree_toggle",
        ["za"] = "actions.tree_toggle",
        ["O"] = "actions.tree_toggle_recursive",
        ["zA"] = "actions.tree_toggle_recursive",
        ["l"] = "actions.tree_open",
        ["zo"] = "actions.tree_open",
        ["L"] = "actions.tree_open_recursive",
        ["zO"] = "actions.tree_open_recursive",
        ["h"] = "actions.tree_close",
        ["zc"] = "actions.tree_close",
        ["H"] = "actions.tree_close_recursive",
        ["zC"] = "actions.tree_close_recursive",
        ["zr"] = "actions.tree_increase_fold_level",
        ["zR"] = "actions.tree_open_all",
        ["zm"] = "actions.tree_decrease_fold_level",
        ["zM"] = "actions.tree_close_all",
        ["zx"] = "actions.tree_sync_folds",
        ["zX"] = "actions.tree_sync_folds",
      },
    })

    -- Keymaps
    local keymap = vim.keymap.set
    keymap("n", "<leader>a", "<cmd>AerialToggle!<CR>", { desc = "Toggle Aerial outline" })
    keymap("n", "{", "<cmd>AerialPrev<CR>", { desc = "Previous symbol" })
    keymap("n", "}", "<cmd>AerialNext<CR>", { desc = "Next symbol" })
  end,
}
