{ pkgs, ... }:
{
  home.stateVersion = "26.11";

  home.packages = with pkgs; [
    fastfetch
    tmux
    jq
    
    protonup-qt
    protontricks
    mangohud
    goverlay
    gamescope
    vkbasalt
    dualsensectl
    nvtopPackages.amd
  ];

  programs.fish = {
    enable = true;
    shellAliases = {
      ll = "ls -al";
    };
    interactiveShellInit = ''
      set -g fish_greeting ""
      fastfetch
    '';
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
}