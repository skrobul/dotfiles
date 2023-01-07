vim.api.nvim_create_autocmd("FileType",  {
  pattern = { "Jenkinsfile"},
  command = [[nnoremap <buffer> <silent> <Leader>v :lua require("jenkinsfile_linter").validate()<cr>]]
})
