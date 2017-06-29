class Ability

  def initialize(user, roleable)
    return unless roleable
    @user = user
    @roleable = roleable
    @role = @user.role_for(@roleable)
    @role = @user.organization_role unless @role
    raise "No role found for user" unless @role
  end 


  def to? action
    return true if @user.is_admin?
    able = priv_map[@role.type.name][action]
    return able if able
    deny("Permission error: Your role for this #{@roleable.class.name} is \"#{@role.type.name}\"")
  end

  def deny msg
    raise CustomException::PermissionError.new(msg)
  end


  private

  def priv_map
    {
      'None' =>         actions(0,0,0,0),
      'Guest' =>        actions(0,1,0,0),
      'Contributor' =>  actions(0,1,1,0),
      'Manager' =>      actions(1,1,1,1),
      'Admin' =>        actions(1,1,1,1)
    }
  end

  def bool i
    i > 0
  end

  def actions c, r, u, d
    {
      create:  bool(c),
      read:    bool(r),
      update:  bool(u),
      destroy: bool(d),
    }
  end

end
