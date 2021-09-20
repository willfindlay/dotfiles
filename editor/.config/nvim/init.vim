" =========================================================================== "
" Preamble                                                                    "
" =========================================================================== "

" Basic settings
filetype off
let g:tex_flavor = "latex"
set nocompatible
let mapleader = "\<Space>"
set inccommand=nosplit
filetype plugin indent on

" Generic formatting options
au FileType * setlocal formatoptions=qn1jrc
au FileType * setlocal textwidth=90
au FileType * setlocal wrapmargin=0

" Spelling
set spellfile=~/.config/nvim/en.utf-8.add
set spelllang=en_ca
au FileType rmd,tex,markdown,pandoc setlocal spell

" =========================================================================== "
" Plugins                                                                     "
" =========================================================================== "

call plug#begin('~/.config/nvim/plugged')

" Color scheme
Plug 'chriskempson/base16-vim'

" Status line
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'

" Stop code execution attacks in my plaintext files, please
Plug 'ciaranm/securemodelines'

" Highlight yanks
Plug 'machakann/vim-highlightedyank'

" Use % key for if statements, etc.
Plug 'andymass/vim-matchup'

" Try out fzf as a fuzzy finder
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Use coc.nvim for autocompletion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Syntactic language support
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
Plug 'rust-lang/rust.vim'
Plug 'rhysd/vim-clang-format'
Plug 'plasticboy/vim-markdown'
Plug 'octol/vim-cpp-enhanced-highlight'

" LaTeX
Plug 'lervag/vimtex'

" Pandoc
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

" Tabularize all the things
Plug 'godlygeek/tabular'

" NerdTree
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Show colors
Plug 'ap/vim-css-color'

" Ctags integration
Plug 'ludovicchabant/vim-gutentags'

" Git support
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Tmux bindings
Plug 'christoomey/vim-tmux-navigator'

" Incremental search
Plug 'haya14busa/incsearch.vim'

" Useful Tim Pope plugins
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-abolish'

" Snippets
Plug 'honza/vim-snippets'

" Multiple cursors
Plug 'terryma/vim-multiple-cursors'

" Make vim gitignore aware
Plug 'vim-scripts/gitignore'

Plug 'psf/black'

Plug 'vim-scripts/SyntaxAttr.vim'

" Justfile support
Plug 'NoahTheDuke/vim-just'

" Make vim Golang aware
Plug 'fatih/vim-go'

" Diff conflicts
function! s:do_git_diff_changes(info)
    system('git config --global merge.tool diffconflicts')
    system('git config --global mergetool.diffconflicts.cmd ''vim -c DiffConflicts "$MERGED" "$BASE" "$LOCAL" "$REMOTE"''')
    system('git config --global mergetool.diffconflicts.trustExitCode true')
    system('git config --global mergetool.keepBackup false')
endfunction
" https://github.com/junegunn/vim-plug/issues/457
let DoRef = function('s:do_git_diff_changes')
Plug 'whiteinge/diffconflicts', {'do': DoRef}
unlet DoRef

call plug#end()

" =========================================================================== "
" Color Scheme                                                                "
" =========================================================================== "

" Set syntax highlighting
syntax on

" Better syntax highlighting
"autocmd BufEnter * :syntax sync fromstart

" Set colorscheme
set background=dark
let base16colorspace=256
colorscheme base16-default-dark

" Don't replace background
hi Normal ctermbg=NONE guibg=NONE
hi LineNr ctermbg=NONE guibg=NONE
highlight! link SignColumn LineNr

" No background on errors
hi Error      cterm=underline ctermbg=NONE ctermfg=NONE
hi SpellBad   cterm=underline ctermbg=NONE ctermfg=NONE
hi SpellCap   cterm=underline ctermbg=NONE ctermfg=NONE
hi SpellLocal cterm=underline ctermbg=NONE ctermfg=NONE
hi SpellRare  cterm=underline ctermbg=NONE ctermfg=NONE

" No background on diffs
hi DiffAdd     ctermbg=NONE guibg=NONE
hi DiffChange  ctermbg=NONE guibg=NONE
hi DiffDelete  ctermbg=NONE guibg=NONE
hi DiffText    ctermbg=NONE guibg=NONE
hi DiffAdded   ctermbg=NONE guibg=NONE
hi DiffFile    ctermbg=NONE guibg=NONE
hi DiffNewFile ctermbg=NONE guibg=NONE
hi DiffLine    ctermbg=NONE guibg=NONE
hi DiffRemoved ctermbg=NONE guibg=NONE

