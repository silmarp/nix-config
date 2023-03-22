{
  programs.taskwarrior = {
    enable = true;
    colorTheme = "solarized-dark-256";
    config = {
      report.next.columns=[ "id" "start.age" "entry.age" "depends" "priority" "project" "tags" "recur" "scheduled.countdown" "due.relative" "until.remaining" "description" "urgency" ];
      report.next.labels=[ "ID" "Active" "Age" "Deps" "Prio" "Project" "Tag" "Recur" "S" "Due" "Until" "Description" "Urg" ];

      # Contexts
      # TODO refactor contexts
      context.academic.read="+academic or +college or +study";
      context.academic.write="+academic";

      context.work.read="+work or +freelance or +internship";
      context.work.write="+work";

      context.personal.read="+personal";
      context.personal.write="+personal";

      context.free.read="+free or +games";
      context.free.write="+free";
    };

    dataLocation = "/home/silmar/.task";

    extraConfig ="
      # priority coefficient
      urgency.uda.priority.H.coefficient=8.0
      urgency.uda.priority.M.coefficient=5.0
      urgency.uda.priority.L.coefficient=1.0
 
      # project priority
      urgency.user.tag.urgent.coefficient=40.0 #tasks wich leads to more tasks 
      urgency.user.tag.college.coefficient=8.0
      urgency.user.tag.work.coefficient=5.0
      urgency.user.tag.personal.coefficient=1.0

      # custom report completed today
      report.review.description=List of completed tasks today
      report.review.columns=project,description.count
      report.review.labels=Proj,Desc
      report.review.filter=end:today status:completed
    ";
  };
}
