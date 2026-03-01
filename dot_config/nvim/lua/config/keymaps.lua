-- jj で Normal モードに戻る
vim.keymap.set("i", "jj", "<ESC>", { silent = true })

-- LSP (Neovim 0.11 standard)
vim.keymap.set("n", "grr", vim.lsp.buf.references, { desc = "LSP References" })
vim.keymap.set("n", "grd", vim.lsp.buf.definition, { desc = "LSP Definition" })
vim.keymap.set("n", "grn", vim.lsp.buf.rename, { desc = "LSP Rename" })
vim.keymap.set("n", "gra", vim.lsp.buf.code_action, { desc = "LSP Code Action" })
vim.keymap.set("n", "gri", vim.lsp.buf.implementation, { desc = "LSP Implementation" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP Hover" })
