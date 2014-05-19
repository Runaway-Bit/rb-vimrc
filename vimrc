" Turn off backward compatibility with Vi
set nocompatible


"==============================================================================
" NeoBundle
"==============================================================================

if has ('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif


call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc', { 'build': {
      \   'windows': 'make -f make_mingw32.mak',
      \   'cygwin': 'make -f make_cygwin.mak',
      \   'mac': 'make -f make_mac.mak',
      \   'unix': 'make -f make_unix.mak',
      \ } }


"-----------
" Searching
"-----------
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'Shougo/unite-help'
"NeoBundle 'Shougo/unite-session'
NeoBundle 'thinca/vim-unite-history'
NeoBundle 'rking/ag.vim'

"--------------
" Text Editing
"--------------
NeoBundle 'tpope/vim-abolish'
NeoBundle 'csv.vim'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'IndexedSearch'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'chrisbra/NrrwRgn'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'scratch.vim'
NeoBundle 'rondale-sc/vim-spacejam'
NeoBundle 'AndrewRadev/switch.vim'
NeoBundle 'godlygeek/tabular'
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'coderifous/textobj-word-column.vim'
NeoBundle 'mbbill/undotree'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'nelstrom/vim-visual-star-search'
NeoBundle 'maxbrunsfeld/vim-yankstack'
NeoBundle 'ZoomWin'

"-----------
" Languages
"-----------
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'ap/vim-css-color'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'tpope/vim-cucumber'
NeoBundle 'tpope/vim-haml'
NeoBundle 'jQuery'
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'slim-template/vim-slim'

"--------------
" Code editing
"--------------
NeoBundle 'bkad/CamelCaseMotion'
NeoBundle 'Raimondi/delimitMate'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'matchit.zip'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'Lokaltog/powerline'
NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-rake'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'ecomba/vim-ruby-refactoring'
NeoBundle 'AndrewRadev/splitjoin.vim'
NeoBundle 'tpope/vim-surround'
NeoBundle 'scrooloose/syntastic'


filetype plugin indent on
syntax enable
NeoBundleCheck



"==============================================================================
" General Configuration
"==============================================================================

" Set augroup
  autocmd!
augroup END



"==============================================================================
" Plugin Configuration
"==============================================================================

"-------
" Unite
"-------

" Use the fuzzy matcher for everything
call unite#filters#matcher_default#use(['matcher_fuzzy'])

" Use the rank sorter for everything
call unite#filters#sorter_default#use(['sorter_rank'])

" Set up some custom ignores
call unite#custom_source('file_rec,file_rec/async,file_mru,file,buffer,grep',
      \ 'ignore_pattern', join([
      \ '\.git/',
      \ ], '\|'))

" Map space to the prefix for Unite
nnoremap [unite] <Nop>
nmap <space> [unite]

" General fuzzy search
nnoremap <silent> [unite]<space> :<C-u>Unite
      \ -buffer-name=files buffer file_mru bookmark file_rec/async
      \<CR>

" Quick registers
nnoremap <silent> [unite]r :<C-u>Unite
      \ -buffer-name=register register
      \<CR>

" Quick buffer and mru
nnoremap <silent> [unite]u :<C-u>Unite
      \ -buffer-name=buffers buffer file_mru
      \<CR>

" Quick yank history
nnoremap <silent> [unite]y :<C-u>Unite
      \ -buffer-name=yanks history/yank
      \<CR>
" Quick outline
nnoremap <silent> [unite]o :<C-u>Unite
      \ -buffer-name=outline
      \ -vertical outline
      \<CR>

" Quick sessions (projects)
" nnoremap <silent> [unite]p :<C-u>Unite
"      \ -buffer-name=sessions session
"      \<CR>

" Quick sources
nnoremap <silent> [unite]a :<C-u>Unite
      \ -buffer-name=sources source
      \<CR>

" Quick snippet
nnoremap <silent> [unite]s :<C-u>Unite
      \ -buffer-name=snippets snippet
      \<CR>

" Quickly switch lcd
nnoremap <silent> [unite]d :<C-u>Unite
      \ -buffer-name=change-cwd
      \ -default-action=lcd directory_mru
      \<CR>

" Quick file search
nnoremap <silent> [unite]f :<C-u>Unite
      \ -buffer-name=files file_rec/async file/new
      \<CR>

" Quick grep from cwd
nnoremap <silent> [unite]g :<C-u>Unite
      \ -buffer-name=grep grep:.
      \<CR>

" Quick help
nnoremap <silent> [unite]h :<C-u>Unite
      \ -buffer-name=help help
      \<CR>

