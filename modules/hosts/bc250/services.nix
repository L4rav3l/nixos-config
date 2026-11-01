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

  hardware.bc250 = {
    enable = true;
    features = {
      acpiFix.enable = true;
      coreUnlock.enable = true;
      vramSplit = 6144;
      cuLiveManager.enable = true;
    };
  };

  services.cyan-skillfish-governor-smu.settings.gpu-usage.fix-freq = true;
}