class OrganizationsController < ApplicationController
  
  before_action :set_organization, only: [:update, :destroy]

  # POST /organizations
  def create
    begin
      
      o = Organization.create(org_params)
      o.roles.create(admin_role)
      @user.update(current_organization: o)

      render json: {
        organizations: @user.organizations,
        current_organization: o
      }

    rescue => e
      render json: e.message, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /organizations/:id
  def update
    if @organization.update(org_params)
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

  def org_params
    params.require(:organization).permit(:name)
  end

  def admin_role
    {
      user: @user,
      role_type: RoleType.admin
    }
  end

end
