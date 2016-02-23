filetype plugin on " look in the directory ~/.vim/after/ftplugin for lang/ftype specific options

set expandtab       " insert spaces when hitting TABs
set shiftround      " round indent to multiple of 'shiftwidth'
set autoindent      " align the new line indent with the previous line
set showmatch       " show matches (highlight) when searching
set nowrapscan 
set nowrap
set background=dark " always use dark background
set hlsearch        " always show search items with reverse-video
syntax on           " use syntax highlighting automatically

" default to 'C' and bash options - other stuff can go in type specific files
set shiftwidth=4   " operation >> indents 4 columns; << unindents 4 columns
set tabstop=4      " a hard TAB displays as 4 columns
set softtabstop=4  " insert/delete 4 spaces when hitting a TAB/BACKSPACE
set textwidth=120  " lines longer than 120 columns will be broken

" makefile specific - don't expand tabs
:autocmd FileType make set noexpandtab

set lines=50
set tags=~/.vim_ctags

:colorscheme torte
" :let do_syntax_sel_menu = 1|runtime! synmenu.vim|aunmenu &Syntax.&Show\ filetypes\ in\ menu

" all the ".vim" files are in /usr/share/vim/vim64 
" source $VIMRUNTIME/mswin.vim

" CTRL-V and SHIFT-Insert are Paste
map <C-V>           "+gP
map <S-Insert>      "+gP

" CTRL-C and CTRL-Insert are Copy
vnoremap <C-C> "+y
vnoremap <C-Insert> "+y

" CTRL-X and SHIFT-Del are Cut
vnoremap <C-X> "+x
vnoremap <S-Del> "+x

" Pasting blockwise and linewise selections is not possible in Insert and
" Visual mode without the +virtualedit feature.  They are pasted as if they
" were characterwise instead.
" Note: the same stuff appears in menu.vim.
if has("virtualedit")
  nnoremap <silent> <SID>Paste :call <SID>Paste()<CR>
  func! <SID>Paste()
    let ove = &ve
    set ve=all
    normal `^
    if @+ != ''
      normal "+gP
    endif
    let c = col(".")
    normal i
    if col(".") < c " compensate for i<ESC> moving the cursor left
      normal l
    endif
    let &ve = ove
  endfunc
  inoremap <script> <C-V>   x<BS><Esc><SID>Pastegi
  vnoremap <script> <C-V>   "-c<Esc><SID>Paste
else
  nnoremap <silent> <SID>Paste  "=@+.'xy'<CR>gPFx"_2x
  inoremap <script> <C-V>   x<Esc><SID>Paste"_s
  vnoremap <script> <C-V>   "-c<Esc>gix<Esc><SID>Paste"_x
endif
imap <S-Insert>     <C-V>
vmap <S-Insert>     <C-V>

" For CTRL-V to work autoselect must be off.
" On Unix we have two selections, autoselect can be used.
if !has("unix")
  set guioptions-=a
endif

" not sure what this does, but I hope that it works when its done
nmap gs :promptr <C-R>=expand("<cword>")<CR><CR>

" use F8 to hide everything that doesn't match previous pattern
" see http://vim.wikia.com/wiki/VimTip282
" F9 not working
nnoremap <F8> :setlocal foldexpr=(getline(v:lnum)=~@/)?0:(getline(v:lnum-1)=~@/)\\|\\|(getline(v:lnum+1)=~@/)?1:2 foldmethod=expr foldlevel=0 foldcolumn=2<CR>
nnoremap <F9> :setlocal foldexpr=(getline(v:lnum)!=~@/)?0:(getline(v:lnum-1)=~@/)\\|\\|(getline(v:lnum+1)=~@/)?1:2 foldmethod=expr foldlevel=0 foldcolumn=2<CR>

" make it easier to set kernel mode options - call with ':call KernelMode()'
function! KernelMode()
    :set expandtab      " always use tabs for indenting
    :set shiftwidth=8   " operation >> indents 8 columns; << unindents 4 columns
    :set tabstop=8      " a hard TAB displays as 8 columns
    :set softtabstop=8  " insert/delete 8 spaces when hitting a TAB/BACKSPACE
    :set textwidth=90   " lines longer than 90 columns will be auto-broken
    :set colorcolumn=80 " big red bar in column 80 for the whole screen
endfunction
" vnoremap <C-K> :call KernelMode() <CR>
map <C-K>   :call KernelMode() <CR>

" make it easier to switch out of kernel mode options - call with ':call KernelMode()'
function! ApplicationMode()
    :set noexpandtab    " always use tabs for indenting
    :set shiftwidth=4   " operation >> indents 8 columns; << unindents 4 columns
    :set tabstop=4      " a hard TAB displays as 8 columns
    :set softtabstop=4  " insert/delete 8 spaces when hitting a TAB/BACKSPACE
    :set textwidth=120  " lines longer than 90 columns will be auto-broken
    :set colorcolumn="" " turn off big red bar in column 80 for the whole screen
endfunction
" vnoremap <C-K> :call KernelMode() <CR>
map <C-A>   :call ApplicationMode() <CR>
