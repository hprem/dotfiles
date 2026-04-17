"File: .config/nvim/init.vim
call plug#begin()

" Colors/Themes
Plug 'glepnir/oceanic-material' " colorscheme
Plug 'mhartington/oceanic-next' " colorscheme
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
"Plug 'glepnir/spaceline.vim'    " status bar
Plug 'feline-nvim/feline.nvim'  " status bar
Plug 'lewis6991/gitsigns.nvim'
Plug 'bagrat/vim-buffet'        " top tab bar

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'f-person/git-blame.nvim'

" File explorer
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'

" indent line
Plug 'lukas-reineke/indent-blankline.nvim'

" Movement
Plug 'easymotion/vim-easymotion'

" Yang syntax highlight
Plug 'nathanalderson/yang.vim'

call plug#end()

" colorscheme
"autocmd ColorScheme * ++nested highlight Normal ctermbg=NONE guibg=NONE
autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
set termguicolors
set background=dark
"let g:oceanic_material_transparent_background = 1
"colorscheme oceanic_material
"colorscheme OceanicNext
colorscheme catppuccin-macchiato

" Status line
set laststatus=2
let g:spaceline_seperate_style= 'slant-cons'
let g:spaceline_git_branch_icon= ''
let g:spaceline_colorscheme = 'space'

" Git (vim-signify)
set updatetime=100

" Nerdtree
let g:NERDTreeGitStatusUseNerdFonts = 1
nnoremap <M-f> :NERDTreeToggle<CR>
nnoremap <M-s> :NERDTreeFind<CR>

" Prem's settings
set mouse=a
set clipboard=unnamedplus

set tabstop=4
set shiftwidth=4
set expandtab

" Top tab bar
let g:buffet_powerline_separators = 1
let g:buffet_tab_icon = "\uf00a"
let g:buffet_left_trunc_icon = "\uf0a8"
let g:buffet_right_trunc_icon = "\uf0a9"
let g:buffet_use_devicons = 1
" colorScheme for the top tab bar
function! g:BuffetSetCustomColors()
  hi! BuffetCurrentBuffer    gui=NONE guibg=#5b4e77 guifg=#e4e4e4
  hi! BuffetActiveBuffer     gui=NONE guibg=#f2be50 guifg=#282a36
  hi! BuffetBuffer           gui=NONE guibg=#282a36 guifg=#6272a4
  hi! BuffetModCurrentBuffer gui=bold,italic guibg=#5b4e77 guifg=#e4e4e4
  hi! BuffetModActiveBuffer  gui=NONE guibg=#ffb86c guifg=#282a36
  hi! BuffetModBuffer        gui=NONE guibg=#ff5555 guifg=#282a36
  hi! BuffetTrunc            gui=NONE guibg=#bd93f9 guifg=#282a36
  hi! BuffetTab              gui=NONE guibg=#bd93f9 guifg=#282a36
endfunction

" Tags
"set tags=./.tags,.tags;

lua << EOF
require("catppuccin").setup {
    default_integrations = true,
     -- auto_integrations = true,
    integrations = {
        feline = true,
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        notify = false,
        mini = {
            enabled = true,
            indentscope_color = "",
        },
    }
}
local clrs = require("catppuccin.palettes").get_palette "mocha"
local ctp_feline = require('catppuccin.special.feline')
local U = require "catppuccin.utils.colors"

local latte = require("catppuccin.palettes").get_palette "latte"

-- ctp_feline.setup()

ctp_feline.setup({
    assets = {
        left_separator = "",
        right_separator = "",
        mode_icon = "",
        dir = "󰉖",
        file = "󰈙",
        lsp = {
            server = "󰅡",
            error = "",
            warning = "",
            info = "",
            hint = "",
        },
        git = {
            branch = "",
            added = "",
            changed = "",
            removed = "",
        },
    },
    sett = {
        text = U.vary_color({ latte = latte.base }, clrs.surface0),
        bkg = U.vary_color({ latte = latte.crust }, clrs.surface0),
        diffs = clrs.mauve,
        extras = clrs.overlay1,
        curr_file = clrs.maroon,
        curr_dir = clrs.flamingo,
        show_modified = false, -- show if the file has been modified
        show_lazy_updates = false -- show the count of updatable plugins from lazy.nvim
                                  -- need to set checker.enabled = true in lazy.nvim first
                                  -- the icon is set in ui.icons.plugin in lazy.nvim
    },
    mode_colors = {
        ["n"] = { "NORMAL", clrs.lavender },
        ["no"] = { "N-PENDING", clrs.lavender },
        ["i"] = { "INSERT", clrs.green },
        ["ic"] = { "INSERT", clrs.green },
        ["t"] = { "TERMINAL", clrs.green },
        ["v"] = { "VISUAL", clrs.flamingo },
        ["V"] = { "V-LINE", clrs.flamingo },
        ["�"] = { "V-BLOCK", clrs.flamingo },
        ["R"] = { "REPLACE", clrs.maroon },
        ["Rv"] = { "V-REPLACE", clrs.maroon },
        ["s"] = { "SELECT", clrs.maroon },
        ["S"] = { "S-LINE", clrs.maroon },
        ["�"] = { "S-BLOCK", clrs.maroon },
        ["c"] = { "COMMAND", clrs.peach },
        ["cv"] = { "COMMAND", clrs.peach },
        ["ce"] = { "COMMAND", clrs.peach },
        ["r"] = { "PROMPT", clrs.teal },
        ["rm"] = { "MORE", clrs.teal },
        ["r?"] = { "CONFIRM", clrs.mauve },
        ["!"] = { "SHELL", clrs.green },
    },
    view = {
        lsp = {
            progress = true, -- if true the status bar will display an lsp progress indicator
            name = false, -- if true the status bar will display the lsp servers name, otherwise it will display the text "Lsp"
            exclude_lsp_names = {}, -- lsp server names that should not be displayed when name is set to true
            separator = "|", -- the separator used when there are multiple lsp servers
        },
    }
})

require("feline").setup({
    components = ctp_feline.get_statusline(),
})

EOF
