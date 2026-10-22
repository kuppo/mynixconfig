return {
  "lazydev.nvim",
  auto_enable = true,
  cmd = { "LazyDev" },
  ft = "lua",
  after = function(_)
    require("lazydev").setup({
      library = {
        { words = { "nixInfo%.lze" }, path = nixInfo.get_nix_plugin_path("lze") .. "/lua" },
        {
          words = { "nixInfo%.lze" },
          path = nixInfo.get_nix_plugin_path("lzextras") .. "/lua",
        },
        {
          words = { "vim%." },
          path = nixInfo(nil, "vim_pack_dir") .. "/myNeovimPackages/*",
        },
      },
    })
  end,
}
