{ inputs, pkgs, ... }:
{
  imports = [
    inputs.disko.nixosModules.disko
    inputs.home-manager.nixosModules.home-manager
    inputs.bc-250.nixosModules.bc250;

    ./boot.nix
    ./disko.nix
    ./services.nix
    ./secrets.nix

    ../../features/base.nix
    ../../features/cli.nix
    ../../features/desktop.nix
    ../../features/theme.nix
    ../../features/tailscale.nix
  ];

  networking.hostName = "bc250";
  system.stateVersion = "26.11";

  users.users.laravel = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.fish;
  };

  security.sudo.wheelNeedsPassword = false;
  
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.laravel = import ./home.nix;
  };
}