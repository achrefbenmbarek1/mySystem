{ config, pkgs, inputs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "achref";
  home.homeDirectory = "/home/achref";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
     (pkgs.nerdfonts.override { fonts = [ "Hack" "Iosevka" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    zathura
    kitty
    hyprland
    gparted
    atuin
    mpd
    mpv
    ncmpcpp
    atuin
    waybar
    pass
    dunst
    libnotify
    hyprpaper
    rofi-wayland
    fzf
    eza
    zoxide
    tmux
    luajitPackages.luarocks
    zip
    unzip
    wl-clipboard
    vimiv-qt
    jq
    yq
    bat
    lf
    pistol
    less
    pamixer
    direnv
    gnome-keyring
    xdg-utils
    ripgrep
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
     #".config/hypr/hyprland.conf".source = ./hyprland.conf;
    # ".config/hypr/hyprland.conf".recursive = true;
     ".config".source = ./.config;
     ".config".recursive = true;
     "Pictures".source = ./Pictures;
     "Pictures".recursive = true;
     ".tmux.conf".source = ./.tmux.conf;
     ".tmux.conf".recursive = true;
     ".zshrc".source = ./.zshrc;
     ".zshenv".source = ./.zshenv;
     ".aliases".source = ./.aliases;
     ".ncmpcpp".source = ./.ncmpcpp;
     ".ncmpcpp".recursive = true;
     # ".local/bashScripts".source = ./bashScripts;
     # ".local/bashScripts".recursive = true;
     "customFlake".source = ./customFlake;
     "customFlake".recursive = true;
  };
  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/achref/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
     EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  
  #programs.zsh = {
  #enable = true;
  #autosuggestion.enable = true;
  #enableCompletion = true;
  #};


  #wayland.windowManager.hyprland = {
  #enable = true;
  #};

#xdg.configFile.hyprland = {
 #     source = ./hyprland.conf;
 #     recursive = true;
#};
  xdg.mimeApps.defaultApplications = {
  "application/pdf" = ["zathura.desktop"];
  "video/*" = ["mpv.desktop"];
  };

  fonts.fontconfig.enable = true;
  # programs.zsh.enableCompletion = false;
  programs.firefox = {
    enable = true;
    profiles.achref = {
      search.engines = {
        "Nix Packages" = {
          urls = [{
            template = "https://search.nixos.org/packages";
            params = [
              { name = "type"; value = "packages"; }
              { name = "query"; value = "{searchTerms}"; }
            ];
          }];

          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@np" ];
        };
      };
      search.force = true;

      bookmarks = [
        {
          name = "wikipedia";
          tags = [ "wiki" ];
          keyword = "wiki";
          url = "https://en.wikipedia.org/wiki/Special:Search?search=%s&go=Go";
        }
      ];

      settings = {
        # "dom.security.https_only_mode" = true;
        "browser.download.panel.shown" = true;
        "identity.fxaccounts.enabled" = false;
        # "signon.rememberSignons" = false;
      };

      userChrome = ''                         
        /* some css */                        
      '';                                      

      extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
        ublock-origin
        sponsorblock
        vimium
      ];

    };
  };
  #for desktop apps interactions between each other(things such as screen sharing)
  #xdg.portal.enable = true;
  #xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
 # nix = {
   # package = pkgs.nix;
   # settings.experimental-features = ["nix-command" "flakes"];
  #};
}
