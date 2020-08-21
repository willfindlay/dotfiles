" *****************************************************************************
" File:         .vimrc
" Author:       William Findlay <william@wfindlay.com>
" Source:       http://www.github.com/HousedHorse/vimrc
"
" Disclaimer:   This vimrc is under constant changes and updates.
"               Many parts of it (in particular the Airline Theme)
"               are configured to work best with MY terminal colorscheme.
"               Results may vary.
"
" Instructions: To install this vimrc and my plugins, change into this
"               directory and run "cp -r .vim ~ && cp .vimrc ~". If you
"               wish to edit this file and are unsure how folding works,
"               either enter insert mode over top of the fold you want
"               to edit, or simply press <space> in normal mode over top
"               of the fold you want to inspect.
"
" License:      MIT
" *****************************************************************************

" Preamble -------------------------------------------------------------- {{{

filetype off
let g:jsx_ext_required = 0
let g:tex_flavor = "latex"
filetype plugin indent on
set nocompatible
let mapleader=","
silent !mkdir -p /tmp/tags
set inccommand=nosplit
"set relativenumber
set colorcolumn=80
set spellfile=~/.config/nvim/en.utf-8.add

" Formatting options specific to rmd, md, and tex files
au FileType rmd setlocal indentexpr=""
au FileType md  setlocal indentexpr=""
au FileType tex setlocal indentexpr=""

" Generic formatting options
au FileType * setlocal formatoptions=qn1jrc
au FileType * setlocal textwidth=80
au FileType * setlocal wrapmargin=0

call plug#begin()

" Load plugins
" Stop code execution attacks in my plaintext files, please
Plug 'ciaranm/securemodelines'

" Status line
"Plug 'itchyny/lightline.vim'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'

" Highlight yanks
Plug 'machakann/vim-highlightedyank'

" Use % key for if statements, etc.
Plug 'andymass/vim-matchup'

" Change to root directory of repo
Plug 'airblade/vim-rooter'

" Fuzzy finder
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"Plug 'junegunn/fzf.vim'
Plug 'kien/ctrlp.vim'

" Intellisense in vim
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

" Syntactic language support
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
Plug 'rust-lang/rust.vim'
Plug 'rhysd/vim-clang-format'
Plug 'plasticboy/vim-markdown'
Plug 'vim-ruby/vim-ruby'

" Tabularize all the things
Plug 'godlygeek/tabular'

" NerdTree
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Python language support
Plug 'jeetsukumaran/vim-pythonsense'
Plug 'psf/black', { 'tag': '19.10b0' }
Plug 'heavenshell/vim-pydocstring', { 'do': 'make install' }

" Show colors
Plug 'ap/vim-css-color'

" LaTeX
Plug 'lervag/vimtex'

" Pandoc
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

" Mediawiki
Plug 'chikamichi/mediawiki.vim'

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

Plug 'octol/vim-cpp-enhanced-highlight'

call plug#end()

" }}}
" Basic Options --------------------------------------------------------- {{{

" enable syntax highlighting
syntax on
syntax sync fromstart

" path settings
"set autochdir
set path+=**

" Autoload files
set autoread
au CursorHold * checktime

" clipboard settings
set clipboard=unnamedplus

" timeout settings for mapped commands
"set notimeout
set ttimeout
set ttimeoutlen=10
" mouse support
set mouse=a

" cursor settings
set guicursor+=a:blinkwait700-blinkon400-blinkoff250

" indentation settings
set autoindent
set expandtab
set tabstop=4
set shiftwidth=4
set nosmarttab

" open splits more sensibly
set splitbelow
set splitright

" folds shouldn't open on horizontal movement
autocmd FileType * set foldopen-=hor

" fix autocompletion settings
set completeopt=menuone,noinsert
set complete+=k
set complete+=t
set complete+=i
set pumheight=10

" no more press enter to continue
set shortmess+=c

" no more bell sounds
set belloff+=ctrlg

" allow buffers to switch even when modified
set hidden

" set line numbers to be on by default
" (I don't know why this isn't a default setting lol)
set number

" set line wrapping
set breakindent
set wrap lbr

" }}}
" Plugin Options -------------------------------------------------------- {{{

set signcolumn=yes

