"
" PREFERENCES
"

" 24-bit colors (may not need this?)
set termguicolors

" Line numbers
set number
set relativenumber

set ignorecase
set smartcase

" Enable copy to clipboard with yank, change, put, etc
if has('unnamedplus')
  set clipboard^=unnamed
  set clipboard^=unnamedplus
endif

" This enables us to undo files even if you exit Vim.
if has('persistent_undo')
  set undofile
  set undodir=~/.config/vim/tmp/undo//
endif

" Save on build
set autowrite

" Change tab character to four spaces
filetype plugin indent on
" Show existing tabs as four spaces
set tabstop=4
" When indenting with >, use 4 spaces
set shiftwidth=4


" Hide buffers instead of closing them
set hidden

" Make , the leader, because \ is hard
let mapleader = ","

" Use only the quickfix list for go
let g:go_list_type = "quickfix"


"
" KEY REMAPPINGS
"
"

" Editor

map <C-o> :NERDTreeToggle<CR>

" GoLang

map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

" autocmd FileType go nmap <leader>b <Plug>(go-build)
autocmd FileType go nmap <leader>r <Plug>(go-run)
autocmd FileType go nmap <leader>t <Plug>(go-test)
autocmd FileType go nmap <leader>c <Plug>(go-coverage-toggle)

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>


"
" PLUGINS
"

call plug#begin(stdpath('data') . '/plugged')

Plug 'fatih/molokai'

Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }

Plug 'mhinz/vim-startify'

Plug 'tpope/vim-commentary'

Plug 'tpope/vim-surround'

Plug 'tpope/vim-obsession'

Plug 'vim-airline/vim-airline'

Plug 'scrooloose/nerdtree'

Plug 'sheerun/vim-polyglot'

Plug 'Raimondi/delimitMate'

Plug 'ctrlpvim/ctrlp.vim'

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1


" Add additional plugins here

call plug#end()


" set statusline=%{ObsessionStatus()}
let g:airline_section_y = '%{ObsessionStatus()}'


"

" UTILS
"

" Colorscheme
set t_Co=256
let g:rehash256 = 1
let g:molokai_original = 1
colorscheme molokai

" Reloads vimrc after saving but keep cursor position
if !exists('*ReloadVimrc')
   fun! ReloadVimrc()
       let save_cursor = getcurpos()
       source $MYVIMRC
       call setpos('.', save_cursor)
   endfun
endif
autocmd! BufWritePost $MYVIMRC call ReloadVimrc()

