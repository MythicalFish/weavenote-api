class User < ApplicationRecord
# Added by Koudoku.
  has_one :subscription


  include UserAssociations
  include RoleMethods
  require "letter_avatar/has_avatar"
  include LetterAvatar::HasAvatar
  validates_uniqueness_of :email
  validates :name, length: { minimum: 2 }
  validate :username_is_valid

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
    # Method for automatically creating a unique username
    # on user creation.
    username = self.email.split('@')[0].gsub('.','')
    return self.username = username unless username_exists?(username)
    i = 2
    begin
      un = "#{username}-#{i}"
      i += 1
    end while username_exists?(un)
    self.username = un
  end

  def username_is_valid
    if username.length < 2
      errors.add(:username, ' must be at least 2 chars')
    elsif username_exists?(username)
      errors.add(:username, ' is taken')
    end
  end

  def username_exists? username
    User.where('username = ? AND id != ?', username, id).exists?
  end

end