{ pkgs, ... }:
{
  home.stateVersion = "26.11";

  home.packages = with pkgs; [
    alacritty
    vscodium
    vlc
    brave-origin
    proton-vpn
    gnome-calculator
    okular
    qbittorrent
    vesktop
    anki
    prismlauncher
    obs-studio
    torbrowser
    ultimaker-cura
    aseprite
    yt-dlp
    ffmpeg
    davinci-resolve
    fastfetch
    dotnet-sdk_10
  ];

  systemd.user.services.usbguard-notifier = {
    Unit = {
      Description = "USBGuard Notifier";
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.usbguard-notifier}/bin/usbguard-notifier";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "default.target" ];
  };

  programs.gnome-shell.extensions = [
    { package = pkgs.gnomeExtensions.appindicator; }
  ];
  
  programs.fish = {
    enable = true;
    shellAliases = {
      ll = "ls -al";
    };
    interactiveShellInit = ''
    set -g fish_greeting "" 
    fastfetch '';
  };

  programs.git = {
    enable = true;
    userName = "L4rav3l";
    userEmail = "108834640+L4rav3l@users.noreply.github.com";
    aliases = {
      st = "status -sb";
      lg = "log --oneline --graph --decorate";
    };
    extraConfig = {
      pull.rebase = true;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
    "org/gnome/shell" = {
      favorite-apps = [
        "brave-origin.desktop"
        "codium.desktop"
        "Alacritty.desktop"
      ];
    };
  };
}