" Vimtex {{{
let g:vimtex_view_method = 'zathura'
let g:vimtex_quickfix_enabled = 1
" Disable overfull/underfull \hbox and all package warnings
let g:vimtex_quickfix_latexlog = {
      \ 'overfull' : 0,
      \ 'underfull' : 0,
      \ 'packages' : {
      \   'default' : 0,
      \ },
      \}
let g:vimtex_text_obj_enabled = 1
" }}}
" PythonDocstring {{{
let g:pydocstring_enable_mapping = 0
let g:pydocstring_doq_path = '/home/housedhorse/.local/bin/doq'
let g:pydocstring_formatter = 'numpy'
" }}}
" Clang Formatter {{{
"let g:clang_format#auto_format = 1
let g:clang_format#auto_format = 0
let g:clang_format#style_options = {
            \ 'AllowShortIfStatementsOnASingleLine': 'false',
            \ 'AllowShortFunctionsOnASingleLine': 'false',
            \ 'AlignTrailingComments': 'true',
            \ 'AlignConsecutiveAssignments': 'false',
            \ 'AlignConsecutiveMacros': 'true',
            \ 'AllowAllArgumentsOnNextLine': 'true',
            \ 'AllowAllParametersOfDeclarationOnNextLine': 'true',
            \ 'DerivePointerAlignment': 'false',
            \ 'PointerAlignment': 'Right',
            \ 'BreakBeforeBraces': 'Linux' }
" }}}
" Commentary {{{
autocmd FileType pandoc setlocal commentstring=<!--\ %s\ -->
" }}}
" Coc {{{
" change location of Coc config
let g:coc_config_home='$HOME/.config/nvim'

" Coc global extensions
let g:coc_global_extensions = ['coc-python', 'coc-snippets', 'coc-lists', 'coc-json']

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<C-t>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-d>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
"inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> <c-k> :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
"autocmd CursorHold * silent call CocActionAsync('highlight')

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

let g:coc_enable_locationlist = 0
" }}}
" Gutentags {{{
let g:gutentags_cache_dir = '/tmp/tags'
let g:gutentags_ctags_extra_args = ['-R']
" }}}
" Ctrl-P {{{
let g:ctrlp_show_hidden = 1
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_match_current_file = 1
let g:ctrlp_open_new_file = 'r'
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
" }}}
" Airline {{{
let g:airline_theme='base16_gruvbox_dark_hard'
let g:airline_powerline_fonts = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#formatter = 'buffers'

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" airline symbols
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
" }}}
" NERDTree {{{

" Toggle tree and root at VCS if possible
nnoremap <silent> <C-N> :NERDTreeToggleVCS<CR>

" we don't want to overwrite nerdtree
autocmd FileType nerdtree cnoreabbrev <buffer> e wincmd p<CR>:e

let NERDTreeMapActivateNode ='<space>'
let NERDTreeMapHelp         ='<s-H>'
let NERDTreeMapToggleFiles = 0
let NERDTreeMapToggleFilters = 0
au FileType nerdtree nnoremap <s-F> :NERDTreeFind<CR>

let NERDTreeNaturalSort      = 1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeShowHidden       = 1
let NERDTreeMinimalUI        = 1
let NERDTreeDirArrows        = 1

" }}}
" Pandoc/Rmd {{{
let g:pandoc#syntax#conceal#use = 0
let g:pandoc#folding#level = 7
let g:pandoc#folding#fdc = 0
" }}}
" Grammarous {{{
" }}}
" Vim-Go     {{{
" let g:go_mod_fmt_autosave = 0
" let g:go_doc_keywordprg_enabled = 0
" let g:go_template_autocreate = 0
" let g:go_imports_autosave = 0
" }}}
" Rust       {{{
let g:rustfmt_autosave = 1
" }}}
" Python     {{{
"au BufWritePre *.py silent! execute "Black"
let g:black_linelength = 79
let g:black_skip_string_normalization = 1
" }}}
" HighlightedYank {{{
let g:highlightedyank_highlight_duration = 500
" }}}
" Vim Fzf {{{
"nnoremap <C-P> :<C-U>FZF<CR>
" }}}

" }}}
" Highlighting Options -------------------------------------------------- {{{

" jsonc {{{
autocmd FileType json syntax match Comment +\/\/.\+$+
" }}}

" Spellcheck underlines
hi Error      cterm=underline ctermbg=NONE
hi SpellBad   cterm=underline ctermbg=NONE
hi SpellCap   cterm=underline ctermbg=NONE
hi SpellLocal cterm=underline ctermbg=NONE
hi SpellRare  cterm=underline ctermbg=NONE

