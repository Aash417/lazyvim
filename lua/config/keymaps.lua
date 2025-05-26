-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
vim.keymap.set("i", "jj", "<Esc>", {
    noremap = true,
    silent = true
})

vim.keymap.set("n", "<leader>ba", ":bufdo bd<CR>", {
    desc = "Close all buffers"
})

vim.g.snacks_animate = false
vim.g.lazyvim_check_order = false

vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', {
    expr = true,
    silent = true
})
