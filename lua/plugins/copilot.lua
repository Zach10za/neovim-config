-- GitHub Copilot for LLM-based autocomplete
return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        panel = {
          enabled = true,
          auto_refresh = true,
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>", -- Alt+Enter to open panel
          },
        },
        suggestion = {
          enabled = true,
          auto_trigger = true, -- Show suggestions automatically
          debounce = 75,
          keymap = {
            accept = "<Tab>",           -- Tab to accept suggestion
            accept_word = "<C-Right>",  -- Accept word
            accept_line = "<C-e>",      -- Accept line
            next = "<M-]>",             -- Alt+] for next suggestion
            prev = "<M-[>",             -- Alt+[ for previous suggestion
            dismiss = "<C-]>",          -- Dismiss suggestion
          },
        },
        filetypes = {
          ["*"] = true,         -- Enable for all filetypes by default
          help = false,         -- Disable for help files
          gitrebase = false,    -- Disable for git rebase
        },
      })
    end,
  },
  -- Copilot status in lualine
  {
    "AndreM222/copilot-lualine",
    dependencies = { "zbirenbaum/copilot.lua" },
  },
}
