{ ... }:
{
  i18n.defaultLocale = "hu_HU.UTF-8";
  
  time.timeZone = "Europe/Budapest";

  console.keyMap = "hu";

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
    trusted-users = [ "root" "@wheel" ];
  };

  nix.gc = {
    automatic = true;
    dates = "monthly";
    options = "--delete-older-than 14d";
  };
}