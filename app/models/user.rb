class User < ApplicationRecord

  include UserAssociations
  include UserPrivileges

end