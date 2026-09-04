" Hotkeys
let mapleader = "\<Space>"

"" Tabs
noremap <Tab> :tabn<CR>
noremap <S-Tab> :tabp<CR>
noremap <Leader><Tab> :tabclose<CR>
noremap <Leader><S-Tab> :tabonly<CR>
noremap <Leader>t :tab split<CR>

" Neo-Tree
" nnoremap <M-f> :Neotree toggle<CR>

"" Telescope
nnoremap <leader>ff :Telescope find_files<CR>
nnoremap <leader>fg :Telescope live_grep<CR>
nnoremap <leader>fb :Telescope buffers<CR>
nnoremap <leader>fh :Telescope help_tags<CR>
nnoremap <leader>fw :Telescope grep_string<CR>
nnoremap <leader>f/ :Telescope current_buffer_fuzzy_find<CR>
nnoremap <leader>fc :Telescope commands<CR>
nnoremap <leader>fo :Telescope oldfiles<CR>
nnoremap <leader>fd :Telescope diagnostics<CR>

"" Splits
nnoremap <leader>v :vsplit<CR>
nnoremap <leader>s :split<CR>

"" Quit
nnoremap <leader>c :close<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>Q :qa<CR>

"" Delete previous word
inoremap <M-BS> <C-w>
cnoremap <M-BS> <C-w>

"" Move by word
noremap <M-f> <S-Right>
inoremap <M-f> <S-Right>
cnoremap <M-f> <S-Right>
cnoremap <M-b> <S-Left>

"" Write
nnoremap <leader>w :w<CR>
nnoremap <leader>W :w!<CR>
