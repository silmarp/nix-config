{ pkgs, config, ... }:

{
  config.home.packages = with pkgs; [
    fzf
  ];

  config.programs.zk = {
    enable = true;
    settings = {

      notebook ={
        dir = "~/Documents/notebook";
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

      group.structured = {
        paths = ["structured"];
      };
      
      group.structured.note = {
        filename = "{{title}}";
        template = "structured.md";
      };

      format.markdown = {
        link-format = "markdown";
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
        edlast = "zk edit --limit 1 --sort modified- $@";
        recent = "zk edit --sort created- --created-after 'last two weeks' --interactive";
        lucky = "zk list --quiet --format full --sort random --limit 1";
        rm = ''zk list --interactive --quiet --format "{{abs-path}}" --delimiter0 $@ | xargs -0 rm -vf --'';
        review = "zk edit inbox --sort created+ --interactive";
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
