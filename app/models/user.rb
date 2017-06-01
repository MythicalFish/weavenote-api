class User < ApplicationRecord
  
  has_and_belongs_to_many :organizations
  has_many :projects, through: :organizations

  private


end
