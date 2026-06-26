-- File: .config/nvim/init.vim

-- Prepend this file's directory to package.path so require() resolves
-- relative to this file, not the current working directory.
local dir = debug.getinfo(1, "S").source:match("@?(.*/)")
if dir then
  package.path = dir .. "?.lua;" .. package.path
end

--  Bootstrap vim.pack (Neovim's built-in package manager)
local pack_path = vim.fn.stdpath('data') .. '/site/pack/plugins/start'

local plugins = {
  -- Colors/Themes
  { 'catppuccin/nvim', name = 'catppuccin' },  -- colorscheme
  { 'nanozuki/tabby.nvim' },                   -- top nav-bar for tabs & windows
  { 'nvim-lualine/lualine.nvim' },             -- bottom status bar

  -- File explorer & Navigation
  { "nvim-telescope/telescope.nvim" },
  { "nvim-neo-tree/neo-tree.nvim" },
  -- dependencies
  { "nvim-lua/plenary.nvim" },
  { "MunifTanjim/nui.nvim" },
  { 'nvim-tree/nvim-web-devicons' },

  -- Movement
  { 'easymotion/vim-easymotion' },

  -- Comment
  { 'numToStr/Comment.nvim' },
}

-- Install plugins
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

-- Comment
require('Comment').setup()

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
