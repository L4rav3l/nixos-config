{ config, ... }:
{
  networking.networkmanager.enable = true;
  networking.networkmanager.dns = "systemd-resolved";

  services.resolved = {
    enable = true;
    settings.Resolve.DNSOverTLS = "yes";
  };

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  services.fwupd.enable = true;
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;
  services.upower.criticalPowerAction = "PowerOff";
  services.libinput.enable = true;
  hardware.bluetooth.enable = true;
  hardware.graphics.enable = true;
  hardware.cpu.amd.updateMicrocode = true;

  services.fstrim.enable = true;
  services.btrfs.autoScrub.enable = true;

  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ ];

  services.smartd.enable = true;
  services.journald.extraConfig = "SystemMaxUse=500M";
  services.iio-sensor-proxy.enable = true;

  services.printing.enable = true;

  networking.nftables.enable = true;

  services.usbguard = {
    enable = true;
    IPCAllowedUsers = [ "root" "laravel" ];
    presentDevicePolicy = "keep";
    implicitPolicyTarget = "block";
  };

  #networking.networkmanager.ensureProfiles = {
  # environmentFiles = [ config.sops.templates."wifi.env".path ];
  # profiles = {
  # home = {
  #       connection = { id = "home"; type = "wifi"; };
  #       wifi = { mode = "infrastructure"; ssid = "$WIFI_HOME_SSID"; };
  #       wifi-security = { key-mgmt = "wpa-psk"; psk = "$WIFI_HOME_PSK"};
  #       ipv4.method = "auto";
  #       ipv6.method = "auto"; 
  #     };
  # mobile = {
  #       connection = { id = "mobile"; type = "wifi"; };
  #       wifi = { mode = "infrastructure"; ssid = "$WIFI_MOBILE_SSID"; };
  #       wifi-security = { key-mgmt = "wpa-psk"; psk = "$WIFI_MOBILE_PSK"; };
  #       ipv4.method = "auto";
  #       ipv6.method = "auto";
  #     };
  #   };
  # };

  services.snapper.configs.root = {
    SUBVOLUME = "/";
    TIMELINE_CREATE = true;
  };

  zramSwap.enable = true;
  boot.kernel.sysctl = {
    "vm.swappiness" = 180;
    "vm.page-cluster" = 0;
  };
}