class BugsController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_project, only: [ :new, :create, :destroy, :edit, :update, :assign_bug_to_self, :remove_developer ]
  before_action :set_bug, only: [ :show, :edit, :update, :destroy, :assign_bug_to_self, :remove_developer ]
  def index
    if is_qa?
  @projects = Project.all
  render "projects/index"
    elsif is_developer?
  @projects = current_user.assigned_projects
  render "projects/index"
    else
  @projects = Project.none
  redirect_to root_path
    end
  end

  def assigned
    @bugs=current_user.bugs
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

   # debugger
   if !@project.bugs.where(title: @bug.title).exists?
    # Validate the image extension before proceeding to save the bug
    if image_extension_valid?
      if @bug.save
        flash[:notice] = "#{@bug.bug_type.capitalize} created successfully."
        redirect_to @project
      else
        flash[:alert] = "There was an error saving the #{@bug.bug_type}."
        render "new_#{@bug.bug_type}"
      end
    else
      flash[:alert] = "Image must be a PNG or GIF file."
      redirect_to new_project_bug_path(@project, type: @bug.bug_type) and return
    end
   else
      flash[:alert] = "A bug with this title already exists in this project."
      redirect_to new_project_bug_path(@project, type: @bug.bug_type)
   end
  end


  def assign_bug_to_self
    authorize @bug
    if !@bug.users.exists?(current_user.id)
      @bug.users << current_user
      BugMailer.bug_assigned(@bug, current_user).deliver_later

      redirect_to @project, notice: "Bug assigned to you successfully."
    else
      redirect_to @project, alert: "You cannot assign this bug."
    end
  end

  def remove_developer
    authorize @bug
    developer = @bug.users.find(params[:developer_id])
    if developer.id == current_user.id
    @bug.users.delete(params[:developer_id])
    flash[:notice] = "Developer removed successfully."
    else
    flash[:alert] = "You can't remove any other developer.."
    end

    redirect_to @project
  end

  def destroy
    authorize @bug
    if @bug.destroy
      flash[:alert]= "#{@bug.bug_type} deleted successfully"
      redirect_to @project
    else
      flash[:alert]="#{@bug.bug_type} failed to delete"
    end
  end

  def edit
    # @developers=@bug.users
  end

  def update
    authorize @bug
    if @bug.update(bug_params)
      flash[:alert]="#{@bug.bug_type} updated successcfully.."
      redirect_to projects_path
    else
      flash[:alert]="#{@bug.bug_type} failed to updated .."
    end
  end

  def unique_title_within_project(title)
    if project.bugs.where(title: title).exists?
      true
    end
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_bug
    @bug=Bug.find(params[:id])
  end

  def image_extension_valid?
    return true unless params[:bug][:image].present?

    allowed_extensions = %w[png gif]
    uploaded_file = params[:bug][:image]
    file_extension = File.extname(uploaded_file.original_filename).delete(".").downcase

    allowed_extensions.include?(file_extension)
  end

  def is_qa?
    current_user.qa?
  end

  def is_developer?
    current_user.developer?
  end

  def bug_params
    params.require(:bug).permit(:title, :description, :bug_type, :deadline, :status, :image)
  end
end