"  links
hi Underlined cterm=underline ctermfg=4 ctermbg=NONE

" Comments
hi Comment         cterm=NONE ctermfg=8 ctermbg=NONE
hi PythonDocstring cterm=NONE ctermfg=8 ctermbg=NONE

" Constants
hi  Constant  cterm=NONE ctermfg=16 ctermbg=NONE
hi  String    cterm=NONE ctermfg=2  ctermbg=NONE
"hi Character cterm=NONE ctermfg=16 ctermbg=NONE
"hi Number    cterm=NONE ctermfg=16 ctermbg=NONE
"hi Boolean   cterm=NONE ctermfg=16 ctermbg=NONE
"hi Float     cterm=NONE ctermfg=16 ctermbg=NONE

" Identifiers
hi  Identifier cterm=NONE ctermfg=4 ctermbg=NONE
"hi Function   cterm=NONE ctermfg=4 ctermbg=NONE

" Statements
hi  Statement   cterm=NONE ctermfg=5 ctermbg=NONE
"hi Conditional cterm=NONE ctermfg=5 ctermbg=NONE
"hi Repeat      cterm=NONE ctermfg=5 ctermbg=NONE
"hi Label       cterm=NONE ctermfg=5 ctermbg=NONE
hi  Operator    cterm=NONE ctermfg=5 ctermbg=NONE
"hi Keyword     cterm=NONE ctermfg=5 ctermbg=NONE
"hi Exception   cterm=NONE ctermfg=5 ctermbg=NONE

" PreProcs
hi PreProc   cterm=NONE ctermfg=3 ctermbg=NONE
hi Include   cterm=NONE ctermfg=5 ctermbg=NONE
hi Define    cterm=NONE ctermfg=5 ctermbg=NONE
hi Macro     cterm=NONE ctermfg=1 ctermbg=NONE
hi PreCondit cterm=NONE ctermfg=6 ctermbg=NONE

" Types
hi  Type         cterm=NONE ctermfg=3 ctermbg=NONE
"hi StorageClass cterm=NONE ctermfg=3 ctermbg=NONE
"hi Structure    cterm=NONE ctermfg=3 ctermbg=NONE
"hi Typedef      cterm=NONE ctermfg=3 ctermbg=NONE

" Special Patterns
hi  Special        cterm=NONE ctermfg=white ctermbg=NONE
"hi SpecialChar    cterm=NONE ctermfg=white ctermbg=NONE
"hi Tag            cterm=NONE ctermfg=white ctermbg=NONE
hi  Delimiter      cterm=NONE ctermfg=3 ctermbg=NONE
hi  SpecialComment cterm=NONE ctermfg=8 ctermbg=NONE
"hi Debug          cterm=NONE ctermfg=white ctermbg=NONE

" Todo Fixme and Note
hi Todo  cterm=NONE ctermfg=11 ctermbg=black
hi Fixme cterm=NONE ctermfg=1  ctermbg=black
hi Note  cterm=NONE ctermfg=2  ctermbg=black

" Search menu
hi MatchParen cterm=NONE ctermfg=9 ctermbg=NONE
hi Search     cterm=NONE ctermfg=7 ctermbg=8
hi IncSearch  cterm=NONE ctermfg=7 ctermbg=8

" Visual selection
hi Visual cterm=NONE ctermfg=7 ctermbg=8

" Highlighted yank
hi HighlightedyankRegion cterm=NONE ctermfg=black ctermbg=16

" Autocomplete menu
hi Pmenu    ctermbg=black ctermfg=7
hi PmenuSel ctermbg=11    ctermfg=black

" Errors and warnings
hi ErrorMsg   ctermfg=1 ctermbg=NONE
hi WarningMsg ctermfg=3 ctermbg=NONE

" Fix splits
hi VertSplit cterm=NONE ctermbg=NONE ctermfg=15

" Folds are no longer unreadable
hi Folded cterm=NONE ctermbg=NONE ctermfg=6

" Line numbers
hi LineNr       cterm=NONE ctermfg=8 ctermbg=NONE
hi CursorLineNr cterm=NONE ctermfg=7 ctermbg=NONE

" Color column
hi ColorColumn cterm=NONE ctermbg=19

" Fix signcolumn
hi SignColumn ctermbg=NONE

