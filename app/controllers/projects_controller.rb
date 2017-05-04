class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :verify_ownership, only: [:edit, :update]
  before_action :verify_organization, except: :show

  # GET /projects
  # GET /projects.json
  def index
    @projects = if current_user.is_admin
        Project.order('published DESC')
      else
        Project.where(organization_id: current_user.organization.id)
      end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    new_params = project_params
    new_params["project_goals"] = project_params["project_goals"].map{|id| ProjectGoal.new(goal: id)} if project_params["project_goals"]
    @project = Project.new(new_params)
    @project.organization = current_user.organization

    respond_to do |format|
      if @project.save
        format.html { redirect_to projects_path, notice: 'Se creó el proyecto' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    proj = set_publishing_status
    proj["project_goals"] = proj["project_goals"].select{|id| !@project.for_goal?(id) }
      .map{|id| ProjectGoal.new(project_id: @project.id, goal: id)} if project_params["project_goals"]

    respond_to do |format|
      if @project.update(proj)
        format.html { redirect_to projects_path, notice: 'Se actualizó el proyecto' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Se eliminó el proyecto' }
      format.json { head :no_content }
    end
  end

  def public
    @projects = Project.eager_load(:organization)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :description, :organization_id, :organization, :location, :start_date, :end_date, project_goals: [])
    end

    def set_publishing_status
      pj = project_params
      if params[:commit] == "Publicar"
        pj[:published] = true
      elsif params[:commit] == "Ocultar al público"
        pj[:published] = false
      end
      pj
    end

    def verify_organization
      if !current_user.is_admin && !current_user.organization.accepted
        render 'organizations/not_authorized'
      end
    end

    def verify_ownership
      if !current_user.is_admin && current_user.organization != @project.organization
        head :forbidden
      end
    end
end
