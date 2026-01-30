-- ============================================================================
-- Session Management (auto-session)
-- ============================================================================

return {
  "rmagatti/auto-session",
  lazy = false,
  config = function()
    require("auto-session").setup({
      auto_restore_enabled = true,
      auto_save_enabled = true,
      auto_session_suppress_dirs = { "~/", "~/Downloads", "/" },
      -- Only save/restore if you're in a directory with files
      auto_session_enable_last_session = false,
      -- Log level (debug, info, warn, error)
      log_level = "error",
      -- Close neo-tree before saving session to avoid buffer conflicts
      pre_save_cmds = { "Neotree close" },
    })
  end,
  keys = {
    { "<leader>ss", "<cmd>SessionSave<CR>", desc = "Save session" },
    { "<leader>sr", "<cmd>SessionRestore<CR>", desc = "Restore session" },
    { "<leader>sd", "<cmd>SessionDelete<CR>", desc = "Delete session" },
  },
}