" Diff Colors
hi DiffAdd ctermbg=235 ctermfg=108 cterm=reverse guibg=#262626 guifg=#87af87 gui=reverse
hi DiffChange ctermbg=235 ctermfg=103 cterm=reverse guibg=#262626 guifg=#8787af gui=reverse
hi DiffDelete ctermbg=235 ctermfg=131 cterm=reverse guibg=#262626 guifg=#af5f5f gui=reverse
hi DiffText ctermbg=235 ctermfg=208 cterm=reverse guibg=#262626 guifg=#ff8700 gui=reverse

" }}}
" Compiler -------------------------------------------------------------- {{{
" Run the Makefile
function RunMake(shouldClean)
    execute "wa!"
    if a:shouldClean
        execute "!make clean; make"
    else
        execute "!make"
    endif
endfunction

" Compiler script
function Compiler(shouldClean)
    " Catch-all for Makefiles
    if filereadable("Makefile")
        call RunMake(a:shouldClean)
        return
    endif
    " File-specific options
    if &filetype ==# 'tex'
        execute "!latexmk -pdf %"
        return
    endif
    throw "No Makefile found and no alternative defaults specified."
endfunction

" Add key bindings
"nnoremap <leader>c :call Compiler(0)<CR>
"nnoremap <leader><S-C> :call Compiler(1)<CR>
" }}}
" Autocommands ---------------------------------------------------------- {{{

" LaTeX template try to fold annoying sections
function FoldTexTemplate()
    silent execute "%g/Preamble.*\\s\\+=\\+\\s*{{{$/norm zc"
    silent execute "%g/Title.*\\s\\+=\\+\\s*{{{$/norm zc"
    silent execute "%g/Bibliography.*\\s\\+=\\+\\s*{{{$/norm zc"
    silent execute "%g/Appendix.*\\s\\+=\\+\\s*{{{$/norm zc"
    silent execute 1
endfunction
au FileType tex call FoldTexTemplate()

" Pandoc markdown template try to fold annoying sections
function FoldPandocTemplate()
    silent execute "%g/Preamble.*\\s\\+=\\+\\s*{{{/norm zc"
    silent execute "%g/Title.*\\s\\+=\\+\\s*{{{/norm zc"
    silent execute "%g/Bibliography.*\\s\\+=\\+\\s*{{{/norm zc"
    silent execute "%g/Appendix.*\\s\\+=\\+\\s*{{{/norm zc"
    silent execute 1
endfunction
au FileType pandoc call FoldTexTemplate()

" prolog syntax highlighting
autocmd BufEnter *.pl set syntax=prolog

" javascript better highlighting with typescript plugin
autocmd BufEnter *.js set syntax=typescript

function FIfEmpty(func)
    if @% == ""
        " No filename for current buffer
        call a:func()
    elseif filereadable(@%) == 0
        " File doesn't exist yet
        call a:func()
    elseif line('$') == 1 && col('$') == 1
        " File is empty
        call a:func()
    endif
endfunction

function InitTex()
    execute "r $HOME/.vimskeletons/tex"
    execute "1d"
    execute "w"
    call FoldTexTemplate()
endfunction

function DoTexSetup()
    call FIfEmpty(function('InitTex'))
endfunction

" typsetting languages
autocmd BufEnter main.tex :call DoTexSetup()
autocmd FileType rmd setlocal spell
autocmd FileType rmd setlocal spelllang=en_us
autocmd FileType markdown setlocal spell
autocmd FileType markdown setlocal spelllang=en_us
autocmd FileType rmd,markdown nnoremap <leader>p :w!<CR>:!preview %<CR>

autocmd FileType tex setlocal spell
autocmd FileType tex setlocal spelllang=en_us
autocmd FileType tex nnoremap <leader>p :VimtexView<CR>
autocmd FileType tex nnoremap <leader>c :w!<CR>:VimtexCompileSS<CR>
autocmd FileType tex nnoremap <leader><S-C> :VimtexCompile<CR>

" makefiles
autocmd FileType make setlocal tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab

" html, yaml, json, bib indentation
autocmd FileType html,yaml,json,bib,css setlocal tabstop=2 shiftwidth=2 indentexpr=""

" fix C preprocessor indentation
set cinkeys=0{,0},0),:,!^F,o,O,e

