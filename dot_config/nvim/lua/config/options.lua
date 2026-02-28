-- leader キーをスペースに設定（プラグイン読み込み前に設定する必要あり）
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- nvim-tree 用に netrw を無効化
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- ============================================================
-- Basic Settings
-- ============================================================
vim.opt.number = true
vim.opt.title = true
vim.opt.backup = false
vim.opt.hlsearch = true
vim.opt.clipboard = "unnamed"

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

-- gitsigns 用
vim.opt.updatetime = 100
