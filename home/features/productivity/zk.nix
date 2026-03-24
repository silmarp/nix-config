{ pkgs, config, ... }:

let
  notebook = "${config.home.homeDirectory}/Notes";
in
{
  home.packages = with pkgs; [
    fzf
  ];

  programs.zk = {
    enable = true;
    settings = {
      notebook ={
        dir = "${notebook}";
      };

      note = {
        language = "en";
        filename = "{{id}}-{{slug title}}";
        extension = "md";
        template = "default.md";
        id-charset = "alphanum";
        id-length = 8;
        id-case = "lower";
        exclude = [
        ];
      };

      extra = {
        author = "Silmar";
      };

      group = {
        literature = {
          note = {
            template = "literature.md";
          };
        };
        fleeting = {
          note = {
            template = "fleeting.md";
          };
        };      };
      
      format.markdown = {
        link-format = "wiki";
        hashtags = true;
      };

      tool = {
        #editor = "${pkgs.neovim}/bin/nvim";
        editor = "hx";
        shell = "${pkgs.zsh}/bin/zsh";
        pager = "${pkgs.less}/bin/less -FIRX";
        fzf-preview = "${pkgs.bat}/bin/bat -p --color always {-1}";
      };

      filter = {
        recent = "--sort created- --created-after 'last two weeks'";
        journal = "--limit 1 --sort created- journal";
        orphan = "--orphan -x journal";
      };

      alias = {
        lit = "zk new -g literature -t $@";
        note = "zk new -t $@";
        fleet = "zk new -g fleeting -t $@";
        ed = "zk edit -i $@";
      };

      lsp = {
        lsp.diagnostics = {
          wiki-title = "hint";
          dead-link = "error";
        };
      };
    };
  };
}
