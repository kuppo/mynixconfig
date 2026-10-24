{ self, inputs, ... }:
{
  flake.nixosModules.nixvim =
    {
      config,
      lib,
      ...
    }:
    {
      imports = [
        inputs.nixvim.nixosModules.nixvim
      ];
      config = lib.mkIf config.myoptions.nixvim.enable {
        programs.nixvim = {
          extraFiles = {
            "after" = {
              source = ./after;
            };
          };
          enable = true;
          defaultEditor = true;
          viAlias = true;
          vimAlias = true;
          withRuby = false;
          colorschemes.tokyonight.enable = true;

          imports = [
            self.nixosModules.nixvimAutocmds
            self.nixosModules.nixvimKeybindings
            self.nixosModules.nixvimLsp
            self.nixosModules.nixvimOptions
          ]
          ++
            ## plugins
            (
              if config.myoptions.nixvim.full then
                [
                  self.nixosModules.nixvimPluginBetterEscape
                  self.nixosModules.nixvimPluginLazydev
                  self.nixosModules.nixvimPluginFloaterm
                  self.nixosModules.nixvimPluginDap
                  self.nixosModules.nixvimPluginBlink
                  self.nixosModules.nixvimPluginBlinkIndent
                  self.nixosModules.nixvimPluginBlinkPairs
                  self.nixosModules.nixvimPluginFzflua
                  self.nixosModules.nixvimPluginGitsigns
                  self.nixosModules.nixvimPluginLazygit
                  self.nixosModules.nixvimPluginLuasnip
                  self.nixosModules.nixvimPluginLzn
                  self.nixosModules.nixvimPluginNeotree
                  self.nixosModules.nixvimPluginWhichkey
                  self.nixosModules.nixvimPluginLualine
                  self.nixosModules.nixvimPluginOrgmode
                  self.nixosModules.nixvimPluginSurround
                  self.nixosModules.nixvimPluginSuda
                  self.nixosModules.nixvimPluginConform
                  self.nixosModules.nixvimPluginRustacean
                ]
              else
                [ ]
            );
        };
      };
    };
}