" remove trailing whitespace on write
autocmd BufWritePre *
    \ let _save_pos=getpos(".") |
    \ let _s=@/ |
    \ silent! %s/\s\+$//e |
    \ let @/=_s |
    \ unlet _s |
    \ call setpos('.', _save_pos) |
    \ unlet _save_pos |
    \ noh

" add .vim/words dictionarties autocompletion
autocmd FileType * execute 'setlocal dict+=~/.vim/words/'.&filetype.'.txt'

" set omnifunc intelligently
autocmd Filetype *
      \	if &omnifunc == "" |
      \		setlocal omnifunc=syntaxcomplete#Complete |
      \	endif
" }}}
" Destroy Infuriating Key Mappings -------------------------------------- {{{

" get rid of annoying behavior on up and down arrow keys when holding shift
inoremap <S-UP>   <UP>
nnoremap <S-UP>   <UP>
vnoremap <S-UP>   <UP>
inoremap <S-DOWN> <DOWN>
nnoremap <S-DOWN> <DOWN>
vnoremap <S-DOWN> <DOWN>

" get rid of annoying jump by word behavior on arrow keys when holding shift
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

" I hate ctrl-b
nnoremap <C-B> <NOP>
vnoremap <C-B> <NOP>

" I hate shift-q
nnoremap <S-Q> <NOP>

" I hate shift-z-z
nnoremap <S-Z><S-Z> <NOP>

" I hate q:
nnoremap q: <NOP>

" rebind H M L to gH gM gL to prevent accidental presses
" to be honest I never use these anyway :P
nnoremap g<s-H> <S-H>
nnoremap g<s-M> <S-M>
nnoremap g<s-L> <S-L>
nnoremap <S-H>  <NOP>
nnoremap <S-M>  <NOP>
nnoremap <S-L>  <NOP>

" I hate <F1>, K
nnoremap <F1> <NOP>
vnoremap <F1> <NOP>
"nnoremap K <NOP>

" I hate ctrl wq
nnoremap <C-W>q <NOP>
nnoremap <C-W><C-Q> <NOP>
vnoremap <C-W>q <NOP>
vnoremap <C-W><C-Q> <NOP>

" }}}
" Improvements to Existing Mappings ------------------------------------- {{{

" more intelligent quitting
"command Wclose w | close
"cabbrev q <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'close' : 'q')<CR>
"cabbrev wq <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'Wclose' : 'wq')<CR>

" center line on tag jumps
nnoremap <C-]> <C-]>zz
vnoremap <C-]> <C-]>zz
nnoremap <C-t> <C-t>zz
vnoremap <C-t> <C-t>zz

" center line on stack jumps
nnoremap <c-o> <c-o>zz
vnoremap <c-o> <c-o>zz
nnoremap <c-i> <c-i>zz
vnoremap <c-i> <c-i>zz

" center line on search
nnoremap n nzzzv
nnoremap N Nzzzv

" autocomplete menu interaction with arrow keys
inoremap <expr> <down> ((pumvisible())?("\<C-n>"):("\<C-o>gj"))
inoremap <expr> <up> ((pumvisible())?("\<C-p>"):("\<C-o>gk"))
inoremap <expr> <left> ((pumvisible())?("\<C-e>\<left>"):("\<left>"))
inoremap <expr> <right> ((pumvisible())?("\<C-e>\<right>"):("\<right>"))
" autocomplete enter to select
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" auto highlight the menu
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" remap leader to do what <c-i> and <c-o> did

" better tabs
"inoremap <S-Tab> <C-d>
"inoremap <Tab> <C-t>
nnoremap <S-Tab> <<
nnoremap <Tab> >>
vnoremap <S-Tab> <gv
vnoremap <Tab> >gv

" Finally visual mode tabbing is no longer stupid
vnoremap < <gv
vnoremap > >gv

" move up and down by visual line
nmap <silent> <Down> gj
nmap <silent> <Up> gk
vmap <silent> <Down> gj
vmap <silent> <Up> gk

" clear search on pressing escape
nnoremap <esc> :noh<return><esc>

" }}}
" Custom Mappings ------------------------------------------------------- {{{

" lets you press ; instead of : if you want want to press shift
nnoremap ; :
vnoremap ; :

