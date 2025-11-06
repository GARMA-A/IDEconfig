" ============================================================================
" Vim Configuration - Converted from Neovim Lua Setup
" ============================================================================
" This .vimrc file replicates the Neovim configuration from lua/ directory
" for use with classic Vim (8.0+)
" ============================================================================

" ============================================================================
" GLOBAL SETTINGS (from lua/config/globals.lua)
" ============================================================================
" Set leader key to space
let mapleader = " "
let maplocalleader = " "

" ============================================================================
" VIM OPTIONS (from lua/config/options.lua)
" ============================================================================
" Display line numbers
set number
set relativenumber

" Enable mouse support in all modes
set mouse=a

" Don't show mode in command line (we'll use statusline)
set noshowmode

" Use system clipboard (requires +clipboard feature)
if has('unnamedplus')
  set clipboard=unnamedplus
else
  set clipboard=unnamed
endif

" Enable break indent
set breakindent

" Enable persistent undo
set undofile
set undodir=~/.vim/undodir
if !isdirectory(expand('~/.vim/undodir'))
  call mkdir(expand('~/.vim/undodir'), 'p')
endif

" Case insensitive search unless uppercase is used
set ignorecase
set smartcase

" Always show sign column
set signcolumn=yes

" Faster updates (default is 4000 ms)
set updatetime=250

" Faster timeout for key combinations
set timeoutlen=50

" Split windows to the right and below
set splitright
set splitbelow

" Show whitespace characters
set list
set listchars=tab:»\ ,trail:·,nbsp:␣

" Live substitute preview (Neovim only)
if has('nvim')
  set inccommand=split
endif

" Highlight current line
set cursorline

" Keep 10 lines above/below cursor when scrolling
set scrolloff=10

" Confirm instead of failing commands
set confirm

" Enable syntax highlighting
syntax enable

" Enable filetype detection and plugins
filetype plugin indent on

" Set background (adjust as needed)
set background=dark

" Better command line completion
set wildmenu
set wildmode=longest:full,full

" Enable true colors if available
if has('termguicolors')
  set termguicolors
endif

" ============================================================================
" PLUGIN MANAGER SETUP (using vim-plug)
" ============================================================================
" Auto-install vim-plug if not present
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Begin plugin list
call plug#begin('~/.vim/plugged')

" ============================================================================
" ESSENTIAL PLUGINS (converted from lua/plugins/)
" ============================================================================

" --- Core Utilities ---
Plug 'tpope/vim-sleuth'                    " Auto-detect tabstop and shiftwidth
Plug 'tpope/vim-surround'                  " Surround text objects
Plug 'tpope/vim-commentary'                " Comment/uncomment lines

" --- Fuzzy Finder (Telescope equivalent) ---
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'                    " Fuzzy finder for files, buffers, etc.

" --- File Navigation ---
Plug 'preservim/nerdtree'                  " File explorer
Plug 'ThePrimeagen/harpoon', { 'branch': 'harpoon2' }

" --- Git Integration ---
Plug 'tpope/vim-fugitive'                  " Git commands
Plug 'airblade/vim-gitgutter'              " Git diff in sign column

" --- UI & Themes ---
Plug 'vim-airline/vim-airline'             " Status line
Plug 'vim-airline/vim-airline-themes'      " Airline themes
Plug 'folke/tokyonight.nvim'               " Tokyo Night theme

" --- Language Support & Syntax ---
Plug 'sheerun/vim-polyglot'                " Language pack for syntax
Plug 'othree/html5.vim'                    " HTML5 syntax
Plug 'stephpy/vim-yaml'                    " YAML syntax
Plug 'ekalinin/Dockerfile.vim'             " Dockerfile syntax

" --- Autocompletion & LSP ---
if has('nvim') || has('patch-8.1.1719')
  Plug 'neoclide/coc.nvim', {'branch': 'release'}  " LSP and completion
endif

" --- Code Utilities ---
Plug 'jiangmiao/auto-pairs'                " Auto-close brackets
Plug 'andymass/vim-matchup'                " Enhanced % matching
Plug 'norcalli/nvim-colorizer.lua'         " Color highlighter (Neovim only)
Plug 'mattn/emmet-vim'                     " Emmet for HTML/CSS
Plug 'mbbill/undotree'                     " Undo tree visualizer

" --- Go Development ---
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries', 'for': 'go' }

" --- Zig Development ---
Plug 'ziglang/zig.vim', { 'for': 'zig' }

" --- Markdown ---
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npm install', 'for': 'markdown' }

" --- AI Assistance (if using Copilot) ---
" Plug 'github/copilot.vim'                " GitHub Copilot (requires setup)

call plug#end()

" ============================================================================
" KEYMAPS (from lua/config/keymaps.lua)
" ============================================================================

