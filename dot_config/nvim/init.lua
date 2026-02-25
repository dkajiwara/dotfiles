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
        options = { theme = "auto" },
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
})

-- ============================================================
-- Plugin Settings
-- ============================================================
vim.opt.updatetime = 100
