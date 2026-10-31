{ config, pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    tmux
    rsync
    ncdu
    tree
    smartmontools
    lsof
    git
    nano
    docker-compose
  ];

  virtualisation.docker = {
    enable = true;
    autoPrune = {
      enable = true;
      dates = "weekly";
    };
  };

  users.users.laravel.extraGroups = [ "docker" ];
}