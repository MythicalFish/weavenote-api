class Ability

  ACTION_NAMES = [ :create, :read, :update, :destroy ]

  MODELS = [ 
    'Collaborator', 'Component', 'Image', 'Instruction', 'Invite', 
    'Material', 'Measurement', 'Organization', 'Project', 'Supplier', 'User', 'Undefined'
  ]

  RESTRICTED_MODELS = [ 'Invite', 'Collaborator' ]

  def initialize(user, roleable)
    return unless roleable
    @user = user
    @roleable = roleable
    @role = @user.role_for(@roleable) || @user.organization_role
  end 


  def to? action, target_model = 'Undefined'
    role = @role || Role.none
    map = ability_map[target_model]
    return map[role.type.name][action]
  end

  def ability_map
    abilities = base_model_ability_map
    abilities['User'] = grant_roles :all_actions
    abilities['Organization'] = grant_roles [:create]
    abilities['Invite'] = grant_roles [:read]
    abilities
  end

  def base_model_ability_map
    abilities = generic_model_ability_map
    RESTRICTED_MODELS.each do |m|
      abilities[m]['Contributor'] = grant([:read]);
      abilities[m]['Manager'] = grant([:read,:update]);
    end
    abilities
  end

  def generic_model_ability_map
    MODELS.map { |m| [ m, role_ability_map ] }.to_h
  end

  def parseActionNames actions = []
    actions = ACTION_NAMES if actions == :all_actions
    ACTION_NAMES.map { |n| actions.include?(n) ? 1 : 0 }
  end

  def grant actions = []
    action_map(parseActionNames(actions))
  end

  def grant_roles actions = []
    role_ability_map(actions, false)
  end

  def role_ability_map overides = nil, only = true
    abilities = default_role_abilities
    return abilities unless overides
    abilities.each do |role,actions|
      if only
        abilities[role] = parseActionNames(overides)
      else
        overides = ACTION_NAMES if overides == :all_actions
        overides.each do |action, permission|
          abilities[role][action] = true
        end
      end
    end
    abilities
  end

  def bool i
    (i > 0)
  end

  def action_map i = [0,0,0,0]
    {
      create:  bool(i[0]),
      read:    bool(i[1]),
      update:  bool(i[2]),
      destroy: bool(i[3]),
    }
  end

  def default_role_abilities
    {
      'None' =>         grant([]),
      'Guest' =>        grant([:read]),
      'Contributor' =>  grant([:read, :update]),
      'Manager' =>      grant(:all_actions),
      'Admin' =>        grant(:all_actions)
    }
  end

end
