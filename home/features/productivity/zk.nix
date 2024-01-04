{ pkgs, config, ... }:

{
  # TODO when zk module is added to home-manager remove config.home.*
  config.home.packages = with pkgs; [
    fzf
    # TODO: heist is broken?
    # emanote
  ];
  
  config.home.sessionVariables = {
    # Exports notebook path for zk-nvim use
    ZK_NOTEBOOK_DIR = "${config.home.homeDirectory}/Notes/zettel/";
  };

  config.programs.zk = {
    enable = true;
    settings = {

      notebook ={
        dir = "~/Notes/zettel";
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

      group.journal = {
        paths = ["journal" "journal/weekly" "journal/daily"];
      };

      group.journal.note = {
        filename = "{{format-date now}}";
        template = "journal.md";
      };

      # TODO review filenames and templates
      group.inbox = {
        paths = ["inbox"];
      };

      group.inbox.note = {
        filename = "{{format-date now}}-{{id}}";
        template = "inbox.md";
      };

      group.ideas = {
        paths = ["ideas"];
      };
      
      group.ideas.note = {
        filename = "{{format-date now}}-{{title}}";
        template = "ideas.md";
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
        "in" = "zk new inbox -t \"$@\"";
        # Opens oldest inbox note for review
        review = "zk edit inbox --sort created+ --limit 1 $@";
        perm = "zk new -t \"$@\"";
        edlast = "zk edit --limit 1 --sort modified- $@";
        recent = "zk edit --sort created- --created-after 'last two weeks' --interactive";
        lucky = "zk list --quiet --format full --sort random --limit 1";
        rm = ''zk list --interactive --quiet --format "{{abs-path}}" --delimiter0 $@ | xargs -0 rm -vf --'';
        # TODO  solve problem incapable of using ${pkgs...}
        # Permission denied
        #serve = "${pkgs.emanote} run --port=8080";
        # serve = "emanote run --port=8080";
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
