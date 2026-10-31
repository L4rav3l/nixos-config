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
  
  virtualisation.oci-containers = {
    backend = "docker";

    containers = {
      qbittorrent_series = {
        image = "linuxserver/qbittorrent:latest";
        ports = [ "8002:8080" "6881:6881" "6881:6881/udp" ];
        volumes = [
          "/data/qbittorrent_series/config:/config"
          "/data/qbittorrent_series/downloads:/downloads"
        ];
        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "Europe/Budapest";
          WEBUI_PORT="8080";
        };
      };

      qbittorrent_movies = {
        image = "linuxserver/qbittorrent:latest";
        ports = ["8003:8080" "6882:6881" "6882:6881/udp"];
        volumes = [
          "/data/qbittorrent_movies/config:/config"
          "/data/qbittorrent_movies/downloads:/downloads"
        ];
        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "Europe/Budapest";
          WEBUI_PORT = "8080";
        };
      };
    };
  };

  users.users.laravel.extraGroups = [ "docker" ];
}