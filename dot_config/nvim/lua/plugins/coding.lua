return {
  -- Completion (補完)
  {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },
    version = "1.*",
    opts = {
      keymap = {
        preset = "default",
        ["<CR>"] = { "accept", "fallback" },
      },
      appearance = { nerd_font_variant = "mono" },
      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 500 },
        list = {
          selection = { preselect = true },
        },
      },
      sources = { default = { "lsp", "path", "snippets", "buffer" } },
      cmdline = {
        completion = {
          menu = { auto_show = true },
          ghost_text = { enabled = true },
        },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
  },

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
