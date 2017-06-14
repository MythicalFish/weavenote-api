class Invite < ApplicationRecord

  belongs_to :invitable, polymorphic: true

  before_create :generate_key
  after_create :send_invite

  def send_invite
    email = UserMailer.send_invite(self)
    email.deliver_now
  end

  def invite_link
    "http://#{ENV['SEAMLESS__DOMAIN']}/?invitation=#{self.key}"
  end

  private

  def generate_key
    begin
      key = SecureRandom.hex(8).upcase
    end while Object.const_get(self.model_name.human).where(:key => key).exists?
    self.key = key
  end

end