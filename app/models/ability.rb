class Ability

  def initialize(user, roleable = nil)
    @user = user
    @roleable = roleable
    @role_type = @user.role_type_for(@roleable) || @user.organization_role_type || RoleType.none
  end

  MODELS = [ 
    'Role', 'Component', 'Image', 'Instruction', 'Invite', 'Comment', 'Annotation',
    'Material', 'Measurement', 'Organization', 'Project', 'Supplier', 'User', 'Undefined'
  ]

  ALL_ACTIONS = [:index, :show, :create, :update, :destroy]

  DEFAULT_ABILITIES = {
    'None' => [:index],
    'Guest' => [:index, :show],
    'Contributor' => [:index, :show, :update],
    'Manager' => ALL_ACTIONS,
    'Admin' => ALL_ACTIONS
  }

  def abilities
    
    # Create an object which defines generic
    # permissions for each model/role/action,
    # based on the above constants:
    a = MODELS.map { |m| [ m, DEFAULT_ABILITIES.dup ] }.to_h

    # Deny everything if model is undefined:
    a['Undefined'] = grant_all_only []

    # Some models are tied to the user, and
    # have restrictions implemented elsewhere,
    # so we permit actions on these models:
    a['User'] = grant_all ALL_ACTIONS
    a['Annotation'] = grant_all ALL_ACTIONS
    a['Comment'] = grant_all ALL_ACTIONS
    a['Invite'] = grant_all [:show]
    a['Organization'] = grant_all_only [:create]

    # Only Admin can manage Organization:
    a['Organization']['Admin'] = ALL_ACTIONS

    # Permit certain model actions for Contributor:
    a['Image']['Contributor'] = ALL_ACTIONS
    a['Invite']['Contributor'] = [:show]
    a['Role']['Contributor'] = [:show]
    
    a
  end

  def user_abilities
    abilities.map { |model,abilities|
      [model, abilities[@role_type.name]]
    }.to_h
  end

  def list
    user_abilities.map { |model,actions|
      a = ALL_ACTIONS.map { |aa|
        [aa,actions.include?(aa)]
      }.to_h
      [model, a]
    }.to_h
  end

  def to? action, target_model = 'Undefined'
    throw "Model abilities not defined, aborting" unless MODELS.include?(target_model)
    return true if user_abilities[target_model].include? action
    rn = @user.organization_role_type.try(:name).to_s
    rna = abilities[target_model][rn] || []
    return rna.include? action
  end

  def grant_all new_abilities
    DEFAULT_ABILITIES.dup.map { |role,defaults|
      abilities = defaults.dup
      new_abilities.each do |a|
        unless defaults.include? a
          abilities << a
        end
      end
      [role,abilities]
    }.to_h
  end

  def grant_all_only new_abilities
    DEFAULT_ABILITIES.dup.map { |role,defaults|
      [role,new_abilities]
    }.to_h
  end

end
