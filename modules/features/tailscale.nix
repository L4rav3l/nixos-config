{ config, ... }:
{
  services.tailscale = {
    enable = true;
    openFirewall = true;
    authKeyFile = config.sops.secrets."tailscale/key".path;
  };

  systemd.services.tailscaled-autoconnect.after = [ "sops-install-secrets.service" ];
}