" Quick line using the word under cursor
nnoremap <silent> [unite]l :<C-u>UniteWithCursorWord
      \ -buffer-name=search_file line
      \<CR>

" Quick MRU search
nnoremap <silent> [unite]m :<C-u>Unite
      \ -buffer-name=mru file_mru
      \<CR>

" Quick find
" nnoremap <silent> [unite]n :<C-u>Unite
"       \ -buffer-name=find find:.
"       \ <CR>

" Quick commands
nnoremap <silent> [unite]c :<C-u>Unite
      \ -buffer-name=commands command
      \<CR>

" Quick bookmarks
nnoremap <silent> [unite]b :<C-u>Unite
      \ -buffer-name=bookmarks bookmark
      \<CR>

" Quick commands
nnoremap <silent> [unite]; :<C-u>Unite
      \ -buffer-name=history history/command command
      \<CR>


" Custom Unite settings
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()"{{{
  imap <buffer> jj <Plug>(unite_insert_leave)
endfunction"}}}


" Tell it where to store its data
let g:unite_data_directory='~/.vim/.cache/unite'

" Start in insert mode
let g:unite_enable_start_insert = 1

" Enable short source name in window
" let g:unite_enable_short_source_names = 1

" Enable history yank source
let g:unite_source_history_yank_enable = 1

" Open in bottom right
" let g:unite_split_rule = "botright"

" Set window height options
let g:unite_winheight = 10

" Custom prompt
let g:unite_prompt = '» '

" Shorten the default update date of 500ms
let g:unite_update_time = 200

" Increase most recently used limit (default is 100)
let g:unite_source_file_mru_limit = 500

" Change highlight (defaut is PmenuSel)
let g:unite_cursor_line_highlight = 'TabLineSel'

" Change the abbreviated candidates highlight (default is Normal)
" let g:unite_abbr_highlight = 'TabLine'

let g:unite_source_file_mru_filename_format = ':~:.'
let g:unite_source_file_mru_time_format = ''

if executable('ag')
  let g:unite_source_grep_command='ag'
  let g:unite_source_grep_default_opts='--nocolor --nogroup --hidden'
  let g:unite_source_grep_recursive_opt=''
endif


"---------
" Abolish
"---------
" Configuration at ~/.vim/after/plugin/abolish.vim


"-------------
" Easy Motion
"-------------
" Rebind to <Leader> - default is <Leader><Leader> for avoiding collisions
let g:EasyMotion_leader_key = '<Leader>'


"---------------
" IndexedSearch
"---------------
" Disable colors for messages
let g:indexed_search_colors=0


"------------------
" Multiple-cursors
"------------------
" Current all defaults which are:
" let g:multi_cursor_next_key='<C-n>'
" let g:multi_cursor_prev_key='<C-p>'
" let g:multi_cursor_skip_key='<C-x>'
" let g:multi_cursor_quit_key='<Esc>'

" By default 'next' key enters multcursor mode but it could be a separate map:
" let g:multi_cursor_start_key='<F6>'


"---------------
" Narrow Region
"---------------
"

"--------
" Repeat
"--------
"

"---------
" Scratch
"---------
" Map split scratch to 'ss'
nnoremap <silent> ss :Sscratch<CR>


"---------
" Switch
"---------
" Map switching to <Leader> '-'
nnoremap <Leader>- :Switch<CR>


"---------
" Tabular
"---------
" Extra commands are at:, ~/.vim/after/plugin/tabular_extra.vim

" Assignments
nnoremap <Leader>t= :Tabularize assignment<CR>
vnoremap <Leader>t= :Tabularize assignment<CR>
" Ruby symbols
nnoremap <Leader>ts :Tabularize symbol<CR>
vnoremap <Leader>ts :Tabularize symbol<CR>
" Ruby hash
nnoremap <Leader>th :Tabularize hash<CR>
vnoremap <Leader>th :Tabularize hash<CR>
" Ruby hash rocket
nnoremap <Leader>thr :Tabularize hash_rocket<CR>
vnoremap <Leader>thr :Tabularize hash_rocket<CR>
" Comma separated lists
nnoremap <Leader>t, :Tabularize comma<CR>
vnoremap <Leader>t, :Tabularize comma<CR>
" JSON
nnoremap <Leader>tj :Tabularize json<CR>
vnoremap <Leader>tj :Tabularize json<CR>


"----------
" Undotree
"----------
" Map displaying the undo tree window to F5
nnoremap <F5> :UndotreeToggle<CR>


"-----------
" Yankstack
"-----------
" First call the setup so that yankstack mappings occur before the custom ones
call yankstack#setup()
" Disable default key mappings (for some reason aren't working)
let g:yankstack_map_keys=1
" Define them again
nmap <Leader>p <Plug>yankstack_substitute_older_paste
nmap <Leader>P <Plug>yankstack_substitute_newer_paste


