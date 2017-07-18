# frozen_string_literal: true
module CheckAbility
  
  extend ActiveSupport::Concern

  def check_ability!
    @ability = Ability.new(@user, roleable)
    action = action_name.to_sym
    if [:index, :show].include? action
      ability_check! :read, target_model
    elsif [:update].include? action
      ability_check! :update, target_model
    elsif [:create, :destroy].include? action
      ability_check! :create, target_model
    end
  end

  def ability_check! action, object_name = nil
    unless @ability.to? action, object_name
      msg = "You don't have permission to #{action} this"
      msg += " #{object_name}" if object_name
      render_denied(msg)
    end
  end

  def target_model
    controller_name.classify
  end

  def roleable
    return @project if @project && target_model == Project
    @organization
  end

end