" Clear search highlight
nnoremap <silent> <A-c> :nohlsearch<CR>
inoremap <silent> <A-c> <Esc>
vnoremap <silent> <A-c> <Esc>
if has('terminal')
  tnoremap <silent> <A-c> <C-\><C-n>
endif

" --- Recording macros and behavior changes ---
" Start recording macro with "m"
nnoremap <silent> m q
nnoremap <silent> M q
" Make "Q" behave like "I"
nnoremap <silent> Q I
" Make "q" behave like "i"
nnoremap <silent> q i

" --- Indentation and moving down ---
" Use + for indentation
nnoremap <silent> + =
nnoremap <silent> = +
vnoremap <silent> + =
vnoremap <silent> = +

" --- Word navigation ---
" Move back with "w"
nnoremap <silent> w b
vnoremap <silent> w b
" Move forward with "e"
nnoremap <silent> e w
vnoremap <silent> e w

" --- Page navigation ---
nnoremap <silent> } <C-d>
nnoremap <silent> { <C-u>
nnoremap <silent> <C-d> }
nnoremap <silent> <C-e> {

" --- Matching brackets ---
nmap <silent> <C-x> %
vmap <silent> <C-x> %

" --- Terminal mode escape (Neovim specific) ---
if has('nvim')
  tnoremap <Esc><Esc> <C-\><C-n>
endif

" --- Window navigation ---
nnoremap <silent> <A-left> <C-w>h
nnoremap <silent> <A-right> <C-w>l
nnoremap <silent> <A-down> <C-w>j
nnoremap <silent> <A-up> <C-w>k

" --- Disable ZZ ---
nnoremap <silent> ZZ <Nop>
" Z to end of line
nnoremap <silent> Z $
onoremap <silent> Z $

" --- Local marks (b becomes m) ---
nnoremap b m

" --- Move lines up/down in visual mode ---
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" --- Location list navigation ---
nnoremap <silent> <A-j> :lnext<CR>
nnoremap <silent> <A-k> :lprev<CR>

" --- Close buffer ---
nnoremap <silent> <A-=> :bd!<CR>

" --- Leader key mappings ---
nnoremap <leader>q :lopen<CR>
nnoremap <leader>> >>
vnoremap <leader>> >gv
nnoremap <leader>< <<
vnoremap <leader>< <gv

" --- Vertical split ---
nnoremap <silent> <leader>wo :vsplit<CR><C-w>h

" --- Toggle undo tree ---
nnoremap <silent> <leader>u :UndotreeToggle<CR>

" ============================================================================
" FZF KEYMAPS (Telescope equivalent)
" ============================================================================
nnoremap <leader>sf :Files<CR>
nnoremap <leader>sg :Rg<CR>
nnoremap <leader>sb :Buffers<CR>
nnoremap <leader>sh :Helptags<CR>
nnoremap <leader>sk :Maps<CR>
nnoremap <leader>s. :History<CR>
nnoremap <leader><leader> :Buffers<CR>
nnoremap <leader>/ :BLines<CR>

" ============================================================================
" AUTOCMDS (from lua/config/autocmds.lua)
" ============================================================================
augroup CustomAutocmds
  autocmd!
  
  " Highlight on yank
  if has('nvim')
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  endif
  
  " Dockerfile filetype
  autocmd BufRead,BufNewFile Dockerfile,*.dockerfile setfiletype dockerfile
  
  " Prisma filetype
  autocmd BufRead,BufNewFile *.prisma setfiletype prisma
  
  " EJS as HTML
  autocmd BufRead,BufNewFile *.ejs setfiletype html
  
  " Go formatting on save (requires vim-go)
  autocmd BufWritePre *.go :silent! GoFmt
  
  " Return to last edit position when opening files
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
    
augroup END

" ============================================================================
" COC.NVIM CONFIGURATION (LSP equivalent)
" ============================================================================
if exists('g:plugs["coc.nvim"]')
  " Extensions to install automatically
  let g:coc_global_extensions = ['coc-tsserver', 'coc-json', 'coc-html', 'coc-css', 'coc-pyright', 'coc-go', 'coc-clangd', 'coc-sql', 'coc-yaml', 'coc-diagnostic']
  
  " Use tab for trigger completion
  inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#next(1) : CheckBackspace() ? "\<Tab>" : coc#refresh()
  inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
  
  " Make <CR> to accept selected completion item
  inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
  
  function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction
  
  " Use <c-space> to trigger completion
  inoremap <silent><expr> <c-space> coc#refresh()
  
  " GoTo code navigation
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)
  
  " Show documentation in preview window
  nnoremap <silent> K :call ShowDocumentation()<CR>
  
  function! ShowDocumentation()
    if CocAction('hasProvider', 'hover')
      call CocActionAsync('doHover')
    else
      call feedkeys('K', 'in')
    endif
  endfunction
  
  " Highlight symbol under cursor
  autocmd CursorHold * silent call CocActionAsync('highlight')
  
  " Rename symbol
  nmap <leader>rn <Plug>(coc-rename)
  
  " Format selected code
  xmap <leader>f  <Plug>(coc-format-selected)
  nmap <leader>f  <Plug>(coc-format-selected)
  
  " Apply code actions
  nmap <leader>ac <Plug>(coc-codeaction)
  
  " Fix autofix problem on current line
  nmap <leader>qf <Plug>(coc-fix-current)
  
  " Diagnostic navigation
  nmap <silent> [d <Plug>(coc-diagnostic-prev)
  nmap <silent> ]d <Plug>(coc-diagnostic-next)
  
