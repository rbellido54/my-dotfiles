" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

    " Better Syntax Support
    Plug 'sheerun/vim-polyglot'
    " Auto pairs for '(' '[' '{'
    Plug 'jiangmiao/auto-pairs'

    " File explorers
    " Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
    Plug 'nvim-tree/nvim-tree.lua'

    Plug 'sindrets/winshift.nvim'

    " THEMES
    Plug 'joshdick/onedark.vim'
    Plug 'chriskempson/base16-vim'
    Plug 'rafamadriz/neon'
    Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
    Plug 'EdenEast/nightfox.nvim'
    Plug 'sainnhe/everforest'
    Plug 'ajmwagar/vim-deus'
    Plug 'mhartington/oceanic-next'
    Plug 'rebelot/kanagawa.nvim'
    Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
    Plug 'ellisonleao/gruvbox.nvim'
    " End THEMES

    " Native LSP
    Plug 'williamboman/mason.nvim'
    Plug 'williamboman/mason-lspconfig.nvim'
    Plug 'neovim/nvim-lspconfig'
    
    " COQ - code completion
    Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
    " 9000+ Snippets
    Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
    " lua & third party sources -- See https://github.com/ms-jpq/coq.thirdparty
    " Need to **configure separately**
    Plug 'ms-jpq/coq.thirdparty', {'branch': '3p'}
    
    " Airline status
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    
    " Which key plugin
    Plug 'folke/which-key.nvim'

    " Vim commentary plugin
    Plug 'tpope/vim-commentary'

    " Quick scope plugin
    Plug 'unblevable/quick-scope'

    " neovim colorizer
    Plug 'norcalli/nvim-colorizer.lua'

    " fzf plugin
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'airblade/vim-rooter'

    " Sneak
    Plug 'justinmk/vim-sneak'

    " Startify for funs
    Plug 'mhinz/vim-startify'

    " Track the engine.
    Plug 'SirVer/ultisnips'

    " Snippets are separated from the engine. Add this if you want them:
    Plug 'honza/vim-snippets'

    " Tagbar for viewing class class outline
    " Plug 'preservim/tagbar'

    " kill buffer not window
    Plug 'qpkorr/vim-bufkill'

    " floaterm
    Plug 'voldikss/vim-floaterm'

    " zen mode
    Plug 'junegunn/goyo.vim'

    " Git integration
    Plug 'mhinz/vim-signify'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-rhubarb'
    Plug 'junegunn/gv.vim'

    " Vim surround
    Plug 'tpope/vim-surround'

    " Vim repeat for repeating plugin commands
    Plug 'tpope/vim-repeat'

    " Plugin to add more text objects
    Plug 'wellle/targets.vim'

    " GH Co-pilot baby
    Plug 'github/copilot.vim'
    " Plug 'zbirenbaum/copilot.lua' 

    """""""""""""""" Ruby/rails related plugins """"""""""""""""""

    " ale for ruby & standardrb
    Plug 'dense-analysis/ale'


    """""""""""""""" PHP-related plugins """"""""""""""""

    " phpcsfixer
    " Plug 'stephpy/vim-php-cs-fixer'

    " PHP refactoring plugin
    " Plug 'adoy/vim-php-refactoring-toolbox'

    " Phpactor
    " Plug 'phpactor/phpactor', {'for': 'php', 'tag': '*', 'do': 'composer install --no-dev -o'}

    " For Lua/Neovim development
    Plug 'nvim-lua/plenary.nvim'

call plug#end()
