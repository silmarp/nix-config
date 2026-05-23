{ ... }:

{
  programs.helix = {
    enable = true;
    #defaultEditor = true;
    settings = {
      editor = {
        line-number = "relative";
        soft-wrap.enable = true;
        bufferline = "always";
        shell = ["nu" "--stdin" "-c"];
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
      };
    };
  };
}
