local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugged')

Plug 'rakr/vim-two-firewatch'
Plug 'tpope/vim-fugitive'                               -- git wrapper
Plug 'honza/vim-snippets'                               -- actual snippets
Plug 'tpope/vim-commentary'                              -- easy comments
Plug 'jwhitley/vim-matchit'                             -- better jumping with %
Plug 'tpope/vim-endwise'                                -- wisely 'end' functions etc
Plug 'kchmck/vim-coffee-script'                         -- coffe script support
Plug 'tpope/vim-repeat'                                 -- extend support for repeating with .
Plug 'tpope/vim-surround'                               -- quickly surround
Plug('scrooloose/nerdtree' , {on='NERDTreeToggle'})  -- file manager
Plug 'tpope/vim-dispatch'                               -- start stuff in background
Plug 'nelstrom/vim-textobj-rubyblock'                   -- text object for selecting ruby blocks
Plug 'kana/vim-textobj-user'                            -- dependency for vim-textobj-rubyblock
Plug 'christoomey/vim-tmux-navigator'                   -- seamless navigation between tmux panes and splits
Plug 'tpope/vim-unimpaired'                             -- set of movement mappings
Plug 'tpope/vim-eunuch'                                 -- Chmod, rename, delete etc
Plug 'henrik/vim-qargs'                                 -- adds :Qargs command
Plug 'dhruvasagar/vim-table-mode'                       -- helps with creating tables
Plug 'benmills/vimux'                                   -- interact with tmux
Plug 'gregsexton/gitv'                                  -- gitk for vim
Plug 'nathanaelkane/vim-indent-guides'                  -- visual indent
Plug 'idanarye/vim-merginal'                            -- help with merges and rebase
Plug 'junegunn/vim-easy-align'                          -- easy alignment
Plug 'mattn/gist-vim'                                   -- create GIST from vim
Plug 'mattn/webapi-vim'                                 -- create GIST from vim
Plug 'rking/ag.vim'                                     -- vim-ag
Plug 'airblade/vim-gitgutter'
Plug 'hwartig/vim-seeing-is-believing'                  -- inline ruby
Plug 'kassio/neoterm'                                   -- reuse terminal, repl integration
Plug 'janko-m/vim-test'                                 -- vim-test
Plug 'shime/vim-livedown'                               -- live markdown preview
Plug 'lambdalisue/suda.vim'                             -- sudo write(neovim needs it)
Plug 'nvim-lua/popup.nvim'                              -- telescope
Plug 'nvim-lua/plenary.nvim'                            -- telescope
Plug 'nvim-telescope/telescope.nvim'                    -- telescope
Plug 'kyazdani42/nvim-web-devicons'                     -- telescope dep

Plug 'neovim/nvim-lspconfig'        -- built-in LSP
Plug 'hrsh7th/cmp-nvim-lsp'         -- completion plugin
Plug 'hrsh7th/cmp-buffer'           -- completion plugin
Plug 'hrsh7th/cmp-path'             -- completion plugin
Plug 'hrsh7th/cmp-cmdline'          -- completion plugin
Plug 'hrsh7th/nvim-cmp'             -- completion plugin
Plug 'hrsh7th/cmp-vsnip'            -- For vsnip users.
Plug 'hrsh7th/vim-vsnip'            -- For vsnip users.
Plug 'hrsh7th/vim-vsnip-integ'      -- vsnip
Plug 'rafamadriz/friendly-snippets' -- collection of snippets
Plug 'andersevenrud/cmp-tmux'       -- complete from TMUX
Plug 'williamboman/nvim-lsp-installer' -- install language servers easily
-- Plug 'petertriho/cmp-git'           " GH issue list
-- Plug '~/devel/cmp-git/'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug('mattn/emmet-vim', { ['for'] = {'html', 'erb', 'vue'} })
Plug 'romainl/vim-cool'                                 -- disables search highlighting when you are done
Plug 'ap/vim-css-color'                                 -- display CSS colors inline
Plug 'KabbAmine/vCoolor.vim'                            -- color picker
Plug 'osyo-manga/vim-over'                              -- preview search & replace
Plug('vimwiki/vimwiki', {on={'VimwikiMakeDiaryNote', 'VimwikiDiaryIndex', 'VimwikiIndex'}})
Plug 'AndrewRadev/splitjoin.vim'                            -- split one liners
Plug 'dkarter/bullets.vim'                              -- list formatting
Plug 'xarthurx/taskwarrior.vim'
-- additional syntax / lang support plugins
Plug 'cespare/vim-toml'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'saltstack/salt-vim'
Plug 'leafgarland/typescript-vim'          -- Typescript syntax
Plug('Shougo/vimproc.vim', {['do'] ='make'}) -- Dependency for tsuquyomi
-- Plug 'Quramy/tsuquyomi'                    " typescript completion
Plug 'andrewstuart/vim-kubernetes'         -- kubernetes manifests
Plug 'slim-template/vim-slim'              -- slim templating support
Plug 'ClockworkNet/vim-apparmor'           -- AppArmor definitions
Plug 'jceb/vim-orgmode'                    -- emacs' org-mode
Plug 'godlygeek/tabular'                   -- dependency for plasticboy/vim-markdown
Plug 'plasticboy/vim-markdown'             -- markdown - extra actions, folding
Plug 'junegunn/goyo.vim'                   -- distraction free writing
Plug 'sheerun/vim-polyglot'                -- lot of extra languages
-- colorscheme packages
Plug 'pwntester/octo.nvim'
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate', branch='0.5-compat' })
Plug 'elianiva/gitgud.nvim'

vim.call('plug#end')
