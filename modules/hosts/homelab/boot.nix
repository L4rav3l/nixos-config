{ pkgs, ...}:
{
    boot.kernelPackages = pkgs.linuxPackages;
    hardware.cpu.intel.updateMicrocode = true;

    boot.loader.limine.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.limine.maxGenerations = 10;

    boot.initrd.systemd.network = {
      enable = true;
      networks."10-eth" = {
        matchConfig.Name = "en*";
        networkConfig.DHCP = "ipv4";
      };
    };

    boot.initrd.network.ssh = {
      enable = true;
      port = 2222;
      hostKeys = [ ./ssh/initrd-ssh-host-key ];
    };

    boot.initrd.availableKernelModules = [
      "usb_storage"
      "uas"
      "r8169"
      "e1000e"
    ];

    users.users.root.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICeeBLX2oSj4nhsIUbrK7oX4ORrBBq9qqKywNdy5vHeq l4rav3l@proton.me"
    ];

    boot.kernelParams = [ "quiet" "loglevel=3" ];
}