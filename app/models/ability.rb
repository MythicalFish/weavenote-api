class Ability

  def initialize(user, object)
    @user = user
    @role = role_for_object(object)
    raise "No role found for user" unless @role
  end 


  def to? action
    return priv_map[@role.type.name][action]
  end


  private

  def priv_map
    {
      'None' =>    actions(0,0,0,0),
      'Viewer' =>  actions(0,1,0,0),
      'Editor' =>  actions(0,1,1,0),
      'Manager' => actions(1,1,1,1),
      'Admin' =>   actions(1,1,1,1)
    }
  end

  def bool i
    i > 0
  end

  def actions c, r, u, d
    {
      create: bool(c),
      read:   bool(r),
      update: bool(u),
      delete: bool(d),
    }
  end

  def class_name object
    object.model_name.name
  end

  def role_for_object object
    klass = class_name(object)
    if klass === 'Project'
      return @user.project_role(object)
    elsif klass === 'Organization'
      return @user.org_role
    end
  end

end
