-- gutentags: Automatic tag file management for fast symbol search
return {
  "ludovicchabant/vim-gutentags",
  event = { "BufReadPre", "BufNewFile" },
  init = function()
    -- Where to store tag files (keeps them out of your project)
    vim.g.gutentags_cache_dir = vim.fn.expand("~/.cache/nvim/tags")

    -- Generate tags only in projects with these root markers
    vim.g.gutentags_project_root = {
      ".git",
      "pyproject.toml",
      "setup.py",
      "package.json",
      "Makefile",
      ".gutctags",
    }

    -- Don't generate tags for these patterns
    vim.g.gutentags_ctags_exclude = {
      "*.git",
      "*.svg",
      "*.hg",
      "*/tests/*",
      "build",
      "dist",
      "*sites/*/files/*",
      "bin",
      "node_modules",
      "bower_components",
      "cache",
      "compiled",
      "docs",
      "example",
      "bundle",
      "vendor",
      "*.md",
      "*-lock.json",
      "*.lock",
      "*bundle*.js",
      "*build*.js",
      ".*rc*",
      "*.json",
      "*.min.*",
      "*.map",
      "*.bak",
      "*.zip",
      "*.pyc",
      "*.class",
      "*.sln",
      "*.Master",
      "*.csproj",
      "*.tmp",
      "*.csproj.user",
      "*.cache",
      "*.pdb",
      "*.exe",
      "*.dll",
      "*.mp3",
      "*.ogg",
      "*.flac",
      "*.swp",
      "*.swo",
      "*.bmp",
      "*.gif",
      "*.ico",
      "*.jpg",
      "*.png",
      "*.rar",
      "*.tar",
      "*.tar.gz",
      "*.tar.xz",
      "*.tar.bz2",
      "*.pdf",
      "*.doc",
      "*.docx",
      "*.ppt",
      "*.pptx",
      "__pycache__",
      ".venv",
      "venv",
      ".mypy_cache",
      ".pytest_cache",
      "*.egg-info",
      ".tox",
      ".coverage",
      "htmlcov",
      -- Project-specific exclusions
      "lyfe/static/js/*",
      "*/static/js/*",
      "*.min.js",
      -- Exclude non-code files
      "*.html",
      "*.css",
      "*.scss",
      "*.less",
      "*.svg",
      "*.xml",
      "*.yaml",
      "*.yml",
      "*.toml",
      "*.txt",
      "*.rst",
    }

    -- Use Universal Ctags extra features - definitions only
    vim.g.gutentags_ctags_extra_args = {
      "--tag-relative=never",       -- Use absolute paths (required for central cache dir)
      "--fields=+ln",               -- Only language and line number (no signature/types)
      "--extras=-{anonymous}",      -- Exclude anonymous tags
      "--extras=-{reference}",      -- Exclude references (usages)
      "--extras=-{qualified}",      -- Exclude qualified tags
      "--python-kinds=cfm",         -- Python: only classes, functions, methods
      "--javascript-kinds=cfmCMG",  -- JS: classes, functions, methods, constants, modules, generators
      "--html-kinds=",              -- HTML: exclude all (no tags from HTML)
      "--css-kinds=",               -- CSS: exclude all
      "--markdown-kinds=",          -- Markdown: exclude all
    }

    -- Only enable ctags (not cscope or gtags)
    vim.g.gutentags_modules = { "ctags" }

    -- Don't load gutentags for these filetypes
    vim.g.gutentags_exclude_filetypes = {
      "gitcommit",
      "gitrebase",
      "help",
      "text",
      "markdown",
    }

    -- Status line integration (optional, shows when tags are generating)
    vim.g.gutentags_generate_on_new = true
    vim.g.gutentags_generate_on_missing = true
    vim.g.gutentags_generate_on_write = true
    vim.g.gutentags_generate_on_empty_buffer = false

    -- Debugging (uncomment if tags aren't generating)
    -- vim.g.gutentags_trace = 1
  end,
  config = function()
    -- Create the cache directory if it doesn't exist
    local cache_dir = vim.fn.expand("~/.cache/nvim/tags")
    if vim.fn.isdirectory(cache_dir) == 0 then
      vim.fn.mkdir(cache_dir, "p")
    end
  end,
}
