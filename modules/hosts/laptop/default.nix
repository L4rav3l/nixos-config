{ inputs, ... }:
{
  imports = [
    inputs.nixos-hardware.nixosModules.framework-13-7040-amd
    inputs.disko.nixosModules.disko
    inputs.home-manager.nixosModules.home-manager

    ./boot.nix
    ./disko.nix
    ./services.nix

    ../../features/base.nix
    ../../features/cli.nix
    ../../features/secrets.nix
  ];

  networking.hostName = "framework13";
  system.stateVersion = "26.11";

  users.users.laravel = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.laravel = import ./home.nix;
  };
}