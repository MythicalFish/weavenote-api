# frozen_string_literal: true
module CheckAbility
  
  extend ActiveSupport::Concern

  included do
    before_action :set_ability
    before_action :authorize_crud_actions!
  end

  def set_ability
    @ability = Ability.new(@user, roleable)
  end

  def ability_check! action, object = nil
    unless @ability.to? action, object
      msg = "You don't have permission to #{action} this"
      msg += " #{object.class.name}" if object
      render_error(msg)
    end
  end

  def authorize_crud_actions!
    action = action_name.to_sym
    if [:index, :show].include? action
      ability_check! :read, target_model
    elsif [:update].include? action
      ability_check! :update, target_model
    elsif [:create, :destroy].include? action
      ability_check! :create, target_model
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