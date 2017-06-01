class Role < ActiveHash::Base
  self.data = [
    {:id => 1, :name => "Admin"},
    {:id => 2, :name => "Manager"},
    {:id => 3, :name => "Collaborator"},
    {:id => 4, :name => "Viewer"}
  ]
end