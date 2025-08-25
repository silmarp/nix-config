{ pkgs, config, ... }:

let
  notebook = "${config.home.homeDirectory}/Nextcloud/Notes";
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
        filename = "{{id}}";
        extension = "md";
        template = "default.md";
        id-charset = "alphanum";
        id-length = 6;
        id-case = "lower";
        exclude = [
        ];
      };

      extra = {
        author = "Silmar";
      };

      group = {
        yearly = {
          paths = ["journal"];
          note = {
            filename = "{{format-date now '%Y'}}";
            template = "yearly.md";
          };
        };
        monthly = {
          paths = ["journal"];
          note = {
            filename = "{{format-date now '%Y-%m'}}";
            template = "monthly.md";
          };
        };
        daily = {
          paths = ["journal"];
          note = {
            filename = "{{format-date now}}";
            template = "daily.md";
          };
        };

        note = {
          paths = ["note"];
          note = {
            filename = "{{id}}";
            template = "note.md";
          };
        };

        zettel = {
          paths = ["zettel"];
          note = {
            filename = "{{id}}";
            template = "zettel.md";
          };
        };
      };
      
      format.markdown = {
        link-format = "[[{{title}}]]";
      };

      tool = {
        #editor = "${pkgs.neovim}/bin/nvim";
        editor = "nvim";
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
        # Create notes
        journal = "zk new daily";
        zettel = ""; # todo 
        note = ""; # todo (maybe separate in literature and fleeting)
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
