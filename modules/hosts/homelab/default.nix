{ inputs, pkgs, ...}:
{
  imports = [
    inputs.disko.nixosModules.disko

    ./boot.nix
    ./disko.nix
    ./services.nix
    ./secrets.nix

    ../../features/base.nix
    ../../features/cli.nix
    ../../features/server.nix
    ../../features/tailscale.nix
  ];

  networking.hostName = "homelab";
  system.stateVersion = "26.11";

  users.users.laravel = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICeeBLX2oSj4nhsIUbrK7oX4ORrBBq9qqKywNdy5vHeq l4rav3l@proton.me"
    ];
  };

  security.sudo.wheelNeedsPassword = false;
}