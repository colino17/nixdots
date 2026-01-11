{ config, pkgs, ... }:

let inherit (import ../variables.nix) var_username; in

{
  environment.systemPackages = with pkgs; [
    zed-editor
    nixd
  ];

## ZED SETTINGS ##
  home-manager.users.${var_username} = { config, ... }: {
    programs.zed-editor.enable = true;
    programs.zed-editor.extensions = [ "nix" "tokyo-night-themes" ];
    programs.zed-editor.userSettings = {
        agent = {
          version = "2";
          default_model = {
            provider = "ollama";
            model = "qwen2.5:7b";
          };
        };
        ui_font_size = 14;
        buffer_font_size = 14;
        theme = {
          mode = "system";
          dark = "Tokyo Night";
          light = "Tokyo Night";
        };
        language_models = {
          ollama = {
            api_url = "http://10.17.10.17:11434";
          };
        };
        languages = { 
          Nix = { 
            language_servers = [ "nixd" "!nil" ];
          }; 
        }; 
        title_bar = {
          show_branch_icon = false;
          show_menus = true;
          show_branch_name = false;
          show_project_items = true;
          show_onboarding_banner = false;
          show_user_picture = false;
          show_sign_in = false;
        };
        git_panel = {
          button = false;
        };
        outline_panel = {
          button = false;
        };
        collaboration_panel = {
          button = false;
        };
        features = {
          edit_prediction_provider = "none";
        };
        telemetry = {
          diagnostics = true;
          metrics = true;
        };
      };
  };

}
