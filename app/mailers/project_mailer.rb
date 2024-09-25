class ProjectMailer < ApplicationMailer
  default from: "no-reply@example.com" # Change to a valid email

  def updated_project(project, user, user_ids)
    @project = project
    @user = user
    @users = User.where(id: user_ids)  # Fetch the users using the IDs
    # mail(to: @users.pluck(:email), subject: "Project Updated: #{@project.title}")
    mail(to: "dbutt9600@gmail.com", subject: "Project Updated")
  end
end
