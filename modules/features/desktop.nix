{ pkgs, ...}:
{
  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;

  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-connections
  ];

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  fonts.packages = with pkgs; [ noto-fonts-color-emoji noto-fonts-cjk-sans ];

  security.rtkit.enable = true;
  programs.dconf.enable = true;
  services.gnome.gnome-keyring.enable = true;
}