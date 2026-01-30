-- Python-specific tools: ty type checker and additional linting
return {
  -- nvim-lint for running external linters like ty
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")

      -- Custom linter for ty (Astral's type checker)
      lint.linters.ty = {
        name = "ty",
        cmd = "ty",
        stdin = false,
        append_fname = true,
        args = { "check" },
        stream = "stderr",
        ignore_exitcode = true,
        parser = function(output, bufnr)
          local diagnostics = {}
          -- ty output format: file:line:col: severity: message
          for line in output:gmatch("[^\r\n]+") do
            local file, lnum, col, severity, message = line:match("([^:]+):(%d+):(%d+): (%w+): (.+)")
            if lnum and message then
              local sev = vim.diagnostic.severity.ERROR
              if severity == "warning" then
                sev = vim.diagnostic.severity.WARN
              elseif severity == "info" or severity == "note" then
                sev = vim.diagnostic.severity.INFO
              end
              table.insert(diagnostics, {
                lnum = tonumber(lnum) - 1,
                col = tonumber(col) - 1,
                end_lnum = tonumber(lnum) - 1,
                end_col = tonumber(col),
                severity = sev,
                message = message,
                source = "ty",
              })
            end
          end
          return diagnostics
        end,
      }

      -- Configure linters by filetype
      lint.linters_by_ft = {
        python = { "ty" },
      }

      -- Create autocmd to trigger linting
      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          -- Only lint if ty is available
          if vim.fn.executable("ty") == 1 then
            lint.try_lint()
          end
        end,
      })

      -- Keymap to manually trigger linting
      vim.keymap.set("n", "<leader>ll", function()
        lint.try_lint()
      end, { desc = "Trigger linting" })
    end,
  },

  -- conform.nvim for formatting (ruff format)
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          python = { "ruff_format", "ruff_organize_imports" },
          lua = { "stylua" },
          javascript = { "prettier" },
          typescript = { "prettier" },
          json = { "prettier" },
          yaml = { "prettier" },
          markdown = { "prettier" },
        },
        format_on_save = function(bufnr)
          -- Disable autoformat for certain filetypes
          local ignore_filetypes = { "sql", "java" }
          if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
            return
          end
          return {
            timeout_ms = 500,
            lsp_fallback = true,
          }
        end,
      })

      -- Format keymap
      vim.keymap.set({ "n", "v" }, "<leader>lf", function()
        require("conform").format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 1000,
        })
      end, { desc = "Format buffer" })
    end,
  },
}
