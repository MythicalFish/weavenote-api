class RoleType < ActiveHash::Base
  
  self.data = [
    {:id => 1, :name => "None"},
    {:id => 2, :name => "Guest"},
    {:id => 3, :name => "Editor"},
    {:id => 4, :name => "Manager"},
    {:id => 5, :name => "Admin"}
  ]

  def self.none
    self.find(1)
  end

  def self.guest
    self.find(2)
  end

  def self.editor
    self.find(3)
  end

  def self.manager
    self.find(4)
  end

  def self.admin
    self.find(5)
  end

end