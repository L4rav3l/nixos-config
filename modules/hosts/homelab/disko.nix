{ ... }:
{
  disko.devices = {
    disk = {
      # 240 GB SATA SSD
      system = {
        type = "disk";
        device = "/dev/disk/by-id/sata-main";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "2G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            cryptroot = {
              size = "100%";
              content = {
                type = "luks";
                name = "cryptroot";
                settings = { allowDiscards = true; };
                content = {
                  type = "btrfs";
                  extraArgs = [ "-f" ];
                  subvolumes = {
                    "@"              = { mountpoint = "/";            mountOptions = [ "compress=zstd:1" "noatime"]; };
                    "@home"          = { mountpoint = "/home";        mountOptions = [ "compress=zstd:1" "noatime"]; };
                    "@nix"           = { mountpoint = "/nix";         mountOptions = [ "compress=zstd:1" "noatime"]; };
                    "@log"           = { mountpoint = "/var/log";     mountOptions = [ "compress=zstd:1" "noatime"]; };
                    "@cache"         = { mountpoint = "/var/cache";   mountOptions = [ "compress=zstd:1" "noatime"]; };
                    "@tmp"           = { mountpoint = "/var/tmp";     mountOptions = [ "compress=zstd:1" "noatime"]; };
                    "@srv"           = { mountpoint = "/srv";         mountOptions = [ "compress=zstd:1" "noatime"]; };
                    "@snapshots"     = { mountpoint = "/.snapshots";  mountOptions = [ "compress=zstd:1" "noatime"]; };
                  };
                };
              };
            };
          };
        };
      };
      # 1TB WD
      data = {
        type = "disk";
        device = "/dev/disk/by-id/western_digital_usb";
        content = {
          type = "luks";
          name = "cryptdata";
          settings = {
            crypttabExtraOpts = [ "nofail" ];
          };
          content = {
            type = "btrfs";
            extraArgs = [ "-f" ];
            subvolumes = {
              "@data" = { mountpoint = "/data"; mountOptions = [ "compress=zstd:1" "noatime" "nofail"]; };
            };
          };
        };
      };
    };
  };
}