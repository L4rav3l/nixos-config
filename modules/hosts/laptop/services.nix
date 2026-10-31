{ ... }:
{
  networking.networkmanager.enable = true;
  networking.networkmanager.dns = "systemd-resolved";

  services.resolved = {
    enable = true;
    settings.Resolve.DNSOverTLS = "yes";
  };

  services.fwupd.enable = true;
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;
  services.libinput.enable = true;
  hardware.bluetooth.enable = true;
  hardware.graphics.enable = true;

  services.fstrim.enable = true;
  services.btrfs.autoScrub.enable = true;

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