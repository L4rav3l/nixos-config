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

      jellyseerr = {
          image = "fallenbagel/jellyseerr:latest";
          ports = [ "8001:5055" ];
          volumes = [ "/data/jellyseerr/config:/app/config" ];
          environment = { TZ = "Europe/Budapest" };
          extraOptions = [ "--add-host=host.docker.internal:host-gateway" ];
      };

      prowlarr = {
        image = "linuxserver/prowlarr:latest";
        ports = [ "8004:9696" ];
        volumes = [
          "/data/prowlarr/config:/config"
        ];
        environment = { PUID = "1000"; PGID = "1000"; TZ = "Europe/Budapest" };
        extraOptions = [ "--add-host=host.docker.internal:host-gateway" ];
      };

      sonarr = {
        image = "linuxserver/sonarr:latest";
        ports = [ "8005:8989" ];
        volumes = [
          "/data/sonarr/config:/config"
          "/data/qbittorrent_series/downloads:/downloads"
          "/data/media:/media"
        ];
        environment = { PUID = "1000"; PGID = "1000"; TZ = "Europe/Budapest" };
        extraOptions = [ "--add-host=host.docker.internal:host-gateway" ];
      };

      radarr = {
        image = "linuxserver/radarr:latest";
        ports = [ "8006:7878" ];
        volumes = [
          "/data/radarr/config:/config"
          "/data/qbittorrent_movies/downloads:/downloads"
          "/data/media:/media"
        ];
        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "Europe/Budapest";
        };
        extraOptions = [ "--add-host=host.docker.internal:host-gateway" ];
      };

      tdarr = {
        image = "ghcr.io/haveagitgat/tdarr:latest";
        ports = [ "8007:8265" "8266:8266" ];
        volumes = [
          "/data/tdarr/servers:/app/server"
          "/data/tdarr/configs:/app/configs"
          "/data/tdarr/logs:/app/logs"
          "/var/cache/tdarr:/temp"
          "/data/media:/media"
        ];
        environment = {
          PUID = "1000";
          PGID = "1000";
          UMASK = "002";
          TZ = "Europe/Budapest";
          serverIP = "0.0.0.0";
          serverPort = "8266";
          webUIPort = "8265";
          internalNode = "false";
          inContainer = "true";
          ffmpegVersion = "7";
          openBrowser = "false";
          maxLogSizeMB = "10";
        };
      };

      jellyfin = {
        image = "jellyfin/jellyfin:latest";
        ports = [ "8000:8096" ];
        volumes = [
          "/data/jellyfin/config:/config"
          "/data/jellyfin/cache:/cache"
          "/data/media:/media"
        ];
      };
    };
  };

  users.users.laravel.extraGroups = [ "docker" ];
}