call Base16hi("Comment", g:base16_gui03, "", g:base16_cterm03, "", "", "")
highlight! link SpecialComment Comment

" Fixme should be red and Note should be green
call Base16hi("Fixme", g:base16_gui08, g:base16_gui01, g:base16_cterm08, g:base16_cterm01, "", "")
call Base16hi("Note", g:base16_gui0B, g:base16_gui01, g:base16_cterm0B, g:base16_cterm01, "", "")

" Highlighting for TODO, FIXME, and NOTE outside of comments
function! s:highlight_annotations()
	call matchadd('Todo','\<TODO\>')
	call matchadd('Fixme','\<FIXME\>')
	call matchadd('Note','\<NOTE\>')
endfunction
autocmd BufEnter * call <SID>highlight_annotations()

" =========================================================================== "
" Editor Settings                                                             "
" =========================================================================== "

" Set line numbers
set number

" Proper search
set incsearch
set ignorecase
set smartcase

" Indentation settings
set autoindent
set expandtab
set tabstop=4
set shiftwidth=4
set nosmarttab

" Set line wrapping
set breakindent
set wrap lbr

" Open splits more sensibly
set splitbelow
set splitright

" Always use signcolumn
set signcolumn=yes

" Set path
set path+=**

" Autoload files
set autoread
au CursorHold * checktime

" Use global clipboard
set clipboard=unnamedplus

" Timeout settings for mapped commands
set ttimeout
set ttimeoutlen=10

" Mouse support
set mouse=a

" Folds shouldn't open on horizontal movement
autocmd FileType * set foldopen-=hor

" Fix autocompletion settings
set completeopt=menuone,noinsert
set complete+=k
set complete+=t
set complete+=i
set pumheight=10

" No more press enter to continue
set shortmess+=c

" No more bell sounds
set belloff+=ctrlg

" Allow buffers to switch even when modified
set hidden

" Use rg if it exists
if executable('rg')
	set grepprg=rg\ --no-heading\ --vimgrep
	set grepformat=%f:%l:%c:%m
endif

" =========================================================================== "
" Custom Key Bindings                                                         "
" =========================================================================== "

" Bind ; to :
nnoremap ; :
vnoremap ; :

" Move up and down by visual line
nmap <silent> j gj
nmap <silent> k gk
vmap <silent> j gj
vmap <silent> k gk
nmap <silent> <down> gj
nmap <silent> <up> gk
vmap <silent> <down> gj
vmap <silent> <up> gk

" Center line on tag jumps
nnoremap <C-]> <C-]>zz
vnoremap <C-]> <C-]>zz
nnoremap <C-t> <C-t>zz
vnoremap <C-t> <C-t>zz

" Center line on stack jumps
nnoremap <c-o> <c-o>zz
vnoremap <c-o> <c-o>zz
nnoremap <c-i> <c-i>zz
vnoremap <c-i> <c-i>zz

" Center line on search
nnoremap n nzzzv
nnoremap N Nzzzv
vnoremap n nzzzv
vnoremap N Nzzzv

" Aliases for zz, zt, and zb to match <s-h>, <s-m>, and <s-l>
nnoremap z<s-h> zt
nnoremap z<s-m> zz
nnoremap z<s-l> zb

" Better tabbing
" nnoremap <S-Tab> <<
" nnoremap <Tab> >>
" vnoremap <S-Tab> <gv
" vnoremap <Tab> >gv

" Finally visual mode tabbing is no longer stupid
vnoremap < <gv
vnoremap > >gv

" Get rid of annoying behavior on up and down arrow keys when holding shift
inoremap <S-UP>   <UP>
nnoremap <S-UP>   <UP>
vnoremap <S-UP>   <UP>
inoremap <S-DOWN> <DOWN>
nnoremap <S-DOWN> <DOWN>
vnoremap <S-DOWN> <DOWN>

" Get rid of annoying jump by word behavior on arrow keys when holding shift or ctrl
inoremap <S-RIGHT> <RIGHT>
nnoremap <S-RIGHT> <RIGHT>
vnoremap <S-RIGHT> <RIGHT>
inoremap <S-LEFT>  <LEFT>
nnoremap <S-LEFT>  <LEFT>
vnoremap <S-LEFT>  <LEFT>
inoremap <C-RIGHT> <RIGHT>
nnoremap <C-RIGHT> <RIGHT>
vnoremap <C-RIGHT> <RIGHT>
inoremap <C-LEFT>  <LEFT>
nnoremap <C-LEFT>  <LEFT>
vnoremap <C-LEFT>  <LEFT>

