class UsersController < ApplicationController
  
  def show
    render json: {
      user: @user,
      organization: @user.organization,
      organization_role: @user.organization_role.type.attributes,
      organizations: @user.organizations,
    }
  end

  def self.show
    show
  end

  private

end
