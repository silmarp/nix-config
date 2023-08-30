{ lib, pkgs, config, ... }: 

{
  programs.wofi = {
    enable = true;
    settings = {
      location = 0; # Center
      allow_images = true;
      columns = 1;
      insensitive = true;
    };
    style = /* css */ ''
      #img {
        margin: 5px;
      }
      .entry {
        margin: 5px;
      }
    '';
  };
}
