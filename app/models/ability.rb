class Ability

  def initialize(user, roleable = nil)
    @user = user
    @roleable = roleable
    @role_type = @user.role_type_for(@roleable) || @user.organization_role_type || RoleType.none
  end

  MODELS = [ 
    'Role', 'Component', 'Image', 'Instruction', 'Invite', 'Comment',
    'Material', 'Measurement', 'Organization', 'Project', 'Supplier', 'User', 'Undefined'
  ]

  ALL_ACTIONS = [:create, :read, :update, :destroy]

  DEFAULT_ABILITIES = {
    'None' => [],
    'Guest' => [:read],
    'Contributor' => [:read, :update],
    'Manager' => ALL_ACTIONS,
    'Admin' => ALL_ACTIONS
  }

  def base_abilities
    MODELS.map { |m| [ m, DEFAULT_ABILITIES.dup ] }.to_h
  end

  def abilities
    a = base_abilities
    a['Undefined'] = grant_all_only []
    a['User'] = grant_all ALL_ACTIONS
    a['Comment'] = grant_all ALL_ACTIONS
    a['Invite'] = grant_all [:read]
    a['Organization'] = grant_all_only [:create]
    a['Organization']['Admin'] = ALL_ACTIONS
    a['Image']['Contributor'] = ALL_ACTIONS
    a['Invite']['Contributor'] = [:read]
    a['Role']['Contributor'] = [:read]
    a['Invite']['Manager'] = [:read, :update]
    a['Role']['Manager'] = [:read, :update]
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
    return true if abilities[target_model][@user.organization_role_type.name].include? action
    false
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
