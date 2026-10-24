{ ... }:
{
  flake.nixosModules.nixvimPluginOrgmode =
    {
      lib,
      ...
    }:
    {
      plugins.orgmode = {
        enable = true;
        settings = {
          org_agenda_files = "~/org/*";
          org_default_notes_file = "~/org/working_on.org";
          org_todo_keywords = [
            "TODO(t)"
            "ONGOING(o)"
            "PENGDING(p)"
            "|"
            "DROPPED(d)"
            "DONE(d)"
          ];
          org_startup_folded = "content";
          org_hide_leading_stars = true;
          mappings = {
            # disable_all = true;
            org = {
              org_change_date = {
                __unkeyed-1 = "cod";
                desc = "org change date";
              };
              org_priority_up = {
                __unkeyed-1 = "coR";
                desc = "org priority up";
              };
              org_priority_down = {
                __unkeyed-1 = "cor";
                desc = "org priority down";
              };
              org_todo = {
                __unkeyed-1 = "cot";
                desc = "org todo";
              };
              org_todo_prev = {
                __unkeyed-1 = "coT";
                desc = "org todo previous";
              };
            };
          };
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
