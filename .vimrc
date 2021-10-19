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

" Lol this line below doesn't like symlinks.
" If vim gives you issues due to symlinking .vimrc, it's because of the line below. Just copy .vimrc to ~/ instead of symlinking.
let g:airline_section_c = airline#section#create(['%{getcwd()}', "/", "file"])

"------------------------"
" Formatting/Style Stuff "
"------------------------"

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
set listchars=tab:▸\ ,eol:¬

au BufWritePost *.go !gofmt -w %
let g:terraform_fmt_on_save=1

let g:syntastic_python_checkers=['mypy']
autocmd BufWritePost *.py silent! !black %
autocmd BufWritePost *.py edit
autocmd BufWritePost *.py redraw!

"----------------------------"
" Filetype-specific Settings "
"----------------------------"

au BufNewFile,BufRead *.yaml,*.yml so ~/.vim/bundle/vim-yaml/after/ftplugin/yaml.vim
au BufNewFile,BufRead *.erb set syntax=ruby
autocmd FileType javascript,typescript,vue setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2
autocmd FileType go setlocal shiftwidth=4 tabstop=4 noexpandtab
autocmd FileType py setlocal shiftwidth=4 tabstop=4 noexpandtab

let g:html_indent_inctags = "html,body,head,tbody"
au BufNewFile,BufRead *.tpl setlocal ft=html

"-----------------------"
" Line number shortcuts "
"-----------------------"

set rnu nu
command NumOn :set nu | :set rnu
command NumOff :set nonu | :set nornu
nnoremap nun :NumOn <Return>
nnoremap nuf :NumOff <Return>

"------------------------"
" Remap split navigation "
"------------------------"

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" Make splits go below/right by default (instead of top/left)
set splitbelow
set splitright

"----------"
" NERDTree "
"----------"

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

let NERDTreeShowHidden=1

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
