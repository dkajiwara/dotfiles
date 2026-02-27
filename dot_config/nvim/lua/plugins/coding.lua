return {
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
    lazy = false,
    build = function()
      -- 初回インストール・更新時のみ実行
      require("nvim-treesitter").install({
        -- Flutter / Dart
        "dart",
        -- モバイル (iOS / Android)
        "swift", "kotlin", "java",
        -- 設定・データ
        "json", "yaml", "toml", "xml",
        -- CI / Fastlane
        "bash", "ruby",
        -- Flutter Web
        "javascript", "typescript", "html", "css",
        -- システム言語
        "go", "rust",
        -- マークアップ
        "markdown", "markdown_inline",
        -- エディタ設定
        "lua", "vim", "vimdoc",
      }):wait(300000)
    end,
    config = function()
      -- FileType ごとに treesitter ハイライトを有効化
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })
    end,
  },
}
