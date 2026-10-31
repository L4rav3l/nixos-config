{ pkgs, ... }:
{
  boot.loader.limine.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.limine.maxGenerations = 10;

  boot.kernelPackages = pkgs.linuxPackages_hardened;

  boot.initrd.kernelModules = [ "dm_crypt" "aes" "xts" ];

  boot.initrd.systemd.enable = true;

  boot.tmp.useTmpfs = true;

  boot.supportedFilesystems = [ "ntfs" "exfat" "ext4" "btrfs" ];

  boot.kernelParams = [ "quiet" "loglevel=3" ];
} 