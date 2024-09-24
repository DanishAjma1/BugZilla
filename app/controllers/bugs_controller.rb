class BugsController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_project, only: [ :new, :create, :destroy, :edit, :update, :assign_bug_to_self, :remove_developer ]
  before_action :set_bug, only: [ :show, :edit, :update, :destroy, :assign_bug_to_self, :remove_developer ]
  def index
    if current_user.qa?
      @projects=Project.all
      render "projects/index"

    elsif current_user.developer?
      @projects = current_user.assigned_projects
      render "projects/index"
    else
      @projects=Project.none
      redirect_to root_path
    end
  end

  def show
  end

  def new
    @bug = @project.bugs.new
    @bug.bug_type = params[:type] if params[:type].present?

    if @bug.bug_type == "feature"
      render "new_feature"
    elsif @bug.bug_type == "bug"
      render "new_bug"
    end
  end

  def create
    @bug = @project.bugs.new(bug_params)
    @bug.creator_id = current_user.id
    authorize @bug
    if @bug.save
      flash[:alert]="bug created successfully"
      redirect_to @project
    else
      render "new"
    end
  end

  def remove_developer
    developer = @bug.users.find(params[:developer_id])

    if developer
    @bug.users.delete(params[:developer_id])
    flash[:notice] = "Developer removed successfully."
    else
    flash[:alert] = "Developer not found."
    end

    redirect_to @project
  end

  def assign_bug_to_self
    # Assuming a join table between bug and developers (developers_bugs)
    if current_user.developer? && !@bug.users.exists?(current_user.id)
      @bug.users << current_user
      redirect_to @project, notice: "Bug assigned to you successfully."
    else
      redirect_to project_bug_path(@project, @bug), alert: "You cannot assign this bug."
    end
  end
  def destroy
    authorize @bug
    if @bug.destroy
      flash[:alert]="bug deleted successfully"
      redirect_to @project
    else
      flash[:alert]="bug failed to delete"
    end
  end

  def edit
    # @developers=@bug.users
  end

  def update
    authorize @bug
    if @bug.update(bug_params)
      flash[:alert]="bug updated.."
      redirect_to projects_path
    else
      flash[:alert]="bug updated successcfully.."
    end
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_bug
    @bug=Bug.find(params[:id])
  end

  def bug_params
    params.require(:bug).permit(:title, :description, :bug_type, :deadline, :status, :image)
  end
end
