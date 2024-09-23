class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [ :show, :edit, :update, :destroy ]
  before_action :set_users, only: [ :show, :edit, :update ]
  before_action :require_manager, only: [ :new, :edit, :update, :create, :destroy ]
  include Pundit::Authorization
  def index
    if current_user.manager?
      @projects = current_user.created_projects
    elsif current_user.qa?
      redirect_to bugs_path
    else
      redirect_to bugs_path
    end
  end

  def redirect_to_edit
    flash[:notice] = "Edit your project's user allocation area here.."
    redirect_to edit_project_path(params[:id])
  end

  def show
    authorize @project
  end

  def new
    @project = Project.new
  end

  def create
    @project = current_user.created_projects.new(project_params)
    authorize @project

    if @project.save
      @project.users << User.where(id: params[:developer_ids])
      @project.users << User.where(id: params[:qa_ids])

      redirect_to @project, notice: "Project was successfully created."
    else
      render :new
    end
  end

  def destroy
    authorize @project
    if @project.destroy
      flash[:alert]="Project deleted successfully"
      redirect_to projects_path
    else
      flash[:alert]="Project failed to delete"
    end
  end

  def edit
      Rails.logger.info "Editing project: #{@project.id} by user: #{current_user.id}"
  end

  def update
    authorize @project
    if @project.update(project_params)
    @project.users.clear

    if params[:developer_ids].present?
      @project.users << User.where(id: params[:developer_ids])
    end
    if params[:qa_ids].present?
      @project.users << User.where(id: params[:qa_ids])
    end
      redirect_to @project, notice: "Project was successfully updated."
    else
      render :edit
    end
  end

  def set_project
    @project=Project.find(params[:id])
  end

  def set_users
    @qas=@project.qas
    @developers=@project.developers
  end

  def require_manager
    unless current_user.manager?
      flash[:alert] = "Only managers have these rights."
      redirect_to root_path
    end
  end

  private
  def project_params
    params.require(:project).permit(:title, :description, :status)
  end
end