endif

" ============================================================================
" PLUGIN-SPECIFIC SETTINGS
" ============================================================================

" --- Airline ---
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='deus'

" --- GitGutter ---
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '_'
let g:gitgutter_sign_removed_first_line = '‾'
let g:gitgutter_sign_modified_removed = '~'

" --- NERDTree ---
nnoremap <leader>e :NERDTreeToggle<CR>
nnoremap <leader>fe :NERDTreeFind<CR>
let NERDTreeShowHidden=1

" --- Emmet ---
let g:user_emmet_leader_key='<C-e>'
let g:user_emmet_settings = {'typescriptreact': {'extends': 'jsx'}, 'javascriptreact': {'extends': 'jsx'}}

" --- vim-go ---
let g:go_fmt_command = "gofumpt"
let g:go_def_mapping_enabled = 0
let g:go_code_completion_enabled = 0
let g:go_gopls_enabled = 0

" --- FZF ---
let g:fzf_layout = { 'down': '40%' }
let g:fzf_preview_window = ['right:50%', 'ctrl-/']

" ============================================================================
" COLORSCHEME
" ============================================================================
" Try to set Tokyo Night theme, fallback to default if not available
try
  colorscheme tokyonight-night
catch
  colorscheme desert
endtry

" Transparent background (optional)
hi Normal guibg=NONE ctermbg=NONE
hi NormalNC guibg=NONE ctermbg=NONE
hi CursorLine guibg=NONE ctermbg=NONE

" ============================================================================
" CUSTOM FUNCTIONS
" ============================================================================

" Toggle bottom terminal (simplified version from keymaps.lua)
function! ToggleBottomTerminal()
  if !exists('g:term_buf_nr') || !bufexists(g:term_buf_nr)
    " Create new terminal at bottom
    botright new
    resize 10
    if has('nvim')
      terminal
      let g:term_buf_nr = bufnr('%')
      startinsert
    elseif has('terminal')
      terminal
      let g:term_buf_nr = bufnr('%')
    else
      echom "Terminal not supported in this Vim version"
      close
      return
    endif
  else
    " Find window with terminal buffer
    let l:term_win = bufwinnr(g:term_buf_nr)
    if l:term_win != -1
      " Terminal is visible, hide it
      execute l:term_win . 'wincmd w'
      close
    else
      " Terminal is hidden, show it
      botright new
      resize 10
      execute 'buffer ' . g:term_buf_nr
      if has('nvim')
        startinsert
      endif
    endif
  endif
endfunction

nnoremap <silent> <A--> :call ToggleBottomTerminal()<CR>

" Focus floating window (Neovim only)
if has('nvim')
  function! FocusFloatingWindow()
    for l:win in nvim_list_wins()
      let l:cfg = nvim_win_get_config(l:win)
      if has_key(l:cfg, 'relative') && l:cfg.relative != ''
        call nvim_set_current_win(l:win)
        return
      endif
    endfor
  endfunction
  
  nnoremap <silent> <A-f> :call FocusFloatingWindow()<CR>
endif

" ============================================================================
" NOTES & DIFFERENCES FROM NEOVIM CONFIG
" ============================================================================
" The following features from the Neovim Lua config are not available in Vim:
" 
" 1. Lazy.nvim plugin manager -> Using vim-plug instead
" 2. Native LSP -> Using coc.nvim as alternative
" 3. Treesitter -> Using vim-polyglot for syntax
" 4. Telescope -> Using fzf.vim as alternative
" 5. CopilotChat -> Not available (basic copilot.vim can be enabled)
" 6. Oil.nvim -> Using NERDTree instead
" 7. Harpoon terminals -> Simplified terminal toggle function
" 8. Some Neovim-specific APIs and features
"
" To install plugins, run:
"   :PlugInstall
"
" For LSP support with coc.nvim, you may need to install language servers:
"   :CocInstall coc-tsserver coc-json coc-html coc-css coc-pyright
" ============================================================================

" Print message on successful load
if !has('vim_starting')
  echom "Vim configuration loaded successfully!"
endif
