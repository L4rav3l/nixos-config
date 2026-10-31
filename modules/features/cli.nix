{ pkgs, ... }:
{
  programs.git.enable = true;

  environment.systemPackages = with pkgs; [
    nano
    wget
    unzip
    file
    ripgrep
    fd
    btop
    git
  ];

  programs.fish.enable = true;
}