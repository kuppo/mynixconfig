return {
  "rustaceanvim",
  auto_enable = true,
  after = function()
    -- Update this path
    local extension_path = nixInfo(nil, "info", "vscode-lldb-path")
      .. "/share/vscode/extensions/vadimcn.vscode-lldb/"
    local codelldb_path = extension_path .. "adapter/codelldb"
    local liblldb_path = extension_path .. "lldb/lib/liblldb"
    local this_os = vim.uv.os_uname().sysname

    -- The path is different on Windows
    if this_os:find("Windows") then
      codelldb_path = extension_path .. "adapter\\codelldb.exe"
      liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
    else
      -- The liblldb extension is .so for Linux and .dylib for MacOS
      liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
    end
    local cfg = require("rustaceanvim.config")

    vim.g.rustaceanvim = {
      tools = {},
      dap = {
        adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
      },
      server = {
        on_attach = function(client, bufnr) end,
        default_settings = {
          ["rust-analyzer"] = {
            lens = {
              debug = { enable = true },
              enable = true,
              implementations = { enable = true },
              references = {
                adt = { enable = true },
                enumVariant = { enable = true },
                method = { enable = true },
                trait = { enable = true },
              },
              run = { enable = true },
              updateTest = { enable = true },
            },
          },
        },
      },
    }
  end,
}
