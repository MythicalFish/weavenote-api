# frozen_string_literal: true
module Invitable
  extend ActiveSupport::Concern
  included do
    
    def set_invitable
      invitable_class = Object.const_get(params[:invitable][:type])
      collection = invitable_class.model_name.collection
      @invitable = @user.send(collection).find(params[:invitable][:id])
      unless @invitable
        raise "Missing invitable (project/organization)"
      end
      @ability = Ability.new(@user, @invitable)
    end

  end
end