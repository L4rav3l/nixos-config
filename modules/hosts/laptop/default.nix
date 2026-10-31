{ inputs, lib, pkgs, ... }:
{
  imports = [
    inputs.nixos-hardware.nixosModules.framework-13-7040-amd
    inputs.disko.nixosModules.disko
    inputs.home-manager.nixosModules.home-manager

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

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "davinci-resolve"
      "aseprite"
    ];

  networking.hostName = "framework13";
  system.stateVersion = "26.11";

  users.users.laravel = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.fish;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.laravel = import ./home.nix;
  };
}