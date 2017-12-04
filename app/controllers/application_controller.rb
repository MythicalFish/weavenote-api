class ApplicationController < ActionController::Base
  protect_from_forgery
  include PayolaConcerns
  include RescueWithRedirect
  include ApplicationHelper
  include InitializeAuth0
  include InitializeUser
  include CheckAbility
  before_action :initialize_user!
end
