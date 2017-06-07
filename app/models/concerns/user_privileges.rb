module UserPrivileges
  extend ActiveSupport::Concern
  included do

    def can? action, object
      if object.model_name.name === 'Project'
        role = self.project_role(object)
        return false unless role
        return priv_map[role.type.name][action]
      end
      false
    end

  end

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

end