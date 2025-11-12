{ config, pkgs, ... }:

let inherit (import ../variables.nix) var_username var_stateversion; in

{
  environment.systemPackages = with pkgs; [
    zed-editor
  ];

## ZED SETTINGS ##
  home-manager.users.${var_username} = { config, ... }: {
    programs.zed-editor.extensions = [ "kotlin" "nix" "github-dark-default" ];
    programs.zed-editor.userSettings = {
        agent = {
          version = 2;
          default_model = {
            provider = ollama;
          };
        };
        ui_font_size = 16;
        buffer_font_size = 16;
        theme = {
          mode = dark;
          dark = GitHub Dark Default;
        };
        language_models = {
          ollama = {
            api_url = http://10.17.10.17:11434;
          };
        };
        title_bar = {
          show_branch_icon = false;
          show_branch_name = true;
          show_project_items = true;
          show_onboarding_banner = true;
          show_user_picture = false;
          show_sign_in = false;
          show_menus = true;
        };
      };
  };

}
