"-------------------"
" INFECT EVERYTHING "
"-------------------"
execute pathogen#infect()
syntax on
filetype plugin indent on

if has('macunix')
    " Setting up Mac specific vim config
    set clipboard=unnamed
else
    " 'other', or linux hosts.
    set clipboard=unnamedplus
endif

"----------------------"
" General Vim Settings "
"----------------------"

set backspace=2
set autoindent
set smartindent
set expandtab tabstop=4 shiftwidth=4 smarttab softtabstop=4
colorscheme  elflord

set lazyredraw
set synmaxcol=256

set statusline+=%F
set laststatus=2

" Open last location
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Lol this line below doesn't like symlinks.
" If vim gives you issues due to symlinking .vimrc, it's because of the line below. Just copy .vimrc to ~/ instead of symlinking.
let g:airline_section_c = airline#section#create(['%{getcwd()}', "/", "file"])

"----------------------------"
" Custom Shortcuts and Binds "
"----------------------------"
" Vim split stuff
nnoremap <Leader>w :hide <Return>

" Zoom/Unzoom shortcuts "
noremap Zz <c-w>_ \| <c-w>\|
noremap Zo <c-w>=

" Remap split navigation "
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Make splits go below/right by default (instead of top/left)
set splitbelow
set splitright

" Line number shortcuts "
set rnu nu
command NumOn :set nu | :set rnu
command NumOff :set nonu | :set nornu
nnoremap nun :NumOn <Return>
nnoremap nuf :NumOff <Return>

"------------------------"
" Formatting/Style Stuff "
"------------------------"

highlight PMenu term=reverse ctermbg=12 gui=undercurl guisp=Blue
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

au BufWritePost *.go !gofmt -w %
let g:terraform_fmt_on_save=1

"-----------"
" Syntastic "
"-----------"
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_vue_checker=['eslint']

let g:syntastic_python_checkers=['mypy']
autocmd BufWritePost *.py silent! !black %
autocmd BufWritePost *.py edit
autocmd BufWritePost *.py redraw!

"--------------"
" any-jump.vim "
"--------------"
let g:any_jump_references_only_for_current_filetype = 1
let g:any_jump_references_enabled = 0

"---------"
" vim-vue "
"---------"
" Disable highlighting for preprocessor langs like ts/scss/pug/etc. Helps with
" slowdown of this plugin
let g:vue_pre_processors = []

"---------"
" indentLine "
"---------"
let g:indentLine_char = '⦙'
set foldlevelstart=20
let g:indentLine_bufNameExclude = ['_.*', 'NERD_tree.*']

"----------------"
" vim-yaml-folds "
"----------------"
" 'za' for "Toggle current fold"
" 'zR' for "Expand all folds"

"----------------------------"
" Filetype-specific Settings "
"----------------------------"
"
let g:html_indent_inctags = "html,body,head,tbody"

autocmd FileType yaml setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType go setlocal shiftwidth=4 tabstop=4 noexpandtab
autocmd FileType py setlocal shiftwidth=4 tabstop=4 noexpandtab
autocmd FileType javascript,typescript,vue setlocal shiftwidth=4 tabstop=4 softtabstop=4

au BufNewFile,BufRead *.yaml,*.yml so ~/.vim/bundle/vim-yaml/after/ftplugin/yaml.vim
au BufNewFile,BufRead *.erb set syntax=ruby
au BufNewFile,BufRead *.tpl setlocal ft=html

"----------"
" NERDTree "
"----------"

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

let NERDTreeShowHidden=1
let g:NERDTreeWinSize=30

" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p
" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif "
" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
"" NERDTree Plugins
let g:NERDTreeGitStatusUseNerdFonts = 1
let g:NERDTreeGitStatusShowClean = 1

"-------"
" ctrlp "
"-------"

set runtimepath^=~/.vim/bundle/ctrlp.vim
nnoremap <C-s> :CtrlP <CR>
let g:ctrlp_root_markers = ['.python-version'] " Cuz submodules don't have them :)
let g:ctrlp_custom_ignore = {
  \ 'dir': '\v[\/](\.(git|hg|svn)|node_modules)$',
  \ 'file': '\v\.(exe|so|dll|sw[opqr])$',
  \ }

"------------------------------------"
" Vim DevIcon stuff (Must come last) "
"------------------------------------"

if has('macunix')
    " Setting up Mac specific vim config
    " set guifont=Hack\ Regular\ Nerd\ Font\ Complete\ Mono:h11
    set guifont=Hack_Regular_Nerd_Font_Completeh:15
else
    " 'other', or linux hosts.
    set guifont=Hack\ Regular\ Nerd\ Font\ Complete\ 15
endif
set encoding=utf8
let g:airline_powerline_fonts = 1
