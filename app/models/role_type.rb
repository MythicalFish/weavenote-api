class RoleType < ActiveHash::Base
  
  self.data = [
    {:id => 1, :name => "None"},
    {:id => 2, :name => "Guest"},
    {:id => 3, :name => "Team member"},
    {:id => 4, :name => "Manager"},
    {:id => 5, :name => "Admin"}
  ]

  EXPOSED_IDS = [2,3,5]

  def self.exposed
    # Role types which are visible
    find(EXPOSED_IDS)
  end

  def self.none
    # Default role type for org (used when user is only invited to project)
    self.find(1)
  end

  def self.guest
    self.find(2)
  end

  def self.member
    self.find(3)
  end

  def self.manager
    self.find(4)
  end

  def self.admin
    self.find(5)
  end

end