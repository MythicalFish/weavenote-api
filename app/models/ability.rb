class Ability

  def initialize(user, roleable = nil)
    @user = user
    @roleable = roleable
    @role_type = @user.role_type_for(@roleable) || @user.organization_role_type || RoleType.none
  end

  MODELS = [ 
    'Role', 'Component', 'Image', 'Instruction', 'Invite', 'Comment', 'Annotation',
    'Material', 'Measurement', 'Organization', 'Project', 'Supplier', 'User', 'SpecSheet', 'Undefined'
  ]

  ALL_ACTIONS = [:index, :show, :create, :update, :destroy]

  # IDs as defined in the RoleType model
  NONE = 1
  GUEST = 2
  MEMBER = 3
  MANAGER = 4
  ADMIN = 5

  DEFAULT_ABILITIES = {
    NONE => [],
    GUEST => [:index, :show],
    MEMBER => [:index, :show, :update],
    MANAGER => ALL_ACTIONS,
    ADMIN => ALL_ACTIONS
  }

  def abilities
    
    # Create an object which defines generic
    # permissions for each model/role/action,
    # based on the above constants:
    a = MODELS.map { |m| [ m, DEFAULT_ABILITIES.dup ] }.to_h

    # Deny all if model is undefined
    a['Undefined'] = deny_all

    # User actions always on self, so grant all
    a['User'] = grant_all ALL_ACTIONS

    # Any user can create an Organization
    a['Organization'] = grant_all_only [:create]

    # Only Admin can manage Organization:
    a['Organization'][ADMIN] = ALL_ACTIONS

    # Loosen restrictions for these models, since their
    # controllers determines abilities for these:
    a['Comment'] = grant_all ALL_ACTIONS
    a['Annotation'] = grant_all ALL_ACTIONS
    #a['Comment'] = grant_all_only [:index, :show, :create]
    #a['Annotation'] = grant_all_only [:index, :show, :create]
    #a['Comment'][ADMIN] = [:index, :show, :create, :destroy]
    #a['Annotation'][ADMIN] = [:index, :show, :create, :destroy]
    #a['Comment'][MEMBER] = [:index, :show, :create, :destroy]
    #a['Annotation'][MEMBER] = [:index, :show, :create, :destroy]

    # Any user see list of Projects
    a['Project'] = grant_all [:index]

    # Permit guests to export PDF
    a['SpecSheet'][GUEST] = ALL_ACTIONS

    # Permit certain model actions for Team Member:
    a['Image'][MEMBER] = ALL_ACTIONS
    a['Component'][MEMBER] = ALL_ACTIONS
    a['Measurement'][MEMBER] = ALL_ACTIONS
    a['Instruction'][MEMBER] = ALL_ACTIONS
    a['SpecSheet'][MEMBER] = ALL_ACTIONS
    a['Role'][MEMBER] = [:show]
    
    # Temporary fix for showing a material to project guests
    a['Material'] = grant_all [:show]
    
    a
  end

  def user_abilities
    abilities.map { |model,abilities|
      [model, abilities[@role_type.id]]
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
    DEFAULT_ABILITIES.dup.map { |role_id, defaults|
      abilities = defaults.dup
      new_abilities.each do |a|
        unless defaults.include? a
          abilities << a
        end
      end
      [role_id, abilities]
    }.to_h
  end

  def grant_all_only new_abilities
    DEFAULT_ABILITIES.dup.map { |role_id, defaults|
      [role_id, new_abilities]
    }.to_h
  end

  def deny_all
    grant_all_only []
  end

end
