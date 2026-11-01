{ ... }:
{
  programs.steam.enable = true;
  hardware.steam-hardware.enable = true;
  programs.gamemode.enable = true;

  hardware.bluetooth.enable = true;

  networking.networkmanager.enable = true;

  services.displayManager.autoLogin = {
    enable = true;
    user = "laravel";
  };
}