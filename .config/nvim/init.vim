set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
"source ~/.vimrc

set nocompatible              " be iMproved, required
filetype off                  " required

" Install vim-plug if we don't already have it
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

"Plug 'ycm-core/YouCompleteMe'
Plug 'vim-syntastic/syntastic'
Plug 'preservim/nerdtree'
Plug 'glepnir/dashboard-nvim'
Plug 'mbbill/undotree'
Plug 'preservim/nerdcommenter'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'tpope/vim-surround'
Plug 'majutsushi/tagbar'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-obsession'
Plug 'ryanoasis/vim-devicons'
Plug 'sainnhe/everforest'
"Plug 'b4skyx/serenade'
Plug 'semanser/vim-outdated-plugins'
Plug 'sheerun/vim-polyglot'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'w0rp/ale'
"Plug 'nathanaelkane/vim-indent-guides'
Plug 'Yggdroot/indentLine'
Plug 'vimwiki/vimwiki'
Plug 'tools-life/taskwiki'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'psliwka/vim-smoothie'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

set rtp+=~/.fzf
Plug 'junegunn/fzf.vim'
"Plug 'edkolev/tmuxline.vim'

call plug#end()

let g:everforest_enable_italic = 0
let g:everforest_disable_italic_comment = 1

if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif

set laststatus=2 " Always display the statusline in all windows
set showtabline=2 " Always display the tabline, even if there is only one tab
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
syntax enable
set background=light
let g:everforest_background = 'soft'
colorscheme everforest
hi Normal guibg=NONE ctermbg=NONE
hi NonText ctermbg=NONE ctermfg=NONE
hi EndOfBuffer ctermbg=NONE
hi LineNr ctermbg=NONE
hi Folded ctermbg=NONE guibg=NONE
hi SignColumn ctermbg=NONE guibg=NONE
set splitbelow
set splitright

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap "\" za

au BufNewFile,BufRead *.js, *.html, *.css
            \ set tabstop=2
            \ set softtabstop=2
            \ set shiftwidth=2

au FileType *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

set encoding=utf-8

"let g:ycm_autoclose_preview_window_after_completion=1
"map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

set nu

" air-line fonts
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ' ' "''
let g:airline_left_alt_sep = ' ' "''
let g:airline_right_sep = ' ' "''
let g:airline_right_alt_sep = ' ' "''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.dirty=' '


" Dashboard options
let g:dashboard_custom_header = [
            \ ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
            \ ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
            \ ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
            \ ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
            \ ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
            \ ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
            \]

let g:mapleader=" "
let g:dashboard_default_executive ='fzf'
nmap <Leader>ss :<C-u>SessionSave<CR>
nmap <Leader>sl :<C-u>SessionLoad<CR>
nnoremap <silent> <Leader>fr :DashboardFindHistory<CR>
nnoremap <silent> <Leader>ff :DashboardFindFile<CR>
nnoremap <silent> <Leader>cc :DashboardChangeColorscheme<CR>
nnoremap <silent> <Leader>fw :DashboardFindWord<CR>
nnoremap <silent> <Leader>fb :DashboardJumpMark<CR>
nnoremap <silent> <Leader>cn :DashboardNewFile<CR>

" setup for goyo & limelight
let g:limelight_conceal_ctermfg = 'gray'
let g:goyo_width = 130
let g:goyo_height = 95
let b:code = "no"

"Toggle Goyo and Limelight on and off
map <C-g> :Goyo<CR>

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" setup for tagbar
nmap <t> :TagbarToggle<CR>

" enable mouse scroll
set mouse=a

" toggle number lines
:nnoremap <C-n> :set number!<CR>

" Nerdtree
"autocmd vimenter * NERDTree
map <C-d> :NERDTreeToggle<CR>

" Toggle Undotree
nnoremap <C-u> :UndotreeToggle<CR>

" Clipboard shortcuts
:set clipboard=unnamedplus
vmap <C-c> "+y
vmap <C-x> "+c
vmap <C-v> c<ESC>"+P
imap <C-v> <C-r><C-o>+

" Yank whole line w/o newline
nmap Y ^y$

" neomutt stuff
au BufRead /tmp/mutt-* set tw=72
au BufRead /tmp/mutt-* set wrap

" airline theme
let g:airline_theme='everforest'

"Indent line settings
let g:indentLine_char = '│'
let g:indentLine_fileTypeExclude = ['dashboard']
set list lcs=tab:\│\ 
set list

" Do not show any message if all plugins are up to date. 0 by default
let g:outdated_plugins_silent_mode = 1

" Set underline cursor
set guicursor=a:hor20-Cursor

"Vimwiki settings
let g:vimwiki_list = [{'path': '~/Documents/vimwiki/',
            \ 'syntax': 'markdown', 'ext': '.md'}]

" Autoformat on save
"au BufWrite * :Autoformat

" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" All possible highlighters
let g:Hexokinase_highlighters = [
            \   'virtual',
            \   'sign_column',
            \   'background',
            \   'backgroundfull',
            \ ]

" Speed up scrolling a bit
set lazyredraw

" Highlight cursor location
set cursorline
set cursorcolumn

"" CoC example config
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
