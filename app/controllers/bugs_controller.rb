class BugsController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_project, only: [ :new, :create, :destroy, :edit, :update ]
  before_action :set_bug, only: [ :show, :edit, :update, :destroy ]
  def index
    if current_user.qa?
      @project=Project.all
      render "projects/index"

    else
      @projects = current_user.assigned_projects
      render "projects/index"
    end
  end

  def show
  end

  def new
    @bug = @project.bugs.new
    @bug.bug_type = params[:type] if params[:type].present?  # Set the type based on the parameter

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
    params.require(:bug).permit(policy(@bug).permitted_attributes)
  end
end
