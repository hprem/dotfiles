"File: .config/nvim/init.vim

" Directory of this config file
let init_dir = expand('<sfile>:p:h')

" Set leader before Lua plugins (needed by keybinds registered in Lua)
let mapleader = "\<Space>"

" Load lua/init.lua
lua dofile(vim.g.init_dir .. '/lua/init.lua')

" Settings
execute 'source' init_dir .. '/settings.vim'

" Hotkeys
execute 'source' init_dir .. '/keybindings.vim'
