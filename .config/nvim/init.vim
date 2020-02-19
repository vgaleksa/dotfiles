"=====================================================
""Ale configuration (some commands need to be defined before ALE has been loaded)
"let g:ale_sign_column_always = 1
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 0

"glide through suggestions easily
nmap <silent> <C-K> <Plug>(ale_previous_wrap)
nmap <silent> <C-J> <Plug>(ale_next_wrap)

"say which fixers for which files ale should call
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['prettier', 'eslint'],
\	'python' : ['autopep8', 'isort'],
\	'cpp' : ['clang-format'],
\	'c' : ['clang-format'],
\	'html' : ['prettier'],
\	'css' : ['prettier'],
\   'typescript' : ['prettier', 'eslint'],
\}


"=====================================================
"  vim-plug list
call plug#begin('~/.local/share/nvim/plugged')

Plug 'itchyny/lightline.vim' "lightweight fancy status bar
Plug 'mengelbrecht/lightline-bufferline' "bufferline feature for lightline
Plug 'maximbaz/lightline-ale' "ale lightline integration

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } "revolutionary thing, check it on github
Plug 'junegunn/fzf.vim'

Plug 'sheerun/vim-polyglot' "syntax and highlighting for various languages

"Pretty way to make that Internet a better place
" Plug 'othree/yajs.vim'
" Plug 'maxmellon/vim-jsx-pretty'
" Plug 'HerringtonDarkholme/yats.vim'
" Plug 'othree/javascript-libraries-syntax.vim' "conf

"Make nvim the best place in the world TODO: Learn them!
Plug 'terryma/vim-multiple-cursors'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-vinegar'

Plug 'easymotion/vim-easymotion'

Plug 'dense-analysis/ale' "Best wat to lint and check code. See it on github!

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } "Best way to
"autocomplete your code. It needs outsourced language servers to work. See it on github!
"Plugin to load all that language servers in one place. Check conf bellow.
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

"Various languagre server which can't be loaded with client above
Plug 'deoplete-plugins/deoplete-jedi' "python jedi autocomplete
Plug 'sebastianmarkow/deoplete-rust' "rust autocomplete

Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' } "ai enchanced smart complete
Plug 'jjohnson338/deoplete-mssql' "only sql ls('language server') I found

Plug 'Shougo/neco-vim'
Plug 'Shougo/denite.nvim' " For Denite features
Plug 'Shougo/neoinclude.vim'

Plug 'ujihisa/neco-look' "english words completion

	" For snippets TODO:configure it, it won't work until then
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
"Plug 'SirVer/ultisnips' "ulti vim snippets plugin
Plug 'honza/vim-snippets'

Plug 'Shougo/echodoc.vim' "display function's args bellow statusbar

Plug 'mattn/emmet-vim' "cool emmet plugin for inserting tags and smart web html coding

Plug 'morhetz/gruvbox' "the best colorscheme ever

Plug 'airblade/vim-gitgutter' "git and nvim fusion plugin TODO:learn it

Plug 'ryanoasis/vim-devicons' "pretty icons above need it to work

call plug#end()


"=====================================================
"  Colors and schemes
set termguicolors
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox

"=====================================================
"" Deoplete
let g:deoplete#enable_at_startup = 1 "wont start automatically
"move through all mathes comfortably
"inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
"inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
call deoplete#custom#option('max_menu_width', 80) "size bih enough to show long doc info
"smart way to use tap for selecting completion
inoremap <silent><expr> <TAB>
                \ pumvisible() ? "\<C-n>" :
                \ <SID>check_back_space() ? "\<TAB>" :
                \ deoplete#manual_complete()
                function! s:check_back_space() abort
                let col = col('.') - 1
                return !col || getline('.')[col - 1]  =~ '\s'
			endfunction
