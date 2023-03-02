require("mason").setup()
require("mason-lspconfig").setup()

local on_attach = function(_, bufnr)
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
      a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code action", opts },
    }, { prefix = "<leader>c" })

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
      ["[d"] = { '<cmd>lua vim.diagnostic.goto_prev()<CR>', "Previous diagnostic", opts },
      ["]d"] = { '<cmd>lua vim.diagnostic.goto_next()<CR>', "Next diagnostic", opts },
    })
end

require("mason-lspconfig").setup_handlers {
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function (server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup { on_attach=on_attach}
    end,
    -- Next, you can provide a dedicated handler for specific servers.
    ["lua_ls"] = function ()
        require("lspconfig")["lua_ls"].setup {
          settings = {
            Lua = {
              diagnostics = {
                globals = {'vim'}
              }
            }
          }
        }
    end,

    ["solargraph"] = function()
      require("lspconfig")["solargraph"].setup {
        settings = {
          solargraph = {
            commandPath = '/home/skrobul/.asdf/shims/solargraph',
            diagnostics = true,
            completion = true,
            formatting = true,
            useBundler = true
          }
        }, on_attach = on_attach
      }
    end,

    ["jsonls"] = function()
      require("lspconfig")["jsonls"].setup {
        settings = {
          json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
          },
        },
      }
    end,

    ["emmet_ls"] = function()
      require("lspconfig")["emmet_ls"].setup {
        capabilities = vim.lsp.protocol.make_client_capabilities()
      }
    end
}
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- local function attacher(client)
--   print('Attaching LSP: ' .. client.name)
-- end


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
      root_dir = function(_)
        return vim.loop.cwd()
      end;
      settings = {};
    };
  }
end

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
