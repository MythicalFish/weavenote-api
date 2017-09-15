class User < ApplicationRecord

  include UserAssociations
  include RoleMethods
  require "letter_avatar/has_avatar"
  include LetterAvatar::HasAvatar
  validates_uniqueness_of :email

  def abilities
    abilities = Ability.new(self,organization)
    abilities.list
  end

  def avatar
    "#{ENV['WEAVENOTE__API_URL']}#{self.avatar_url}"
  end

end