" Clear search when pressing escape
nnoremap <esc> :noh<return><esc>

" I hate ctrl-b
nnoremap <C-B> <NOP>
vnoremap <C-B> <NOP>

" I hate shift-q
nnoremap <S-Q> <NOP>

" I hate shift-z-z
nnoremap <S-Z><S-Z> <NOP>

" I hate q:
nnoremap q: <NOP>

" I hate F1
nnoremap <F1> <NOP>

" This will automatically rebind :q to :close, meaning we no longer exist vim
" accidentally. To fully exit, :qa will do the trick.
cabbrev q <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'close' : 'q')<CR>

" Delete buffer without closing window
command! -bang Bd
            \ bp |
            \ if len(getbufinfo({'buflisted':1})) > 1 |
            \ bd<bang> # |
            \ else |
            \ new |
            \ bd<bang> # |
            \ endif
" remap bd to our custom Bd command
cabbrev bd <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'Bd' : 'bd')<CR>

" Wipe buffer without closing window
command! -bang Bw
            \ bp |
            \ if len(getbufinfo({'buflisted':1})) > 1 |
            \ bw<bang> # |
            \ else |
            \ new |
            \ bw<bang> # |
            \ endif
" remap bw to our custom Bw command
cabbrev bw <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'Bw' : 'bw')<CR>

" <leader>n to toggle nerdtree
nmap <silent> <leader>n :NERDTreeToggle<CR>

" <leader>w to write file
nmap <silent> <leader>w :w<CR>

" <leader>s for Rg search
nmap <leader>s :Rg<CR>

" <leader>b to display a list of buffers and start a prompt to switch
nmap <leader>b :Buffers<CR>

" <c-p> and <leader>f to list files
nmap <expr> <c-p> fugitive#head() != '' ? ':GFiles --cached --others --exclude-standard<CR>' : ':Files<CR>'
nmap <leader>f <c-p>

" <leader>1-9 to select airline tabs 1-9
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

" <leader>u to underline text
nmap <leader>u :call <SID>underline()<CR>
function! s:underline()
    normal yypVr-
endfunction

" Use <leader>z to start a terminal window
nmap <leader>z :split term://$SHELL<CR>:resize 20<CR>

" Use escape to leave terminal mode
tnoremap <Esc> <C-\><C-n>:close<CR>

" Use vim-tmux bindings in terminal mode
tmap <c-h> <C-\><C-n><c-h>
tmap <c-j> <C-\><C-n><c-j>
tmap <c-k> <C-\><C-n><c-k>
tmap <c-l> <C-\><C-n><c-l>

" Fix syntax highlight issues with <leader>hl
nnoremap <leader>hl :syntax sync fromstart<CR>
vnoremap <leader>hl :syntax sync fromstart<CR>

" coc.nvim ------------------------------------------------------------------

command! -nargs=0 NextDiagnostic :call CocAction('diagnosticNext')
command! -nargs=0 PrevDiagnostic :call CocAction('diagnosticPrevious')
command! -nargs=0 ShowDocumentation :call CocAction('definitionHover')

nnoremap <leader>e     :NextDiagnostic<CR>
nnoremap <leader><s-e> :PrevDiagnostic<CR>
nnoremap <leader>d     :CocList diagnostics<CR>
nnoremap <leader>a     :CocAction<CR>
nnoremap <leader>k     :ShowDocumentation<CR>
nnoremap <s-k>         :ShowDocumentation<CR>


" Rust ----------------------------------------------------------------------

" <leader>r to reload rust analyzer
au FileType rust nmap <leader>r :CocCommand rust-analyzer.reload<CR>

" <leader>t to run test under cursor and <leader><s-t> to run all tests
au FileType rust nmap <leader>t :RustTest<CR>
au FileType rust nmap <leader><s-t> :RustTest!<CR>

" LaTeX ---------------------------------------------------------------------

" <leader>p to launch a preview and <leader>c to compile
autocmd FileType tex,bib nmap <leader>p :VimtexView<CR>
autocmd FileType tex,bib nmap <leader>c :w!<CR>:VimtexCompileSS<CR>

" =========================================================================== "
" Auto Commands                                                               "
" =========================================================================== "

" Fix indentation in Makefiles
autocmd FileType make setlocal tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab

