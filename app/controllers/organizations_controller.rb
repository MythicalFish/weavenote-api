class OrganizationsController < ApplicationController
  
  before_action :set_organization, only: [:update, :destroy]

  # POST /organizations
  def create
    begin
      @org = Organization.create(organization_params)
      @role = Role.create({
        user: @user,
        organization: @org,
        role_type: RoleType.admin
      })
      orgs = @user.organizations.order('id DESC')
      render json: {
        organizations: orgs,
        current_organization: @org
      }
    rescue => e
      render json: e.message, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /organizations/:id
  def update
    if @organization.update(organization_params)
      render json: @organization
    else
      render json: @organization.errors, status: :unprocessable_entity
    end
  end

  # DELETE /organizations/:id
  def destroy
    @organization.destroy
    index
  end

  private

  def set_organization
    @organization = @user.organizations.find(params[:id])
  end

  def organization_params
    params.require(:organization).permit(:name)
  end

end
