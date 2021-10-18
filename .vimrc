if has('macunix')
    " Setting up Mac specific vim config
    set clipboard=unnamed
else
    " 'other', or linux hosts.
    set clipboard=unnamedplus
endif

syntax on = True
set backspace=2
set autoindent
set smartindent
set expandtab tabstop=4 shiftwidth=4 smarttab softtabstop=4
colorscheme  elflord

execute pathogen#infect()
filetype plugin indent on

set lazyredraw
set synmaxcol=256

set statusline+=%F
set laststatus=2

" Lol this line below doesn't like symlinks.
" If vim gives you issues due to symlinking .vimrc, it's because of the line below. Just copy .vimrc to ~/ instead of symlinking.
let g:airline_section_c = airline#section#create(['%{getcwd()}', "/", "file"])

set rnu nu
let g:html_indent_inctags = "html,body,head,tbody"
au BufNewFile,BufRead *.tpl setlocal ft=html

let g:terraform_fmt_on_save=1

command NumOn :set nu | :set rnu
command NumOff :set nonu | :set nornu

nnoremap nun :NumOn <Return>
nnoremap nuf :NumOff <Return>

" Remap split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" Make splits go below/right by default (instead of top/left)
set splitbelow
set splitright


au BufNewFile,BufRead *.yaml,*.yml so ~/.vim/bundle/vim-yaml/after/ftplugin/yaml.vim
au BufNewFile,BufRead *.erb set syntax=ruby
autocmd FileType javascript,typescript,vue setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2
autocmd FileType go setlocal shiftwidth=4 tabstop=4 noexpandtab
autocmd FileType py setlocal shiftwidth=4 tabstop=4 noexpandtab

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

set listchars=tab:▸\ ,eol:¬

au BufWritePost *.go !gofmt -w %


let g:syntastic_python_checkers=['mypy']
autocmd BufWritePost *.py silent! !black %
autocmd BufWritePost *.py edit
autocmd BufWritePost *.py redraw!
