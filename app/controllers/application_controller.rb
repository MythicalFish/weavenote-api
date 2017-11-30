class ApplicationController < ActionController::Base
  protect_from_forgery
  include RenderRedirect
  include ApplicationHelper
  include InitializeAuth0
  include InitializeUser
  include CheckAbility
  before_action :initialize_user!
end
