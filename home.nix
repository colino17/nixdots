  home-manager.users.my_username = {
    /* Here goes your home-manager config, eg home.packages = [ pkgs.foo ]; */
  };
  
  
  
  
######################
### GNOME SETTINGS ###
######################
  services.xserver.desktopManager.gnome = {
    extraGSettingsOverrides = ''
      [org.gnome.desktop.background]
      picture-uri='file://${pkgs.nixos-artwork.wallpapers.mosaic-blue.gnomeFilePath}'
     
      [org.gnome.settings-daemon.plugins.media-keys]
      custom-keybindings=['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/' '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/' '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/' '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/' '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4/' '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom5/']

      [org.gnome.settings-daemon.plugins.media-keys.custom-keybindings.custom0]
      binding='<Super>t'
      command='gnome-terminal'
      name='open-terminal' 
      
      [org.gnome.settings-daemon.plugins.media-keys.custom-keybindings.custom1]
      binding='<Super>e'
      command='nautilus'
      name='open-files'
      
      [org.gnome.settings-daemon.plugins.media-keys.custom-keybindings.custom2]
      binding='<Super>w'
      command='epiphany'
      name='open-web'
      
      [org.gnome.settings-daemon.plugins.media-keys.custom-keybindings.custom3]
      binding='<Super>d'
      command='discord'
      name='open-discord'
      
      [org.gnome.settings-daemon.plugins.media-keys.custom-keybindings.custom4]
      binding='<Super>g'
      command='gimp'
      name='open-gimp'
      
      [org.gnome.settings-daemon.plugins.media-keys.custom-keybindings.custom5]
      binding='<Super>m'
      command='gnome-terminal --maximize -- bash -c cmatrix -bas'
      name='enter-matrix'
      
      [org.gnome.shell]
      favorite-apps=['org.gnome.Epiphany.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.Terminal.desktop', 'gimp.desktop', 'discord.desktop', 'steam.desktop']
    '';

    extraGSettingsOverridePackages = [
      pkgs.gsettings-desktop-schemas
      pkgs.gnome.gnome-shell
      pkgs.gnome.gnome-settings-daemon
      ];
    };
  
  
