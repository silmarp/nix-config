{ config, pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      tasksh
      taskwarrior-tui
      taskopen
    ];
    shellAliases = {
      "t" = "task";
      "in" = "task add +in";
      "inbox" = "task inbox";
      "next" = "task +next";
    };
  };

  programs.taskwarrior = {
    enable = true;
    colorTheme = "solarized-dark-256";
    config = {
      # Defautl taskwarrior report
      report = {
        next = {
          columns=[ "id" "start.age" "entry.age" "depends" "priority" "project" "tags" "recur" "scheduled.countdown" "due.relative" "until.remaining" "description" "brainpower" "estimate" "urgency" ];
          labels=[ "ID" "Active" "Age" "Deps" "Prio" "Project" "Tag" "Recur" "S" "Due" "Until" "Description" "BP" "Estimate" "Urg" ];
          filter ="status:pending -WAITING limit:page -in -someday";
          sort = "urgency-";
        };

        inbox = {
          columns=[ "id" "due.relative" "description" "urgency" ];
          labels=[ "ID" "Due""Description" "Urg" ];
          filter ="\+in status:pending -WAITING limit:page";
          sort = "urgency-";
        };

        someday = {
          columns=[ "id" "start.age" "entry.age" "depends" "priority" "project" "tags" "recur" "scheduled.countdown" "due.relative" "until.remaining" "description" "urgency" ];
          labels=[ "ID" "Active" "Age" "Deps" "Prio" "Project" "Tag" "Recur" "S" "Due" "Until" "Description" "Urg" ];
          filter ="\+someday status:pending -WAITING limit:page";
        };

        todo = {
          columns=[ "id" "start.age" "entry.age" "depends" "priority" "project" "tags" "recur" "scheduled.countdown" "due.relative" "until.remaining" "description" "urgency" ];
          labels=[ "ID" "Active" "Age" "Deps" "Prio" "Project" "Tag" "Recur" "S" "Due" "Until" "Description" "Urg" ];
          filter ="\+todo status:pending -WAITING limit:page -someday";
        };

        # custom report completed today
        review = {
          description="List of completed tasks today";
          columns="project,description.count,status";
          labels="Proj,Desc,Status";
          filter="end:today (status:completed or status:deleted)";
        };
      };

      uda = {
        estimate = {
          type = "numeric";
          label = "Estimate";
        };
        brainpower = {
          type = "string";
          label = "BrainPower";
          values = "L,M,H";
        };
      };

      # Contexts
      context = {
        academic = {
          read  = "+academic or +college or +study";
          write = "+academic";
        };
        work = {
          read  = "+work or +freelance or +internship";
          write = "+work";
        };
        personal = {
          read  = "+personal";
          write = "+personal";
        };
        hobby = {
          read  = "+hobby";
          write = "+hobby";
        };
      };
    };

    dataLocation = "/home/silmar/.task";

    extraConfig ="
      # priority coefficient
      urgency.uda.priority.H.coefficient=8.0
      urgency.uda.priority.M.coefficient=5.0
      urgency.uda.priority.L.coefficient=1.0

      # tasks with dependents inherit their priority
      urgency.inherit=on
 
      # project priority
      urgency.user.tag.urgent.coefficient=40.0 
    ";
  };
}
