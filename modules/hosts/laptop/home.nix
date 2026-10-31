{ ... }:
{
  home.stateVersion = "26.11";

  programs.git = {
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