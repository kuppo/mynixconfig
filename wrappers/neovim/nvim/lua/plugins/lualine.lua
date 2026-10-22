return {
  "lualine.nvim",
  auto_enable = true,
  event = "DeferredUIEnter",
  after = function()
    require("lualine").setup({
      disabled_filetypes = {
        statusline = { "neo-tree" },
      },
      options = {
        -- theme = "onedark_dark",
        icons_enabled = true,
        component_separators = "|",
        section_separators = "",
      },
      sections = {
        lualine_c = {
          { "filename", path = 1, status = true },
        },
        lualine_x = { "lsp_status", "encoding", "fileformat", "filetype" },
      },
      inactive_sections = {
        lualine_b = {
          { "filename", path = 3, status = true },
        },
        lualine_x = { "filetype" },
      },
      -- tabline = {
      --   lualine_a = { { "buffers", symbols = { alternate_file = "" } } },
      --   lualine_z = { "tabs" },
      -- },
    })
  end,
}
