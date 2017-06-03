class OrganizationsController < ApplicationController
  
  before_action :set_organization, only: [:update, :destroy]

  # POST /organizations
  def create
    @organization = @user.organizations.new(organization_params)
    if @organization.save
      render json: @organization, status: :created
    else
      render json: @organization.errors.full_messages.join(', '), status: :unprocessable_entity
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
    params.require(:organization).permit(:quantity, :material_id)
  end

end
