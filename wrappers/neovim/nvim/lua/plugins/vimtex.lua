return {
  "vimtex",
  auto_enable = true,
  before = function()
    vim.g.vimtex_view_method = "zathura"
    vim.g.vimtex_compiler_latexmk = {
      executable = "latexmk",
      options = {
        "-pdf",
        "-auxdir='_build'",
        "-emulate-aux-dir",
        "-out2dir='.'",
        "-shell-escape",
        "-file-line-error",
        "-synctex=1",
        "-interaction=nonstopmode",
      },
    }
  end,
}
