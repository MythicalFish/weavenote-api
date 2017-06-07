class UsersController < ApplicationController
  
  before_action :set_supplier, only: [:destroy]

  def show
    render json: {
      user: @user,
      organizations: @user.organizations,
      current_organization: @user.organization,
    }
  end

  private

end
