-- Tokyodark colorscheme
return {
  "tiagovla/tokyodark.nvim",
  priority = 1000, -- Load before other plugins
  config = function()
    require("tokyodark").setup({
      transparent_background = false,
      gamma = 1.00,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        identifiers = { italic = true },
        functions = {},
        variables = {},
      },
      terminal_colors = true,
    })
    vim.cmd.colorscheme("tokyodark")
  end,
}
