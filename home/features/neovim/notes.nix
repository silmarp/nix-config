{ pkgs, ... }: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = zk-nvim;
      type = "lua";
      config = /*lua*/ ''
        require("zk").setup({
          picker = "telescope",

          lsp = {
            config = {
              cmd = { "zk", "lsp" },
              name = "zk",
            },

            auto_attach = {
              enabled = true,
              filetypes = { "markdown" },
            },
          },
        })
      '';
    }
  ];
}
