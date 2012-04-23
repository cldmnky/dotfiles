" set colorscheme
if &t_Co >= 256 || has('gui_running')
    colorscheme vividchalk
endif
" Pathogen
filetype off 
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

syntax on
filetype on
filetype plugin on
filetype indent on

" Make puppet files be puppet
au BufRead,BufNewFile *.pp set filetype=puppet

" Set options below
set ai           " auto indend
set si           " smart indent
set ff=unix      " file format unix dammit
set enc=utf-8
set nocompatible " nocompatible mode
set ruler        " ruler the bottom
set expandtab     " expand tabs to spaces
set tabstop=2     " define what our tabs are
set softtabstop=4 " soft tabstop
set shiftwidth=4  " # of spaces for auto indent
set tabstop=4
set smarttab      " smart tab (shiftwidth v tabstop)
set tw=0          " no textwidth set by default
set modeline      " enable modelines
set modelines=1   " number of modelines to read
set tildeop       " case change with movement rather than single char
set showmatch       " show matching brackets
set matchtime=5     " how many tenths of a second to blink matching brackets for
set noincsearch   " move curser as you type search terms
set autoread            " auto read in files that have changed underneath
set shellcmdflag=-lc  " set the ! shell to be a login shell to get at functions and aliases
set backup              " keep a backup file
set backupdir=~/.vim/backups
set history=100         " keep 50 lines of command line history
set hlsearch
set listchars=tab:>-,trail:-
set hidden

if version >= 703
    set colorcolumn=80    " highlight the 80th column
    set listchars=nbsp:¶,eol:¬,tab:>-,extends:»,precedes:«,trail:• " characters to use for 'specical' characters and non-printables
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent    " always set autoindenting on

endif " has("autocmd")
let mapleader = ","
" ------------------------------------
" Comment settings
" ------------------------------------
let NERDSpaceDelims = 1
let g:NERDCustomDelimiters = {
      \ 'puppet': { 'left': '#', 'leftAlt': '/*', 'rightAlt': '*/' }
      \ }
let NERDAllowAnyVisualDelims = 1
let NERDCompactSexyComs = 0
let NERDSexyComMarker = ""

" Highlight trailing whitespaces
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$/

" set statusline to always be present see plugin/statusline.vim for actual
" setting of the statusline
set laststatus=2

" allow loose skeleton matching for templates
" ie init.pp (a puppet filetype) will match init_puppet
let g:EteSkeleton_loosefiletype = 1

" open vimrc in new vsplit for quick config changes
nmap <leader>v :tabnew ~/.vimrc<cr>:lcd ~/.vim<cr>
" nocomplcache stuff
let g:neocomplcache_enable_at_startup = 1

" settings for taglist
let tlist_puppet_settings='puppet;c:class;d:define;s:site'
nnoremap <silent><leader>t :TlistToggle<CR>

" set supertab to do context based completion
let g:SuperTabDefaultCompletionType = "context"

" autoclose syntastic's error windown when no errors
let g:syntastic_auto_loc_list=2

" enable puppet module detection
let g:puppet_module_detect=1

source $HOME/.vim/snippets/support_functions.vim 
imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
let g:snippets_dir="~/.vim/snippets/"
let g:snips_author = 'Magnus Bengtsson'

inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
let g:neocomplcache_enable_auto_select = 1
let g:neocomplcache_auto_completion_start_length = 1
let g:neocomplcache_enable_auto_select = 0

let g:rails_menu=2
let g:gist_clip_command = 'pbcopy'
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1

" Better surround
let g:surround_40 = "(\r)"
let g:surround_91 = "[\r]"
let g:surround_60 = "<\r>"

let g:acp_ignorecaseOption = 0

let g:SuperTabLongestEnhanced = 1
let g:SuperTabLongestHighlight = 1
let g:SuperTabCrClosePreview = 1

map gb <C-^>
vmap gl :<C-U>!blame <C-R>=expand("%:p") <CR> <C-R>=line("'<") <CR> <C-R>=line("'>") <CR> <CR>
vmap # :TComment<CR>
map - :Tabularize hash
map <C-l> :nohl
map <leader>a :Tabularize /=>\?<cr>

" Make j/k move to next visual line instead of physical line
" http://yubinkim.com/?p=6
nnoremap k gk
nnoremap j gj
nnoremap gk k
nnoremap gj j

hi IncSearch term=reverse gui=underline guibg=Blue  guifg=Yellow
hi    Search term=reverse gui=underline guibg=Black guifg=Yellow
hi    Visual term=reverse cterm=reverse ctermbg=9 guibg=#555577 guifg=Black

hi Pmenu      guifg=White guibg=Blue
hi PmenuSel   gui=italic guifg=Yellow guibg=Blue
hi PmenuSbar  ctermbg=Black guibg=Grey
hi PmenuThumb guifg=Yellow guibg=Black

if has("gui_running")
  set lines=80 
  set columns=120 
  set number
endif

if has("gui_macvim")
  " write on pretty much any event (including :q) 
  set autowriteall
  set tabpagemax=100
  set guifont=Monofur:h20
endif

" Nice statusbar
autocmd BufNewFile,BufRead *.css set fdm=marker fmr={,}
