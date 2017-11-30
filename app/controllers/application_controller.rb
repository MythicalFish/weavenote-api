class ApplicationController < ActionController::API
  
  include ApiResponse
  include Serializer

  include InitializeAuth0
  include InitializeUser
  include CheckAbility
  include Notify
  
  before_action :initialize_user!

  def root
    render json: {}
  end

  def global_data
    render json: {
      colors: Color.all.order('name ASC'),
      materialTypes: MaterialType.all.order('name ASC'),
      currencies: Currency.all,
      careLabels: CareLabel.all,
      unitTypes: UnitType.all.map { |ut| ut.attributes },
    }
  end

end
