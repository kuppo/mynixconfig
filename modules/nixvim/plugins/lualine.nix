{ ... }:
{
  flake.nixosModules.nixvimPluginLualine =
    {
      ...
    }:
    {
      plugins.lualine = {
        enable = true;
        settings = {
          disabled_filetypes = {
            statusline = [ "neo-tree" ];
          };
          options = {
            # theme = "onedark_dark";
            icons_enabled = true;
            component_separators = "|";
            section_separators = "";
          };
          sections = {
            lualine_c = [
              {
                __unkeyed-1 = "filename";
                path = 1;
                status = true;
              }
            ];
            lualine_x = [
              "lsp_status"
              "encoding"
              "fileformat"
              "filetype"
            ];
          };
          inactive_sections = {
            lualine_b = [
              {
                __unkeyed-1 = "filename";
                path = 3;
                status = true;
              }
            ];
            lualine_x = [ "filetype" ];
          };
          # tabline = {
          #   lualine_a = [
          #     {
          #       __unkeyed-1 = "buffers";
          #       symbols = {
          #         alternate_file = "";
          #       };
          #     }
          #   ];
          #   lualine_z = [ "tabs" ];
          # };
        };
        lazyLoad = {
          enable = true;
          settings = {
            event = "DeferredUIEnter";
          };
        };
      };
    };
}
