module BugsHelper
  def status_options(bug_type)
    if bug_type == "feature"
      [ [ "New", "new" ], [ "Started", "started" ], [ "Completed", "complete" ] ]
    elsif bug_type == "bug"
      [ [ "New", "new" ], [ "Started", "started" ], [ "Resolved", "resolved" ] ]
    else
      []
    end
  end
end