"shortcuts for selecting first couple of suggestions
" call deoplete#custom#option('candidate_marks',
"                       \ ['A', 'S', 'D', 'F', 'G'])
"                 inoremap <expr>A       pumvisible() ?
"                 \ deoplete#insert_candidate(0) : 'A'
"                 inoremap <expr>S       pumvisible() ?
"                 \ deoplete#insert_candidate(1) : 'S'
"                 inoremap <expr>D       pumvisible() ?
"                 \ deoplete#insert_candidate(2) : 'D'
" 				inoremap <expr>F       pumvisible() ?
"                 \ deoplete#insert_candidate(3) : 'F'
"                 inoremap <expr>G       pumvisible() ?
"                 \ deoplete#insert_candidate(4) : 'G'

"tabnine conf
call deoplete#custom#var('tabnine', {
\ 'line_limit': 500,
\ 'max_num_results': 5,
\ })

"rust server conf
let g:deoplete#sources#rust#racer_binary='/home/vgaleksa/.cargo/bin/racer'
let g:deoplete#sources#rust#rust_source_path='/home/vgaleksa/.local/lib/rust_source_code/rust/src'
"=====================================================
"LanguageClient-neovim
set hidden

"other root markers
let g:LanguageClient_rootMarkers = {
    \ 'javascript': ['jsconfig.json'],
    \ 'typescript': ['tsconfig.json'],
    \ }

let g:LanguageClient_serverCommands = {
	\ 'sh': ['bash-language-server', 'start'],
	\ 'cpp' : ['clangd'],
	\ 'c': ['clangd'],
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'typescript': ['javascript-typescript-stdio'],
    \ }


"comfy key maps
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
set completefunc=LanguageClient#complete
set formatexpr=LanguageClient_textDocument_rangeFormatting()
nnoremap <silent> gh :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> gr :call LanguageClient#textDocument_references()<CR>
nnoremap <silent> gs :call LanguageClient#textDocument_documentSymbol()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>


"=====================================================
"echodoc

" " Or, you could use neovim's floating text feature.
" let g:echodoc#enable_at_startup = 1
" let g:echodoc#type = 'floating'
" " To use a custom highlight for the float window,
" " change Pmenu to your highlight group
" highlight link EchoDocFloat Pmenu

" Or, you could use neovim's virtual virtual text feature.
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'virtual'

"=====================================================
"  Status bar and line numbers
set nu
set relativenumber
set laststatus=2
set noshowmode

"=====================================================
" Lightline

let g:lightline = {
	\ 'colorscheme':'gruvbox',
	\ 'component_function': {
    \	'fileformat': 'LightlineFileformat',
    \	'filetype': 'LightlineFiletype',
    \ },
    \ }
" Registering components for ale linting lightline integrations
let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_infos': 'lightline#ale#infos',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ } " Setting colors
let g:lightline.component_type = {
      \     'linter_checking': 'right',
      \     'linter_infos': 'right',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'right',
      \ } " Adding components to lightline
let g:lightline.active = {
	  \'right': [ [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ],
	  \[ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype', 'charvaluehex' ] ] }

function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction


"=====================================================
"  Indentation
set tabstop=4
set shiftwidth=4
set noexpandtab


"=====================================================
" Foldmethod
set foldmethod=marker


"=====================================================
" Gitgutter
let updatetime=100 "faster showing git marker


"=====================================================
"chromatica
let g:chromatica#enable_at_startup=0


"=====================================================
"Snippets
"Ultisnips
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
" let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"
"Neosnippet
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

let g:neosnippet#snippets_directory='/home/vgaleksa/.local/share/nvim/plugged/vim-snippets'

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

"=====================================================
"easymotion
map <Leader><Leader> <Plug>(easymotion-prefix)


"=====================================================
"other settings
" Found this on stackoverflow as must have
" activates filetype detection
filetype plugin indent on

"" SYNTAX and highlighting
syntax on


" allows you to deal with multiple unsaved
" buffers simultaneously without resorting
" to misusing tabs
set hidden

" just hit backspace without this one and
" see for yourself
set backspace=indent,eol,start

let g:loaded_python_provider = 0 "stop looking for python2
let g:loaded_ruby_provider = 0 "stop looking for ruby
let g:loaded_perl_provider = 0 "stop looking for perl

let g:python3_host_prog = '/home/vgaleksa/.config/nvim/python_nvim/bin/python'

"=====================================================
