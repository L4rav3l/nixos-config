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
    settings = {
      user = {
        name = "L4rav3l";
        email = "108834640+L4rav3l@users.noreply.github.com";
      };
      alias = {
        st = "status -sb";
        lg = "log --oneline --graph --decorate";
      };
      pull.rebase = true;
    };
  };
}