" arrow keys to switch windows
nnoremap <C-W><LEFT> <C-W>h
nnoremap <C-W><RIGHT> <C-W>l
nnoremap <C-W><UP> <C-W>k
nnoremap <C-W><DOWN> <C-W>j
nnoremap <C-W><C-LEFT> <C-W>h
nnoremap <C-W><C-RIGHT> <C-W>l
nnoremap <C-W><C-UP> <C-W>k
nnoremap <C-W><C-DOWN> <C-W>j
" even in insert mode
inoremap <C-W><LEFT> <esc><C-W>h
inoremap <C-W><RIGHT> <esc><C-W>l
inoremap <C-W><UP> <esc><C-W>k
inoremap <C-W><DOWN> <esc><C-W>j
inoremap <C-W><C-LEFT> <esc><C-W>h
inoremap <C-W><C-RIGHT> <esc><C-W>l
inoremap <C-W><C-UP> <esc><C-W>k
inoremap <C-W><C-DOWN> <esc><C-W>j
" I always press <c-w> in insert mode by accident
inoremap <c-w> <NOP>

" allow C-W commands while in insert mode
tnoremap <C-W><C-W> <C-\><C-n><C-W><C-W>
tnoremap <C-W>W <C-\><C-n><C-W><C-W>
tnoremap <C-W><C-LEFT> <C-\><C-n><C-W>h
tnoremap <C-W><C-RIGHT> <C-\><C-n><C-W>l
tnoremap <C-W><C-UP> <C-\><C-n><C-W>k
tnoremap <C-W><C-DOWN> <C-\><C-n><C-W>j

" hotkeys to switch to tab indices
"nnoremap <leader>1 1gt
"nnoremap <leader>2 2gt
"nnoremap <leader>3 3gt
"nnoremap <leader>4 4gt
"nnoremap <leader>5 5gt
"nnoremap <leader>6 6gt
"nnoremap <leader>7 7gt
"nnoremap <leader>8 8gt
"nnoremap <leader>9 9gt
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

" quickly switch between buffers
nnoremap <leader>b :bn<cr>
nnoremap <leader><S-B> :bp<cr>
nnoremap <leader>n :bn<cr>
nnoremap <leader>p :bp<cr>
nnoremap <leader>d :bd<cr>
nnoremap <leader>; :buffers<cr>:buffer<space>

" quickly switch between tabs
nnoremap <leader>t gt
nnoremap <leader><S-T> gT

" move folds by arrow keys
nnoremap z<UP> zk
nnoremap z<DOWN> zj

" underline a line
nnoremap <leader>u :Underline<cr>

" }}}
" Folding --------------------------------------------------------------- {{{

set foldlevelstart=9999
set foldmethod=marker

" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> za

" Make zO recursively open whatever fold we're in, even if it's partially open.
nnoremap zO zczO

function! MyFoldText()
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction
set foldtext=MyFoldText()

" }}}
" Neovim Specific ------------------------------------------------------- {{{

if has('nvim')
else
    set encoding=utf-8
endif

" }}}
" Other Commands and Functions ----------------------------------------- {{{

" underline lines
function! s:Underline() abort
    normal! ma
    normal! j
    let s:belowline = getline('.')
    if s:belowline =~ '^\s*-\+$'
        normal! "_dd
    endif
    normal! `ayyp^vg_r-`a
endfunction
command! Underline call s:Underline()

" close buffer without closing window
command -bang Bd
            \ bp |
            \ if len(getbufinfo({'buflisted':1})) > 1 |
            \ bd<bang> # |
            \ else |
            \ new |
            \ bd<bang> # |
            \ endif
" remap bd to our custom Bd command
cabbrev bd <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'Bd' : 'bd')<CR>

" wipe buffer without closing window
command -bang Bw
            \ bp |
            \ if len(getbufinfo({'buflisted':1})) > 1 |
            \ bw<bang> # |
            \ else |
            \ new |
            \ bw<bang> # |
            \ endif
" remap bw to our custom Bw command
cabbrev bw <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'Bw' : 'bw')<CR>

" sudo writing
command Sudowrite w !sudo tee "%" > /dev/null 2> /dev/null
cabbrev w!! <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'Sudowrite' : 'w!!')<CR>

" highlighting for TODO, FIXME outside of comments
function! HighlightAnnotations()
    call matchadd('Todo','\<TODO\>')
    call matchadd('Fixme','\<FIXME\>')
    call matchadd('Note','\<NOTE\>')
endfunction
autocmd BufEnter * call HighlightAnnotations()

function Inc(...)
  let result = g:i
  let g:i += a:0 > 0 ? a:1 : 1
  return result
endfunction

" }}}
