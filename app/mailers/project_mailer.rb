class ProjectMailer < ApplicationMailer
  default from: "no-reply@example.com" # Change to a valid email

  def updated_Project(project, user, users)
    @project = project
    @user = user
    @users = users
    # mail to: @users.map(&:email), subject: "Project Updated"
    mail(to: "dbutt9600@gmail.com", subject: "Project Updated")
  end
end
