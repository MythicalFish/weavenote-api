class UsersController < ApplicationController
  
  def show
    render json: {
      user: @user,
      organizations: @user.organizations,
      current_organization: @user.organization,
    }
  end

  private

end
