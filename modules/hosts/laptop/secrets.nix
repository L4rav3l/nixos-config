{ inputs , config, ... }:
{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  services.openssh.generateHostKeys = true;

  sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

  sops.defaultSopsFile = ../../../secrets/laptop.yaml;
  sops.defaultSopsFormat = "yaml";

  #sops.secrets."user/laravel-password".neededForUsers = true;
  #sops.secrets."wifi/home-psk" = { }; 
  #sops.secrets."wifi/home-ssid" = { };
  #sops.secrets."wifi/mobile-ssid" = { };
  #sops.secrets."wifi/mobile-psk" = { };

  #sops.templates."wifi.env".content = ''
  #   WIFI_HOME_SSID=${config.sops.placeholder."wifi/home-ssid"}
  #   WIFI_HOME_PSK=${config.sops.placeholder."wifi/home-psk"}
  #   WIFI_MOBILE_SSID=${config.sops.placeholder."wifi/mobile-ssid"}
  #   WIFI_MOBILE_PSK=${config.sops.placeholder."wifi/mobile-psk"}
  # '';

}