# frozen_string_literal: true
module CheckAbility
  
  extend ActiveSupport::Concern

  def check_ability! action = nil, target_model = nil
    @action = action || action_name.to_sym
    return unless Ability::ALL_ACTIONS.include? @action
    @target = target_model || controller_name.classify
    @roleable = @project || @organization
    @ability = Ability.new(@user, @roleable)
    unless @ability.to? @action, @target
      msg = "You don't have permission to #{@action} this #{@target}"
      render_denied(msg)
    end
  end
  
end