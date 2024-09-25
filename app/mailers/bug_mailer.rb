class BugMailer < ApplicationMailer
  default from: "no-reply@example.com" # Change to a valid email

  def bug_assigned(bug, user)
    @bug = bug
    @user = user
    mail(to: "dbutt9600@gmail.com", subject: "Bug Assigned to You")
  end
end
