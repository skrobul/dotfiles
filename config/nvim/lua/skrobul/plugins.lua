local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugged')

Plug 'rakr/vim-two-firewatch'
Plug 'tpope/vim-fugitive'                           -- git wrapper
Plug 'honza/vim-snippets'                           -- actual snippets
Plug 'tpope/vim-commentary'                         -- easy comments
Plug 'andymass/vim-matchup'                         -- better jumping with %
Plug 'tpope/vim-endwise'                            -- wisely 'end' functions etc
Plug 'kchmck/vim-coffee-script'                     -- coffe script support
Plug 'tpope/vim-repeat'                             -- extend support for repeating with .
Plug 'tpope/vim-surround'                           -- quickly surround
Plug('scrooloose/nerdtree' , {on='NERDTreeToggle'}) -- file manager
Plug 'tpope/vim-dispatch'                           -- start stuff in background
Plug 'nelstrom/vim-textobj-rubyblock'               -- text object for selecting ruby blocks
Plug 'kana/vim-textobj-user'                        -- dependency for vim-textobj-rubyblock
Plug 'christoomey/vim-tmux-navigator'               -- seamless navigation between tmux panes and splits
Plug 'tpope/vim-unimpaired'                         -- set of movement mappings
Plug 'tpope/vim-eunuch'                             -- Chmod, rename, delete etc
Plug 'henrik/vim-qargs'                             -- adds :Qargs command
Plug 'dhruvasagar/vim-table-mode'                   -- helps with creating tables
Plug 'benmills/vimux'                               -- interact with tmux
Plug 'gregsexton/gitv'                              -- gitk for vim
Plug 'lukas-reineke/indent-blankline.nvim'          -- visual indent
Plug 'idanarye/vim-merginal'                        -- help with merges and rebase
Plug 'junegunn/vim-easy-align'                      -- easy alignment
Plug 'mattn/gist-vim'                               -- create GIST from vim
Plug 'mattn/webapi-vim'                             -- create GIST from vim
Plug 'rking/ag.vim'                                 -- vim-ag
Plug('lewis6991/gitsigns.nvim', {branch='main'})
Plug 'hwartig/vim-seeing-is-believing'                  -- inline ruby
Plug 'kassio/neoterm'                                   -- reuse terminal, repl integration
Plug 'janko-m/vim-test'                                 -- vim-test
Plug 'shime/vim-livedown'                               -- live markdown preview
Plug 'ellisonleao/glow.nvim'                            -- markdown preview inside vim
Plug 'lambdalisue/suda.vim'                             -- sudo write(neovim needs it)
Plug 'nvim-lua/popup.nvim'                              -- telescope
Plug 'nvim-lua/plenary.nvim'                            -- telescope
Plug 'nvim-telescope/telescope.nvim'                    -- telescope
Plug 'kyazdani42/nvim-web-devicons'                     -- telescope dep

-- LSP
Plug 'neovim/nvim-lspconfig'                            -- built-in LSP
Plug('hrsh7th/cmp-nvim-lsp', {branch='main'})           -- completion plugin
Plug('hrsh7th/cmp-buffer', {branch='main'})             -- completion plugin
Plug('hrsh7th/cmp-path', {branch='main'})               -- completion plugin
Plug('hrsh7th/cmp-cmdline', {branch='main'})            -- completion plugin
Plug('hrsh7th/nvim-cmp', {branch='main'})               -- completion plugin
Plug 'L3MON4D3/LuaSnip'                                 -- luasnip
Plug 'saadparwaiz1/cmp_luasnip'                         -- luasnip
Plug('rafamadriz/friendly-snippets', {branch='main'})   -- collection of snippets
Plug('andersevenrud/cmp-tmux', {branch='main'})         -- complete from TMUX
Plug('williamboman/nvim-lsp-installer',{branch='main'}) -- install language servers easily
Plug 'ray-x/lsp_signature.nvim'                         -- display function sig
-- misc
Plug 'nvim-lualine/lualine.nvim' -- better status line
Plug('mattn/emmet-vim', { ['for'] = {'html', 'erb', 'vue'} }) -- easy html
Plug 'romainl/vim-cool'                                 -- disables search highlighting when you are done
Plug 'ap/vim-css-color'                                 -- display CSS colors inline
Plug 'osyo-manga/vim-over'                              -- preview search & replace
-- Plug('vimwiki/vimwiki', {on={'VimwikiMakeDiaryNote', 'VimwikiDiaryIndex', 'VimwikiIndex'}})
Plug 'lervag/wiki.vim'
Plug 'AndrewRadev/splitjoin.vim'                        -- split one liners
Plug 'dkarter/bullets.vim'                              -- list formatting
Plug 'xarthurx/taskwarrior.vim'
Plug 'folke/which-key.nvim'                             -- shows keyboard shortcut popup
Plug 'ggandor/leap.nvim'                                -- sneak'alike jumping
Plug 'ahmedkhalf/project.nvim'                          -- project mgmt

-- additional syntax / lang support plugins
Plug('cespare/vim-toml', {branch='main'})
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'saltstack/salt-vim'
Plug 'leafgarland/typescript-vim'            -- Typescript syntax
Plug('Shougo/vimproc.vim', {['do'] ='make'}) -- Dependency for tsuquyomi
Plug 'andrewstuart/vim-kubernetes'           -- kubernetes manifests
Plug 'slim-template/vim-slim'                -- slim templating support
Plug 'ClockworkNet/vim-apparmor'             -- AppArmor definitions
Plug 'jceb/vim-orgmode'                      -- emacs' org-mode
Plug 'godlygeek/tabular'                     -- dependency for plasticboy/vim-markdown
Plug 'plasticboy/vim-markdown'               -- markdown - extra actions, folding
Plug 'junegunn/goyo.vim'                     -- distraction free writing
Plug 'sheerun/vim-polyglot'                  -- lot of extra languages
Plug 'famiu/bufdelete.nvim'                  -- handles buffer deletion much better
Plug 'towolf/vim-helm'                       -- helm templates
Plug 'ckipp01/nvim-jenkinsfile-linter'       -- Jenkinsfiles
-- colorscheme packages
Plug 'pwntester/octo.nvim'
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'elianiva/gitgud.nvim'
Plug('EdenEast/nightfox.nvim', {branch='main'})
Plug 'sainnhe/sonokai'
Plug 'folke/tokyonight.nvim'

vim.call('plug#end')

require 'skrobul.plugins.lspconfig'
require 'skrobul.plugins.luasnip'
require 'skrobul.plugins.cmp'
require 'skrobul.plugins.telescope'
require 'skrobul.plugins.treesitter'
require 'skrobul.plugins.lualine'
require 'skrobul.plugins.gitsigns'
require 'skrobul.plugins.blankline'
require 'skrobul.plugins.which-key'
require 'skrobul.plugins.leap'
require 'skrobul.plugins.project'
require 'skrobul.plugins.wiki'
require 'skrobul.plugins.vim-markdown'
require 'skrobul.plugins.jenkinsfile-linter'
