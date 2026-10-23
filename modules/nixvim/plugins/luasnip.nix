{ ... }:
{
  flake.nixosModules.nixvimPluginLuasnip =
    {
      ...
    }:
    {
      plugins.luasnip = {
        enable = true;
        fromLua = [ { paths = ../snippets; } ];
        settings = {
          link_children = true;
          link_roots = true;
          keep_roots = true;
          update_events = [
            "TextChanged"
            "TextChangedI"
          ];
          enable_autosnippets = true;
        };
        lazyLoad = {
          enable = true;
          settings = {
            event = "InsertEnter";
          };
        };
      };
    };
}
