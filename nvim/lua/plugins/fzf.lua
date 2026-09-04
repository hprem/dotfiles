-- plugins/fzf.lua

local fzf_lua = require("fzf-lua")

fzf_lua.setup({
  -- Use ripgrep for file finding (ignores .git, node_modules, etc.)
  files = {
    cmd = "rg --files --hidden --follow --glob '!.git/*'",
  },
  -- Performance tweak: Use native Neovim floating windows
  winopts = {
    height = 0.85,
    width = 0.90,
    preview = {
      layout = "vertical",
      vertical = "down:45%",
    },
  },
})

-- Keybinds (These call Lua functions directly, no :Command overhead)
vim.keymap.set('n', '<leader>ff', fzf_lua.files, { desc = 'FZF: Find Files' })
vim.keymap.set('n', '<leader>fg', fzf_lua.live_grep, { desc = 'FZF: Live Grep' })
vim.keymap.set('n', '<leader>fb', fzf_lua.buffers, { desc = 'FZF: Find Buffers' })
vim.keymap.set('n', '<leader>fh', fzf_lua.command_history, { desc = 'FZF: Command History' })
