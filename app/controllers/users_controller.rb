class UsersController < ApplicationController
  
  def show
    render json: @user
  end

  def update
    @user.update!(user_params)
    render_success "Profile updated", @user
  end

  def reset_password
    p = auth0.change_password @user.email, nil
    if p
      render_success p
    else
      render_fatal "Something went wrong, unable to reset password"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end

end
