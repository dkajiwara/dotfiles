-- ============================================================
-- Basic Settings
-- ============================================================
vim.opt.number = true
vim.opt.title = true
vim.opt.backup = false
vim.opt.hlsearch = true
vim.opt.clipboard = "unnamed"

-- ============================================================
-- Key Mappings
-- ============================================================
-- jj で Normal モードに戻る
vim.keymap.set("i", "jj", "<ESC>", { silent = true })

-- ============================================================
-- Indentation
-- ============================================================
vim.opt.tabstop = 4
vim.opt.expandtab = true

-- ============================================================
-- Display
-- ============================================================
-- 補完候補をステータスメニューに表示
vim.opt.wildmenu = true
vim.opt.showcmd = false

-- 空白文字を可視化
vim.opt.list = true
vim.opt.listchars = {
  tab = "»-",
  space = "·",
  trail = "-",
  eol = "↲",
  extends = "»",
  precedes = "«",
  nbsp = "%",
}

-- 分割ウィンドウ設定
vim.opt.splitbelow = true

-- True color サポート
vim.opt.termguicolors = true

-- カーソル形状 (全モードでブロックカーソル点滅 = vim と同じ動作)
vim.opt.guicursor = "a:block-blinkwait700-blinkoff400-blinkon250"

-- ============================================================
-- Plugin Manager (lazy.nvim)
-- ============================================================
-- nvim-tree 用に netrw を無効化
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- ============================================================
-- Plugins
-- ============================================================
require("lazy").setup({
  -- Auto pairs
  {
    "echasnovski/mini.pairs",
    event = "InsertEnter",
    config = function()
      require("mini.pairs").setup()
    end,
  },

  -- Better comments (Treesitter ベース)
  {
    "folke/ts-comments.nvim",
    event = "VeryLazy",
    opts = {},
  },

  -- Treesitter (構文ハイライト・インデント)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua", "vim", "vimdoc",
          "bash", "json", "yaml", "toml",
          "markdown", "markdown_inline",
        },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- File tree (NERDTree → nvim-tree)
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "NvimTreeToggle", "NvimTreeOpen" },
    keys = {
      { "<C-n>", "<cmd>NvimTreeToggle<cr>", desc = "Toggle NvimTree" },
    },
    init = function()
      -- vi . でディレクトリを開いた時に nvim-tree を自動起動
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function(data)
          if vim.fn.isdirectory(data.file) == 1 then
            vim.cmd.cd(data.file)
            require("nvim-tree.api").tree.open()
          end
        end,
      })
    end,
    config = function()
      require("nvim-tree").setup({
        on_attach = function(bufnr)
          local api = require("nvim-tree.api")
          -- デフォルトマッピングを維持
          api.config.mappings.default_on_attach(bufnr)
          -- l でファイルを開く / ディレクトリを展開
          vim.keymap.set("n", "l", api.node.open.edit, { buffer = bufnr, silent = true })
          -- h でディレクトリを閉じる
          vim.keymap.set("n", "h", api.node.navigate.parent_close, { buffer = bufnr, silent = true })
          -- Space でファイルをプレビュー（tree のフォーカスを維持）
          vim.keymap.set("n", "<Space>", api.node.open.preview, { buffer = bufnr, silent = true })
          -- Enter でタブで開く
          vim.keymap.set("n", "<CR>", api.node.open.tab, { buffer = bufnr, silent = true })
        end,
        tab = {
          sync = {
            -- 新しいタブでも tree を自動で開く
            open = true,
            close = true,
          },
        },
        actions = {
          open_file = {
            quit_on_open = false,
          },
        },
      })
      -- エディタ側を :q した時、nvim-tree だけ残っていたら自動で閉じる
      vim.api.nvim_create_autocmd("QuitPre", {
        callback = function()
          local tree_wins = {}
          local floating_wins = {}
          local wins = vim.api.nvim_list_wins()
          for _, w in ipairs(wins) do
            local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
            if bufname:match("NvimTree_") then
              table.insert(tree_wins, w)
            end
            if vim.api.nvim_win_get_config(w).relative ~= "" then
              table.insert(floating_wins, w)
            end
          end
          if #wins - #floating_wins - #tree_wins == 1 then
            for _, w in ipairs(tree_wins) do
              vim.api.nvim_win_close(w, true)
            end
          end
        end,
      })
    end,
  },

  -- Colorscheme
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("kanagawa")
      -- 背景透過
      vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
    end,
  },

  -- Statusline (vim-airline → lualine)
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "kanagawa",
          globalstatus = true,
          section_separators = { left = "", right = "" },
          component_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { "filename" },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      })
    end,
  },

  -- Git signs (vim-gitgutter → gitsigns)
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },

  -- Markdown preview
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = "cd app && npx --yes yarn install",
  },

  -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>",   desc = "Recent Files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>",  desc = "Live Grep" },
    },
    config = function()
      require("telescope").setup()
      require("telescope").load_extension("projects")
    end,
  },

  -- Project manager
  {
    "ahmedkhalf/project.nvim",
    lazy = false,
    config = function()
      require("project_nvim").setup({
        detection_methods = { "pattern", "lsp" },
        patterns = { ".git", "package.json", "Cargo.toml", "go.mod" },
      })
    end,
  },

  -- LSP
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },
  { "neovim/nvim-lspconfig" },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
      -- nvim 0.11+ の新 API: vim.lsp.config / vim.lsp.enable
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      })
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls" },
      })
    end,
  },

  -- Dashboard (スタートスクリーン)
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons", "ahmedkhalf/project.nvim" },
    config = function()
      require("dashboard").setup({
        theme = "hyper",
        config = {
          header = {
            "",
            "███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
            "████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
            "██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
            "██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
            "██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
            "╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
            "",
          },
          shortcut = {
            { desc = "  Find File",  group = "Label", action = "Telescope find_files", key = "f" },
            { desc = "  Recent",     group = "Label", action = "Telescope oldfiles",   key = "r" },
            { desc = "  Projects",   group = "Label", action = "Telescope projects",   key = "p" },
            { desc = "  Quit",       group = "Label", action = "qa",                   key = "q" },
          },
          project = {
            enable = true,
            limit = 8,
            icon = " ",
            label = "Recent Projects",
            action = "Telescope find_files cwd=",
          },
        },
      })
    end,
  },
})

-- ============================================================
-- Plugin Settings
-- ============================================================
vim.opt.updatetime = 100
