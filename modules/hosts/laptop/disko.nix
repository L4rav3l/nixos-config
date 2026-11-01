{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "4G";
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
                settings = {
                  allowDiscards = true;
                  crypttabExtraOpts = [ "tpm2-device=auto" ];
                };
                content = {
                  type = "btrfs";
                  extraArgs = [ "-f" ];
                  subvolumes = {
                    "@"            = { mountpoint = "/";                        mountOptions = ["compress=zstd:1" "noatime" ]; };
                    "@home"        = { mountpoint = "/home";                    mountOptions = ["compress=zstd:1" "noatime" ]; };
                    "@nix"         = { mountpoint = "/nix";                     mountOptions = ["compress=zstd:1" "noatime" ]; };
                    "@log"         = { mountpoint = "/var/log";                 mountOptions = ["compress=zstd:1" "noatime" ]; };
                    "@cache"       = { mountpoint = "/var/cache";               mountOptions = ["compress=zstd:1" "noatime" ]; };
                    "@tmp"         = { mountpoint = "/var/tmp";                 mountOptions = ["compress=zstd:1" "noatime" ]; };
                    "@srv"         = { mountpoint = "/srv";                     mountOptions = ["compress=zstd:1" "noatime" ]; };
                    "@snapshots"   = { mountpoint = "/.snapshots";              mountOptions = ["compress=zstd:1" "noatime" ]; };
                    "@persist"     = { mountpoint = "/persist";                 mountOptions = ["compress=zstd:1" "noatime" ]; };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}