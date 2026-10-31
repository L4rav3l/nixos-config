{ inputs, pkgs, ...}: 
{
  imports = [ inputs.stylix.nixosModules.stylix ];

  stylix = {
    enable = true;
    polarity = "dark";
    image = ../../assets/wallpaper.jpg  ;
    #base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    

    homeManagerIntegration = {
      autoImport = true;
      followSystem = true;
    };

    fonts = {
      monospace = { package = pkgs.jetbrains-mono; name = "JetBrains Mono"; };
      sansSerif = { package = pkgs.inter; name = "Inter"; };
      sizes = { applications = 11; terminal = 12; };
    };
  };
}