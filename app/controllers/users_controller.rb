class UsersController < ApplicationController
  
  def show
    render json: {
      user: @user,
      organization: @user.organization,
      organization_role: @user.organization_role.type.attributes,
      organizations: @user.organizations,
      abilities: @ability.list
    }
  end

  def self.show() show end

  def update
    @user.update!(user_params)
    render_success "Profile updated", @user
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end

end
