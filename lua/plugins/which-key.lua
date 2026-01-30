-- Which-key: Shows available keybindings in a popup
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")
    wk.setup({
      plugins = {
        marks = true,
        registers = true,
        spelling = { enabled = true },
      },
      win = {
        border = "rounded",
      },
    })

    -- Register key groups
    wk.add({
      { "<leader>f", group = "Find/Files" },
      { "<leader>g", group = "Git" },
      { "<leader>h", group = "Git Hunks" },
      { "<leader>l", group = "LSP" },
      { "<leader>b", group = "Buffers" },
      { "<leader>c", group = "Code" },
      { "<leader>s", group = "Splits/Symbols" },
    })
  end,
}
