return {
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
          -- Enter で現在のウィンドウで開く（タブで開く場合は <C-t>）
          vim.keymap.set("n", "<CR>", api.node.open.edit, { buffer = bufnr, silent = true })
        end,
        tab = {
          sync = {
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
}
