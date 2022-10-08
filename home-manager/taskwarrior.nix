{
  programs.taskwarrior = {
    enable = true;
    colorTheme = "solarized-dark-256";
    config = {
      report.next.columns=[ "id" "start.age" "entry.age" "depends" "priority" "effort" "project" "tags" "recur" "scheduled.countdown" "due.relative" "until.remaining" "description" "urgency" ];
      report.next.labels=[ "ID" "Active" "Age" "Deps" "Prio" "Effort" "Project" "Tag" "Recur" "S" "Due" "Until" "Description" "Urg" ];
    };

    dataLocation = "/home/silmar/.task";

    extraConfig ="
      # uda.effort
      uda.effort.type=string 
      uda.effort.label=Effort
      uda.effort.default=L
      uda.effort.values=H,M,L
      urgency.uda.effort.L.coefficient=5.0
      urgency.uda.effort.M.coefficient=3.0
      urgency.uda.effort.H.coefficient=1.0

      # project priority
      urgency.project.college.coefficient=8.0
      urgency.project.work.vido.coefficient=5.0
      urgency.project.work.freela.coefficient=3.0
      urgency.project.personal.coefficient=1.0
    ";
  };
}
