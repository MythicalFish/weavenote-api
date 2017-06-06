class RoleType < ApplicationRecord

  def self.viewer
    self.find(1)
  end

  def self.collaborator
    self.find(2)
  end

  def self.manager
    self.find(3)
  end

  def self.admin
    self.find(4)
  end

end