" Two-space identation in markup
autocmd FileType tex,html,yaml,toml,pandoc,json,bib,css setlocal tabstop=2 shiftwidth=2 indentexpr=""

" Remove trailing whitespace on write
autocmd BufWritePre * call <SID>remove_tailing_whitespace()
function s:remove_tailing_whitespace()
    let _save_pos=getpos(".")
    let _s=@/
    silent! %s/\s\+$//e
    let @/=_s
    unlet _s
    call setpos('.', _save_pos)
    unlet _save_pos
    noh
endfunction

" =========================================================================== "
" Plugin-Specific Settings                                                    "
" =========================================================================== "

" --------------
"  vim-snippets
" --------------

let g:snips_author = "William Findlay"

" --------------
"   gitgutter
" --------------

" No background on gitgutter signs
let g:gitgutter_set_sign_backgrounds = 0
highlight GitGutterAdd    ctermbg=NONE guibg=NONE
highlight GitGutterChange ctermbg=NONE guibg=NONE
highlight GitGutterDelete ctermbg=NONE guibg=NONE

" --------------
"   gutentags
" --------------

let g:gutentags_define_advanced_commands = 1
let g:gutentags_project_info = []
let g:gutentags_cache_dir = '/tmp/' . expand('$USER') . '/tags'
let g:gutentags_ctags_extra_args = ['-R']
" Work around https://github.com/ludovicchabant/vim-gutentags/issues/269 in git commits
let g:gutentags_exclude_filetypes = ['gitcommit']
let g:gutentags_exclude_filetypes = ['rust']

" TODO: Use rusty-tags to generate tags for Rust
" autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/,$RUST_SRC_PATH/rusty-tags.vi
" autocmd BufWrite *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" <bar> redraw!

" --------------
"    airline
" --------------

" Color scheme
let g:airline_theme='term'
let g:airline_powerline_fonts = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#formatter = 'buffers'

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" Airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ' ln'
let g:airline_symbols.dirty = ' !'
let g:airline_symbols.notexists = ' +'

" --------------
"     pandoc
" --------------

let g:pandoc#syntax#conceal#use = 0
let g:pandoc#folding#level = 7
let g:pandoc#folding#fdc = 0

" --------------
"      rust
" --------------

let g:rustfmt_autosave = 1

" --------------
"    nerdtree
" --------------

let NERDTreeNaturalSort      = 1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeShowHidden       = 1
let NERDTreeMinimalUI        = 1
let NERDTreeDirArrows        = 1

" -----------------
"  highlightedyank
" -----------------

let g:highlightedyank_highlight_duration = 500

" --------------
"      fzf
" --------------

let g:fzf_layout = { 'down': '~30%' }
let g:fzf_preview_window = []

" Override Rg
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   "rg --column --line-number --no-heading --color=always --smart-case --hidden --glob '!.git/**' --glob '!LICENSE' -- ".shellescape(<q-args>), 1,
  \   {}, <bang>0)

" --------------
"  clangformat
" --------------

let g:clang_format#auto_format = 1
let g:clang_format#style_options = {
            \ 'BasedOnStyle': 'LLVM',
            \ 'IndentWidth': 4,
            \ 'UseTab': 'Never',
            \ 'BreakBeforeBraces': 'Linux',
            \ 'AllowShortIfStatementsOnASingleLine': 'false',
            \ 'IndentCaseLabels': 'false',
            \ 'AlignConsecutiveAssignments': 'Consecutive'}

" --------------
"     vimtex
" --------------

let g:tex_conceal="admgsb"

au BufReadPre *.tex,*.bib,*.sty let b:vimtex_main = 'main.tex'

let g:vimtex_view_method = 'zathura'
let g:vimtex_quickfix_enabled = 1
let g:vimtex_quickfix_mode = 2
let g:vimtex_quickfix_open_on_warning = 0
let g:vimtex_text_obj_enabled = 1

" --------------
"    coc.nvim
" --------------

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" Disable semantic syntax highlighting
let g:coc_default_semantic_highlight_groups = 0

let g:coc_config_home = '$HOME/.config/nvim'

let g:coc_global_extensions = ['coc-rust-analyzer', 'coc-python', 'coc-snippets', 'coc-lists', 'coc-json']

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<C-t>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-d>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <C-l> to trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> to select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
"inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

let g:coc_enable_locationlist = 0

" --------------
"   SyntaxAttr
" --------------

command! SyntaxAttr :call SyntaxAttr()
