class User < ApplicationRecord

  include UserAssociations
  include RoleMethods
  require "letter_avatar/has_avatar"
  include LetterAvatar::HasAvatar
  validates_uniqueness_of :email

  before_create :set_username

  def abilities
    abilities = Ability.new(self,organization)
    abilities.list
  end

  def avatar
    "#{ENV['WEAVENOTE__API_URL']}#{self.avatar_url}"
  end

  private

  def set_username
    username = self.email.split('@')[0]
    return self.username = username unless username_exists?(username)
    i = 2
    begin
      un = "#{username}-#{i}"
      i += 1
    end while username_exists?(un)
    self.username = un
  end

  def username_exists? username
    User.where(username: username).exists?
  end

end