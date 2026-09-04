-- File: .config/nvim/init.vim

-- Bootstrap vim.pack (Neovim's built-in package manager)
local pack_path = vim.fn.stdpath('data') .. '/site/pack/plugins/start'

local plugins = {
  -- Colors/Themes
  { 'catppuccin/nvim', name = 'catppuccin' },  -- colorscheme
  { 'nanozuki/tabby.nvim' },                   -- top nav-bar for tabs & windows
  { 'nvim-lualine/lualine.nvim' },             -- bottom status bar

  -- File explorer & Navigation
  { 'nvim-telescope/telescope.nvim' },
  { 'nvim-neo-tree/neo-tree.nvim' },
  { 'ibhagwan/fzf-lua' },
  -- dependencies
  { "nvim-lua/plenary.nvim" },
  { "MunifTanjim/nui.nvim" },
  { 'nvim-tree/nvim-web-devicons' },

  -- Git
  { 'tpope/vim-fugitive' },
  { 'lewis6991/gitsigns.nvim' },
  { 'f-person/git-blame.nvim' },

  -- Indent line
  { 'lukas-reineke/indent-blankline.nvim' },

  -- Movement
  { 'easymotion/vim-easymotion' },

  -- Comment
  { 'numToStr/Comment.nvim' },

  -- Yang syntax highlight
  { 'nathanalderson/yang.vim' },

  -- Code Completion
  { 'saghen/blink.cmp' },
  { 'saghen/blink.lib' },              -- dependency for blink
  { 'onsails/lspkind.nvim' },          -- dependency for blink
  { 'rafamadriz/friendly-snippets' },  -- dependency for blink
  { 'L3MON4D3/LuaSnip' },
  { 'danymat/neogen' },
  { 'nvim-treesitter/nvim-treesitter' },

  -- Python

  -- AI
  { 'greggh/claude-code.nvim' },
  { 'olimorris/codecompanion.nvim' },
}

local pending = 0
for _, plugin in ipairs(plugins) do
  local name = plugin.name or plugin[1]:match('[^/]+$')
  local dir = pack_path .. '/' .. name
  if vim.fn.empty(vim.fn.glob(dir)) > 0 then
    pending = pending + 1
    vim.notify('[vim.pack] Installing ' .. name .. '...')
    vim.fn.jobstart({ 'git', 'clone', 'https://github.com/' .. plugin[1], dir }, {
      on_exit = vim.schedule_wrap(function(_, exit_code)
        if exit_code == 0 then
          vim.notify('[vim.pack] ' .. name .. ' installed')
        else
          vim.notify('[vim.pack] Failed to install ' .. name, vim.log.levels.ERROR)
        end
        pending = pending - 1
        if pending == 0 then
          vim.notify('[vim.pack] All plugins installed — restarting')
          vim.defer_fn(function() vim.cmd('restart') end, 500)
        end
      end),
    })
  end
end

-- Catppuccin Theme
require('plugins.catppuccin')

-- Statusline (lualine)
require('plugins.lualine')

-- Tabby
require('plugins.tabby')

-- Neo Tree
require("plugins.neotree")

-- Telescope 
require("plugins.telescope")

-- Fzf
require("plugins.fzf")

-- LSP and Code Completion
require("plugins.treesitter")
require("plugins.lsp")      -- Native LSP setup
require("plugins.luasnip")  -- Snippets (Required by blink)
require("plugins.blink")    -- Completion UI
require("plugins.neogen")   -- Docstrings

-- Local LLMs
require('plugins.ai')

-- claude code
require('claude-code').setup()

-- Indent lines
require("ibl").setup()

-- Comment
require('Comment').setup()

-- enable ruff & ty LSP servers for Python
vim.lsp.enable({ 'ruff', 'ty' })

-- autoformat on save
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.py',
  callback = function(ev)
    vim.lsp.buf.code_action({
      context = { only = { 'source.organizeImports' } },
      apply = true,
    })
    vim.lsp.buf.format({ bufnr = ev.buf, name = 'ruff' })
  end,
})

-- Optional: show diagnostics in a floating window on cursor hold
vim.diagnostic.config({
  virtual_text = true,       -- inline error/warning text
  signs = {
    active = true,
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN]  = "",
      [vim.diagnostic.severity.HINT]  = "󰟃",
      [vim.diagnostic.severity.INFO]  = "",
    },
  },
  underline = true,          -- underline problematic code
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = true,           -- show which LSP reported it
  },
})

-- Optional: open float on cursor hover
vim.api.nvim_create_autocmd('CursorHold', {
  callback = function()
    vim.diagnostic.open_float(nil, { focus = false })
  end,
})

-- Use tmux clipboard when running inside tmux
if vim.env.TMUX then
  vim.g.clipboard = {
    name = 'tmux',
    copy = {
      ['+'] = { 'tmux', 'load-buffer', '-' },
      ['*'] = { 'tmux', 'load-buffer', '-' },
    },
    paste = {
      ['+'] = { 'tmux', 'save-buffer', '-' },
      ['*'] = { 'tmux', 'save-buffer', '-' },
    },
    cache_enabled = true,
  }
end

-- Git Signs
require('gitsigns').setup {}
-- require('gitsigns').setup {
--   signs = {
--     add          = { text = '┃' },
--     change       = { text = '┃' },
--     delete       = { text = '_' },
--     topdelete    = { text = '‾' },
--     changedelete = { text = '~' },
--     untracked    = { text = '┆' },
--   },
-- }

-- autoformat on save
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.py',
  callback = function(ev)
    vim.lsp.buf.code_action({
      context = { only = { 'source.organizeImports' } },
      apply = true,
    })
    vim.lsp.buf.format({ bufnr = ev.buf, name = 'ruff' })
  end,
})
