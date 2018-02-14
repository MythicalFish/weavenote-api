class Invite < ApplicationRecord

  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :inviter, class_name: 'User'
  belongs_to :invitable, polymorphic: true
  belongs_to :role_type
  before_create :generate_key

  def send_email
    email = UserMailer.send_invite(self)
    email.deliver_now
  end

  def invite_link
    domain = ENV['SITE_URL']
    "#{domain}/?invitation=#{self.key}"
  end

  private

  def generate_key
    begin
      key = SecureRandom.hex(8).upcase
    end while Invite.where(:key => key).exists?
    self.key = key
  end

end