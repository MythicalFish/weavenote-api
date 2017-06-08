class UsersController < ApplicationController
  
  def show
    render json: {
      user: @user,
      organizations: @user.organizations,
      current_organization: @user.organization,
      role: @user.org_role.type.attributes
    }
  end

  private

end
