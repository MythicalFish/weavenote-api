module PayolaConcerns
  extend ActiveSupport::Concern
  included do

    def payola_can_modify_subscription?(subscription)
      subscription.owner.is_admin?
    end

  end
end