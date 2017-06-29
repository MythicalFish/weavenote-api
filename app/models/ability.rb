class Ability

  def initialize(user, roleable)
    return unless roleable
    @user = user
    @roleable = roleable
    @role = @user.role_for(@roleable)
    @role = @user.organization_role unless @role
    raise "No role found for user" unless @role
  end 


  def to? action, target_model = 'Undefined'
    map = model_ability_map[target_model]
    return map[@role.type.name][action]
  end

  private

  def model_ability_map
    abilities = {}
    model_list.each do |model|
      abilities[model] = role_ability_map
    end
    admin_only_models.each do |model|
      abilities[model]['Contributor'] = action_map([0,1,0,0]);
      abilities[model]['Manager'] = action_map([0,1,1,0]);
    end
    abilities['User'] = role_ability_map([1,1,1,1])
    abilities
  end


  def model_list
    [ 
      'Collaborator', 'Component', 'Image', 'Instruction', 'Invite', 
      'Material', 'Measurement', 'Organization', 'Project', 'Supplier', 'User', 'Undefined'
    ]
  end

  def admin_only_models
    [ 
      'Organization', 'Invite', 'Collaborator'
    ]
  end

  def role_ability_map i = nil
    {
      'None' =>         action_map(i || [0,0,0,0]),
      'Guest' =>        action_map(i || [0,1,0,0]),
      'Contributor' =>  action_map(i || [0,1,1,0]),
      'Manager' =>      action_map(i || [1,1,1,1]),
      'Admin' =>        action_map(i || [1,1,1,1])
    }
  end

  def bool i
    i > 0
  end

  def action_map i = [0,0,0,0]
    {
      create:  bool(i[0]),
      read:    bool(i[1]),
      update:  bool(i[2]),
      destroy: bool(i[3]),
    }
  end

end
