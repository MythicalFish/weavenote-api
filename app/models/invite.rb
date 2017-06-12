class Invite < ApplicationRecord

  belongs_to :invitable, polymorphic: true

  before_create :generate_key
  after_create :send_invite

  def send_invite

  end

  private

  def generate_key
    begin
      key = SecureRandom.hex(8).upcase
    end while Object.const_get(self.model_name.human).where(:key => key).exists?
    self.key = secure_id
  end

end