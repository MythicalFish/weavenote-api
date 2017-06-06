class RoleType < ActiveHash::Base
  
  include ToHash

  self.data = [
    {:id => 1, :name => "Viewer"},
    {:id => 2, :name => "Collaborator"},
    {:id => 3, :name => "Manager"},
    {:id => 4, :name => "Admin"}
  ]

  def self.admin
    self.find(4)
  end

end