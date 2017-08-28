class ApplicationController < ActionController::API
  
  include ApiResponse
  include Serializer

  include InitializeAuth0
  include InitializeUser
  include CheckAbility

  before_action :initialize_user!
  before_action :check_ability!

  def root
    render json: {}
  end

  def global_data
    render json: {
      stages: DevelopmentStage.all,
      colors: Color.all.order('name ASC'),
      materialTypes: MaterialType.all.order('name ASC'),
      currencies: Currency.all,
      careLabels: CareLabel.all,
      roleTypes: RoleType.permitted.map { |rt| rt.attributes },
    }
  end

end
