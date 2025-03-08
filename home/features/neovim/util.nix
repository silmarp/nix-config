{ pkgs, ... }: {
  programs.neovim = { 
    plugins = with pkgs.vimPlugins; [
      {
        plugin = nvim-surround;
        type = "lua";
        config = /*lua*/ ''
          require("nvim-surround").setup()
        '';
      }
      {
				plugin = nvim-autopairs;
				type = "lua";
				config = /*lua*/''
					require("nvim-autopairs").setup {}
				'';
			}
    ];
  };
}
