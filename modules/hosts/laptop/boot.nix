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
        echo 'root subvolume undo successfully'
      else
        echo 'rollback skipped'
      fi
      umount /mnt
    '';
  };
} 