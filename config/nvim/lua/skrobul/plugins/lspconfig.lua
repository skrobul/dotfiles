local lspconfig = require("lspconfig")
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    require "lsp_signature".on_attach()

    -- Mappings.
    local opts = { noremap=true, silent=true, mode="n" }
    local wk = require("which-key")

    wk.register({
     w = {
        a =  { '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', "LSP Add workspace folder", opts },
        r = { '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', "LSP Remove workspace folder", opts },
        l = { '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', "LSP print workspace folders", opts },
      },
      D = { '<cmd>lua vim.lsp.buf.type_definition()<CR>', "Display type definition", opts },
      q = { '<cmd>lua vim.diagnostic.setloclist()<CR>', "Jump to definition of the type under the cursor", opts },
      f = { '<cmd>lua vim.lsp.buf.formatting()<CR>', "Formats the current buffer", opts },
      e = { '<cmd>lua vim.diagnostic.open_float()<CR>', "Show diagnostics in a floating window", opts },
    }, { prefix = "<space>" })

    wk.register({
      g = {
        D = { '<cmd>lua vim.lsp.buf.declaration()<CR>', "LSP Declaration", opts },
        d = { '<cmd>lua vim.lsp.buf.definition()<CR>', "LSP Definition", opts },
        i = { '<cmd>lua vim.lsp.buf.implementation()<CR>', "LSP Implementation", opts },
        r = { '<cmd>lua vim.lsp.buf.references()<CR>', "References to a symbol", opts },
      },
      K = { '<cmd>lua vim.lsp.buf.hover()<CR>', "Hover information. Call twice to jump", opts },
      ["<C-k>"] = { '<cmd>lua vim.lsp.buf.signature_help()<CR>', "Display signature information", opts },
      ["<leader>rn"] = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename symbol", opts },
      ["<leader>ca"] = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code action", opts },
      ["[d"] = { '<cmd>lua vim.diagnostic.goto_prev()<CR>', "Previous diagnostic", opts },
      ["]d"] = { '<cmd>lua vim.diagnostic.goto_next()<CR>', "Next diagnostic", opts },
    })
end

local lsp_installer = require("nvim-lsp-installer")

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Register a handler that will be called for each installed server when it's ready (i.e. when installation is finished
-- or if the server is already installed).
lsp_installer.on_server_ready(function(server)
    local opts = { on_attach = on_attach, capabilities = capabilities }

    if server.name == "sumneko_lua" then
      opts.settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' }
          }
        }
      }
    end

    -- This setup() function will take the provided server configuration and decorate it with the necessary properties
    -- before passing it onwards to lspconfig.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
        server:setup(opts)
    end)


-- local function attacher(client)
--   print('Attaching LSP: ' .. client.name)
-- end


lspconfig.solargraph.setup{
  settings = {
    solargraph = {
      commandPath = '/home/skrobul/.asdf/shims/solargraph',
      diagnostics = true,
      completion = true,
      formatting = true,
      useBundler = true
    }
  },

  on_attach = on_attach
}

local configs = require('lspconfig.configs')

capabilities.textDocument.completion.completionItem.snippetSupport = true

if not configs.ls_emmet then
  configs.ls_emmet = {
    default_config = {
      cmd = { 'ls_emmet', '--stdio' };
      filetypes = {
        'html',
        'css',
        'scss',
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
        'haml',
        'xml',
        'xsl',
        'pug',
        'slim',
        'sass',
        'stylus',
        'less',
        'sss',
        'hbs',
        'handlebars',
        'eruby',
        'erb'
      };
      root_dir = function(fname)
        return vim.loop.cwd()
      end;
      settings = {};
    };
  }
end

local caps = vim.lsp.protocol.make_client_capabilities()
lspconfig.ls_emmet.setup { capabilities = caps }

-- lspconfig for jsonls
lspconfig.jsonls.setup {
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
  },
}



vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})]]
vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = true,
})
-- borders

vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]]
vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]

local border = {
      {"🭽", "FloatBorder"},
      {"▔", "FloatBorder"},
      {"🭾", "FloatBorder"},
      {"▕", "FloatBorder"},
      {"🭿", "FloatBorder"},
      {"▁", "FloatBorder"},
      {"🭼", "FloatBorder"},
      {"▏", "FloatBorder"},
}

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- symbols in gutter
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- icons
local M = {}

M.icons = {
  Class = " ",
  Color = " ",
  Constant = " ",
  Constructor = " ",
  Enum = "了 ",
  EnumMember = " ",
  Field = " ",
  File = " ",
  Folder = " ",
  Function = " ",
  Interface = "ﰮ ",
  Keyword = " ",
  Method = "ƒ ",
  Module = " ",
  Property = " ",
  Snippet = "﬌ ",
  Struct = " ",
  Text = " ",
  Unit = " ",
  Value = " ",
  Variable = " ",
}
function M.setup()
  local kinds = vim.lsp.protocol.CompletionItemKind
  for i, kind in ipairs(kinds) do
    kinds[i] = M.icons[kind] or kind
  end
end

return M

