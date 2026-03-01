return {
  -- Buffer line (タブのようにバッファを表示)
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    keys = {
      { "<Tab>",   "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      { "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "<leader>bd", "<cmd>bdelete<cr>",          desc = "Delete Buffer" },
    },
    config = function()
      require("bufferline").setup({
        options = {
          numbers = "none",
          diagnostics = "nvim_lsp",
          -- nvim-tree 横にオフセットを設定
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              highlight = "Directory",
              separator = true,
            },
          },
          -- nvim-tree バッファをバッファラインから除外
          custom_filter = function(buf_number)
            if vim.bo[buf_number].filetype == "NvimTree" then
              return false
            end
            return true
          end,
        },
      })
    end,
  },

  -- Breadcrumbs (ファイルパス・関数名をウィンドウ上部に表示)
  {
    "Bekaboo/dropbar.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "BufReadPost",
    config = function()
      require("dropbar").setup({
        menu = {
          preview = false,
        },
      })
      local dropbar_api = require("dropbar.api")
      vim.keymap.set("n", "<leader>;", dropbar_api.pick, { desc = "Pick symbols in winbar" })
      vim.keymap.set("n", "[;", dropbar_api.goto_context_start, { desc = "Go to start of current context" })
      vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Select next context" })
    end,
  },

  -- Cmdline UI (blink.cmp の ghost text に必要)
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {},
  },

  -- Scrollbar (スクロールバー + Git/診断情報表示)
  {
    "petertriho/nvim-scrollbar",
    event = "BufReadPost",
    config = function()
      require("scrollbar").setup({
        handlers = {
          gitsigns = true,
          diagnostic = true,
        },
      })
      require("scrollbar.handlers.gitsigns").setup()
    end,
  },

  -- Colorscheme
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("kanagawa")
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
          section_separators = { left = "\u{e0b0}", right = "\u{e0b2}" },
          component_separators = { left = "\u{e0b1}", right = "\u{e0b3}" },
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
}
