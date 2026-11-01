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
                  "@"          = { mountpoint = "/";            mountOptions = [ "compress=zstd:1" "noatime" ]; };
                  "@home"      = { mountpoint = "/home";        mountOptions = [ "compress=zstd:1" "noatime" ]; };
                  "@nix"       = { mountpoint = "/nix";         mountOptions = [ "compress=zstd:1" "noatime" ]; };
                  "@log"       = { mountpoint = "/var/log";     mountOptions = [ "compress=zstd:1" "noatime" ]; };
                  "@cache"     = { mountpoint = "/var/cache";   mountOptions = [ "compress=zstd:1" "noatime" ]; };
                  "@tmp"       = { mountpoint = "/var/tmp";     mountOptions = [ "compress=zstd:1" "noatime" ]; };
                  "@srv"       = { mountpoint = "/srv";         mountOptions = [ "compress=zstd:1" "noatime" ]; };
                  "@snapshots" = { mountpoint = "/.snapshots";  mountOptions = [ "compress=zstd:1" "noatime" ]; };
                };
              };
            };
          };
        };
      };
    };
  };
}