{ inputs, pkgs, ... }:
{
  boot.loader.limine.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.limine.maxGenerations = 10;

  nixpkgs.overlays = [ inputs.nix-cachyos-kernel.overlays.pinned ];
  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;

  nix.settings = {
    extra-substituters = [ "https://cache.lantian.pub/lantian" ];
    extra-trusted-public-keys = [ "lantian:WVGO7vsRMSEN+h7Lp7kv6SAmrkEXgUGbbXm7jMDjBuQ=" ];
  };

  boot.initrd.kernelModules = [ "dm_crypt" "aes" "xts" ];

  boot.tmp.useTmpfs = true;

  boot.supportedFilesystems = [ "ntfs" "exfat" "ext4" "btrfs" ];

  boot.kernelParams = [ "quiet" "loglevel=3" ];
  
  boot.kernelModules = [ "kvm-amd" ];

  boot.initrd.systemd.extraBin.btrfs = "${pkgs.btrfs-progs}/bin/btrfs";

  boot.initrd.systemd.services.rollback-root = {
    description = "Rollback BTRFS Root subvolume to a pristine state";
    wantedBy = [ "initrd.target" ];
    after = [ "systemd-cryptsetup@cryptroot.service" ];
    before = [ "sysroot.mount" ];
    unitConfig.DefaultDependencies = "no";
    serviceConfig.Type = "oneshot";
    script = ''
      mkdir -p /mnt
      mount -t btrfs -o subvol=/ /dev/mapper/cryptroot /mnt
      if btrfs subvolume show /mnt/@blank >/dev/null 2>&1; then
        btrfs subvolume delete -R /mnt/@
        btrfs subvolume snapshot /mnt/@blank /mnt/@
        echo 'root subvolume rolled back from @blank'
      else
        btrfs subvolume snapshot /mnt/@ /mnt/@blank
        echo 'pristine @blank created'
      fi
      umount /mnt
    '';
  };
} 