"-----------
" CSS Color
"-----------
" Required for this plugin (and others) to work
set t_Co=256


"----------
" Cucumber
"----------
" tpope's script for auto tabularizing example data
"
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize')
      \&& getline('.') =~# '^\s*|'
      \&& (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction


"-----------------
" CamelCaseMotion
"-----------------
" Replace default mappings
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
sunmap w
sunmap b
sunmap e

" Replace default 'iw' text-object
omap <silent> iw <Plug>CamelCaseMotion_iw
xmap <silent> iw <Plug>CamelCaseMotion_iw
omap <silent> ib <Plug>CamelCaseMotion_ib
xmap <silent> ib <Plug>CamelCaseMotion_ib
omap <silent> ie <Plug>CamelCaseMotion_ie
xmap <silent> ie <Plug>CamelCaseMotion_ie


"-------------
" DelimitMate
"-------------
" Enable expansions
let delimitMate_expand_spac = 1
let delimitMate_jump_expansion = 1
let delimitMate_expand_cr = 1
" Because <CR> expansion is enabled, this may help skipping it on popup menus:
"inoremap <expr> <CR> delimitMate#WithinEmptyPair() ?
"             \ "\<C-R>=delimitMate#ExpandReturn()\<CR>" :
"             \ "external_mapping"
" But this does not work because interferes with 'vim-endwise'
" https://github.com/tpope/vim-endwise/pull/16

nnoremap <silent>co( :DelimitMateSwitch<CR>
nnoremap <silent>co" :DelimitMateSwitch<CR>


"---------------
" Indent-Guides
"---------------
" Change default mapping for toggle and add mappings for enabling/disabling
let g:indent_guides_default_mapping = 0
nnoremap <silent>c[\| :IndentGuidesEnable<CR>
nnoremap <silent>c]\| :IndentGuidesDisable<CR>
nnoremap <silent>co\| :IndentGuidesToggle<CR>
" Enable on startup
" let g:indent_guides_enable_on_vim_startup = 1
" Disable for some files
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']


"---------------
" NerdCommenter
"---------------
" Whole lines only when there aren't multipart delimiters
let NERDCommentWholeLinesInVMode=2
" Always remove extra spaces when uncommenting
let NERDSpaceDelims=1
let NERDRemoveExtraSpaces=1


"-----------
" Powerline
"-----------
" Pointing to where it is installed
set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
" Always display the status line in all windows
set laststatus=2
" Hide default mode text (e.g. -- INSERT --)
set noshowmode
" Remove delay when switching modes
" NOTE: this breaks jj mapping for the unite plugin
" if ! has('gui_running')
"   set ttimeoutlen=10
"   augroup FastEscape
"     autocmd!
"     au InsertEnter * set timeoutlen=0
"     au InsertLeave * set timeoutlen=1000
"   augroup END
" endif


"-----------
" SplitJoin
"-----------
" In case we want to override the default mapping
" let g:splitjoin_split_mapping = ''
" let g:splitjoin_join_mapping = ''
" nmap <Leader>j :SplitjoinJoin<CR>
" nmap <Leader>s :SplitjoinSplit<CR>


"----------
" Surround
"----------
" Use # to get a variable interpolation
let g:surround_35 = "#{\r}"


"-----------
" Syntastic
"-----------
" Toggle error location window
function! ToggleErrors()
  if empty(filter(tabpagebuflist(),
                 \'getbufvar(v:val, "&buftype") is# "quickfix"'))
    " No location/quickfix list shown, open syntastic error location panel
    Errors
    wincmd j
  else
    lclose
  endif
endfunction

nnoremap <F6> :<C-u>call ToggleErrors()<CR>

" Some general settings
let g:syntastic_check_on_open=1
let g:syntastic_enable_highlighting=0

" Status signs besides each line
let g:syntastic_enable_signs = 1
let g:syntastic_error_symbol = '✗'
highlight SyntasticWarningSign ctermfg=172 ctermbg=248
let g:syntastic_warning_symbol = '⚠'
highlight SyntasticErrorSign ctermfg=196 ctermbg=248

" This is so that the highlighted line in the locations window can be read
highlight Search cterm=underline ctermfg=none ctermbg=none

" Status line to show total number of errors and warnings and the locations
let g:syntastic_stl_format='%E{E:%e}%B{/}%W{W:%w}'

" Also followed instructions from:
" http://stackoverflow.com/questions/15777705/vim-powerline-with-syntastic-segment

