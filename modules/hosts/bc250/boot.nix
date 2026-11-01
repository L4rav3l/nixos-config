{ inputs, pkgs, ... }:
{
  nixpkgs.overlays = [ inputs.nix-cachyos-kernel.overlays.pinned ];
  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-lts;

  nix.settings = {
    extra-substituters = [ "https://cache.lantian.pub/lantian" ];
    extra-trusted-public-keys = [ "lantian:WVGO7vsRMSEN+h7Lp7kv6SAmrkEXgUGbbXm7jMDjBuQ=" ];
  };

  boot.loader.limine.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.limine.maxGenerations = 10;

  hardware.cpu.amd.updateMicrocode = true;

  boot.initrd.systemd.enable = true;

  boot.supportedFilesystems = [ "btrfs" "ext4" "exfat" "ntfs" ];
  boot.kernelParams = [ "quiet" "loglevel=3" "nvme_core.default_ps_max_latency_us=0" ];
}