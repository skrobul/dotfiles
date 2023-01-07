vim.cmd [[hi IndentBlanklineChar guifg=#212230 gui=nocombine]]

require("indent_blankline").setup {
    show_current_context = true,
    show_current_context_start = true,
    enabled = false,
}
