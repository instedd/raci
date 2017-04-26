class OrganizationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_organization, only: [:show, :edit, :update, :destroy]
  before_action :verify_ownership, only: [:edit, :update]
  before_action :authorize_user, only: :index

  # GET /organizations
  # GET /organizations.json
  def index
    @organizations = Organization.order('accepted DESC')
  end

  # GET /organizations/1
  # GET /organizations/1.json
  def show
  end

  # GET /organizations/1/edit
  def edit
  end

  # POST /organizations
  # POST /organizations.json
  def create
    @organization = Organization.new(organization_params)

    respond_to do |format|
      if @organization.save
        format.html { redirect_to @organization, notice: 'Organization was successfully created.' }
        format.json { render :show, status: :created, location: @organization }
      else
        format.html { render :new }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /organizations/1
  # PATCH/PUT /organizations/1.json
  def update
    org = set_acceptance_status
    respond_to do |format|
      if @organization.update(org)
        format.html { redirect_to edit_organization_path(@organization), notice: 'Se actualizó la organización' }
        format.json { render :show, status: :ok, location: @organization }
      else
        format.html { render :edit }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organizations/1
  # DELETE /organizations/1.json
  def destroy
    @organization.destroy
    respond_to do |format|
      format.html { redirect_to organizations_url, notice: 'Organization was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization
      @organization = Organization.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def organization_params
      params.require(:organization).permit(:legally_formed, :email, :telephone_number, :name, :twitter, :facebook, :user_id, :user)
    end

    def set_acceptance_status
      org = organization_params
      if params[:commit] == "Dar de alta"
        org[:accepted] = true
      elsif params[:commit] == "Ocultar al público"
        org[:accepted] = false
      end
      org
    end

    def verify_ownership
      if current_user.organization != @organization
        head :forbidden
      end
    end
end
