{ ... }:

{
  programs.helix = {
    enable = true;
    #defaultEditor = true;
    settings = {
      theme = "adwaita-dark";
      editor = {
        line-number = "relative";
        soft-wrap.enable = true;
        bufferline = "always";
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
      };
    };
  };
}
