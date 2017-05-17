class ProjectsController < ApplicationController
  before_action :authenticate_user!, except: [:public]
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :verify_ownership, only: [:edit, :update]

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
    new_params["project_goals"] = project_params["project_goals"]
        .map{|id| ProjectGoal.new(goal: id)} if project_params["project_goals"]
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
    proj = parse_project_goals(proj)

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
    @filters = filters_from_params
    @projects = Project.apply(@filters)
  end

  def dashboard
    all_projects = Project.published.eager_load(:project_goals).all
    @by_sdg = Project.categorization_by_sdg(all_projects)
    # all_projects.each{|p| p.project_goals.each{|g| @by_sdg[g.goal] += 1} }
    @by_population = []
    @by_time = Hash.new(0)
    @by_location = Hash.new(0)
    all_projects.each{|p| @by_location[p.location] += 1}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :description, :organization_id, :organization, :location, :start_date, :end_date, project_goals: [], filters: {})
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

    def parse_project_goals(params)
      params["project_goals"] = params["project_goals"]
        .map{|id| ProjectGoal.new(project_id: @project.id, goal: id)} if params["project_goals"]
      params
    end

    def filters_from_params
      ProjectFilter.new start_date: params[:start_date], end_date: params[:end_date], legally_formed: params[:legally_formed],
        location: params[:location], population: params[:population], name: params[:name], sustainable_development_goal: params[:sustainable_development_goal]
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
