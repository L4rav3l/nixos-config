{ ... }:
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
              size = "2G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            root = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ];
                subvolumes = {
                  "@"          = { mounpoint = "/";            mountOptions = [ "compress=zstd:1" "noatime" ]; };
                  "@home"      = { mounpoint = "/home";        mountOptions = [ "compress=zstd:1" "noatime" ]; };
                  "@nix"       = { mounpoint = "/nix";         mountOptions = [ "compress=zstd:1" "noatime" ]; };
                  "@log"       = { mounpoint = "/var/log";     mountOptions = [ "compress=zstd:1" "noatime" ]; };
                  "@cache"     = { mounpoint = "/var/cache";   mountOptions = [ "compress=zstd:1" "noatime" ]; };
                  "@tmp"       = { mounpoint = "/var/tmp";     mountOptions = [ "compress=zstd:1" "noatime" ]; };
                  "@srv"       = { mounpoint = "/srv";         mountOptions = [ "compress=zstd:1" "noatime" ]; };
                  "@snapshots" = { mounpoint = "/.snapshots";  mountOptions = [ "compress=zstd:1" "noatime" ]; };
                };
              };
            };
          };
        };
      };
    };
  };
}