{ pkgs, config, ... }:

let
  notebook = "${config.home.homeDirectory}/Notes/zettel/";
in
{
  home.packages = with pkgs; [
    fzf
  ];
  
  home.sessionVariables = {
    # Exports notebook path for zk-nvim use
    ZK_NOTEBOOK_DIR = "${notebook}";
  };

  programs.zk = {
    enable = true;
    settings = {

      notebook ={
        dir = "${notebook}";
      };

      note = {
        language = "en";
        default-title = "Untitled";
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
        journal = {
          paths = ["journal" "journal/weekly" "journal/daily"];

          note = {
            filename = "{{format-date now}}";
            template = "journal.md";
          };
        };

        ideas = {
          paths = ["ideas"];
          note = {
            filename = "{{id}}";
            template = "ideas.md";
          };
        };

        reference = {
          paths = ["reference"];
          note = {
            filename = "{{id}}";
          };
        };
      };
      
      format.markdown = {
        link-format = "markdown";
        link-drop-extension = false;
      };

      tool = {
        #editor = "${pkgs.neovim}/bin/nvim";
        editor = "nvim";
        shell = "${pkgs.zsh}/bin/zsh";
        pager = "${pkgs.less}/bin/less -FIRX";
        fzf-preview = "${pkgs.bat}/bin/bat -p --color always {-1}";
      };

      filter = {
        recents = "--sort created- --created-after 'last two weeks'";
        journal = "--limit 1 --sort created- journal";
        orphan = "--orphan -x journal";
      };

      alias = {
        # Create notes
        lit = "zk new reference --template=literature.md";
        fleet = "zk new reference --template=fleeting.md";
        perm = "zk new ideas --template=permanent.md";
        journal = "zk new journal/daily";

        # Open note to edit
        review = "zk edit -i --sort modified+ --limit 5 -t review $@";
        incomplete = "zk edit -i --sort modified+ --limit 5 -t incomplete $@";
        edlast = "zk edit --limit 1 --sort modified- $@";
        recent = "zk edit --sort created- --created-after 'last two weeks' --interactive";

        # List note
        lucky = "zk list --quiet --format full --sort random --limit 1";
        rm = ''zk list --interactive --quiet --format "{{abs-path}}" --delimiter0 $@ | xargs -0 rm -vf --'';
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
