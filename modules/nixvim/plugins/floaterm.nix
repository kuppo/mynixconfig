{ ... }:
{
  flake.nixosModules.nixvimPluginFloaterm =
    { ... }:
    {
      plugins.floaterm = {
        enable = true;
        settings = {
          height = 0.99;
          width = 0.8;
          title = "Terminal: $1/$2";
        };
        lazyLoad = {
          enable = true;
          settings = {
            keys = [
              {
                __unkeyed-1 = "<C-t>";
                __unkeyed-2 = "<cmd>FloatermToggle<cr>";
                desc = "Toggle float terminal";
                mode = [
                  "t"
                  "n"
                ];
              }
            ];
            cmd = [
              "Floaterm"
              "FloatermPrev"
              "FloatermNext"
              "FloatermFirst"
              "FloatermLast"
              "FloatermUpdate"
              "FloatermToggle"
              "FloatermShow"
              "FloatermHide"
              "FloatermKill"
              "FloatermSend"
            ];
          };
        };
      };
    };
}
