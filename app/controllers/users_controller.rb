class UsersController < ApiController
  
  def show
    render json: @user
  end

  def update
    @user.update!(user_params)
    render_success "Profile updated", @user
  end

  def verify_email_change
    byebug
    render_success "Please check your inbox to complete the change"
  end

  def change_email

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
    params.require(:user).permit(:name, :username)
  end

end
