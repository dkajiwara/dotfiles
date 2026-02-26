return {
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
          section_separators = { left = "", right = "" },
          component_separators = { left = "", right = "" },
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
