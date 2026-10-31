{ pkgs, ... }:
{
  boot.loader.limine.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.limine.maxGenerations = 10;

  boot.kernelPackages = pkgs.linuxPeckages_zen;

  boot.initrd.kernelModules = [ "dm_crypt" "aes" "xts" ];

  boot.initrd.systemd.enable = true;

  boot.supportedFilesystems = [ "ntfs" "exfat" "ext4" "btrfs"];

  boot.kernelParams = [ "quiet" "loglevel=3" ];
} 