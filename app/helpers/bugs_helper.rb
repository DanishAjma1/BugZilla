module BugsHelper
  def status_options(bug_type)
    if bug_type == "feature"
      [ [ "New", "New" ], [ "Started", "Started" ], [ "Completed", "Complete" ] ]
    elsif bug_type == "bug"
      [ [ "New", "New" ], [ "Started", "Started" ], [ "Resolved", "Resolved" ] ]
    else
      []
    end
  end
end
