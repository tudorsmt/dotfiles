{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "tudor";
  home.homeDirectory = "/home/tudor";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello
    pkgs.btop
    pkgs.cmatrix
    pkgs.delta
    pkgs.eza
    pkgs.fd
    pkgs.gh
    pkgs.git-extras
    pkgs.headsetcontrol
    pkgs.iperf
    pkgs.k9s
    pkgs.kubectl
    pkgs.lazygit
    pkgs.neofetch
    pkgs.rustup
    pkgs.superfile
    pkgs.sysstat
    pkgs.tig
    pkgs.uv
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
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
  #  /etc/profiles/per-user/tudor/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # See .desktop and icon in ROOT/misc
  # Needs to have nixGL installed to work
  programs.alacritty.enable = true;
  home.file.".local/share/applications/Alacritty.desktop" = {
    source = "/home/tudor/setup/dotfiles/misc/desktop/Alacritty.desktop";
  };
  home.file.".local/share/icons/hicolor/scalable/apps/Alacritty.svg" = {
    source = "/home/tudor/setup/dotfiles/misc/icons/Alacritty.svg";
  };
  home.file.".config/alacritty.toml" = {
    source = "/home/tudor/setup/dotfiles/alacritty.toml";
  };

### Ghostty
###### Disabled for now
  # programs.ghostty = {
  #   enable = true;
  # };
  # home.file.".local/share/applications/Ghostty.desktop" = {
  #   source = "/home/tudor/setup/dotfiles/misc/desktop/Ghostty.desktop";
  # };
  # home.file.".local/share/icons/hicolor/32x32/apps/Ghostty.png" = {
  #   source = "/home/tudor/setup/dotfiles/misc/icons/ghostty/icon_32.png";
  # };
  # home.file.".local/share/icons/hicolor/128x128/apps/Ghostty.png" = {
  #   source = "/home/tudor/setup/dotfiles/misc/icons/ghostty/icon_128.png";
  # };
  # home.file.".local/share/icons/hicolor/256x256/apps/Ghostty.png" = {
  #   source = "/home/tudor/setup/dotfiles/misc/icons/ghostty/icon_256.png";
  # };
  # home.file.".local/share/icons/hicolor/512x512/apps/Ghostty.png" = {
  #   source = "/home/tudor/setup/dotfiles/misc/icons/ghostty/icon_512.png";
  # };

  dconf.settings = {
    "org/gnome/desktop/wm/keybindings" = {
        close = ["<Alt>F4"
                 "<Super>Q"];
        maximize-horizontally = ["<Shift><Super>h"];
        maximize-vertically = ["<Shift><Super>v"];
        move-to-monitor-down = ["<Super><Shift>Down"];
        move-to-monitor-left = ["<Super><Shift>Left"];
        move-to-monitor-right = ["<Super><Shift>Right"];
        move-to-monitor-up = ["<Super><Shift>Up"];
        move-to-workspace-left = ["<Shift><Control><Alt>Left"];
        move-to-workspace-right = ["<Shift><Control><Alt>Right"];
        switch-group = ["<Super>Above_Tab" "<Alt>Above_Tab"];
        switch-group-backward = ["<Shift><Super>Above_Tab"
                                 "<Shift><Alt>Above_Tab"];
        switch-to-workspace-1 = ["<Super>F1"];
        switch-to-workspace-2 = ["<Super>F2"];
        switch-to-workspace-3 = ["<Super>F3"];
        switch-to-workspace-4 = ["<Super>F4"];
        switch-to-workspace-last = ["<Super>End"];
        switch-to-workspace-left = ["<Control><Alt>Left"];
        switch-to-workspace-right = ["<Control><Alt>Right"];
        switch-windows = ["<Alt>Tab"];
        switch-windows-backward = ["<Shift><Alt>Tab"];
        toggle-maximized = ["<Super>Up"];
      };
      "org/gnome/settings-daemon/plugins/media-keys" = {
          custom-keybindings = [
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/"
          ];
        };
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
          name="Terminal";
          command="env WAYLAND_DISPLAY= nixGL alacritty";
          binding="<Super>Return";
        };
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
          name="vscode";
          command="flatpak run com.visualstudio.code -n --profile tudor";
          binding="<Shift><Super>Return";
        };
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
          name="flameshot";
          command="/home/tudor/programs/Flameshot-12.1.0.x86_64.AppImage gui";
          binding="<Shift><Super>s";
        };
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3" = {
          name="Flameshot Take Screenshot";
          command="flatpak run org.flameshot.Flameshot gui";
          binding="<Shift><Super>Print";
        };
  };

}
