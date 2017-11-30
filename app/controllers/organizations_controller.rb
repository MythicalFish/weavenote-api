class OrganizationsController < ApiController
  
  before_action :set_organization, only: [:update, :destroy]
  
  before_action :check_ability!

  def create 
    @organization = Organization.create!(org_params)
    @organization.roles.create!(admin_role)
    @user.update!(organization: @organization)
    @ability = Ability.new(@user, @organization)
    render_success(
      "#{@organization.name} was succesfully created", 
      serialized(@user)
    )
  end

  def update
    @organization.update!(org_params)
    render_success "Organization updated", @organization
  end

  def destroy
    @organization.destroy!
    index
  end

  def switch_organization
    o = @user.organizations.find(params[:id])
    @user.update!(organization: o)
    render_success "You are now using #{o.name}", serialized(@user)
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
