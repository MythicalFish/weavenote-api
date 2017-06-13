class User < ApplicationRecord

  include UserAssociations
  include UserPrivileges
  
  def invite
    UserMailer.send_invite().deliver_now
  end

end