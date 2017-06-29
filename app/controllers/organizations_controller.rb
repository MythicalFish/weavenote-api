class OrganizationsController < ApplicationController
  
  before_action :set_organization, only: [:update, :destroy]

  def create 
    o = Organization.create!(org_params)
    o.roles.create!(admin_role)
    user.update!(organization: o)
    role = @user.organization_role
    ability = Ability.new(user, role)
    render_success(
      "#{o.name} was succesfully created", 
      {
        organization: o,
        organization_role: role.type.attributes,
        organizations: user.organizations,
        abilities: ability.list,
      }
    )
  end

  def update
    @organization.update!(org_params)
    render json: @organization
  end

  def destroy
    @organization.destroy!
    index
  end


  def stats
    @projects = @organization.projects.active
    response = {
      projects: {
        counts: {
          active: @projects.length,
          recently_active: @projects.where(updated_at: (Time.now - 1.day)..Time.now).length,
          by_stage: []
        },
      }
    }
    DevelopmentStage.all.each do |s|
      stage_count = @projects.where(development_stage_id: s.id).length
      response[:projects][:counts][:by_stage] <<
        { label: s.label, count: stage_count }
    end
    render json: response
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
