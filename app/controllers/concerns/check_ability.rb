# frozen_string_literal: true
module CheckAbility
  
  extend ActiveSupport::Concern

  def check_ability!
    action = action_name.to_sym
    return unless Ability::ALL_ACTIONS.include? action
    ability_check! action
  end
  
  def ability_check! action, target = nil
    @ability = Ability.new(@user, roleable)
    t = target ? target.to_s : target_model
    unless @ability.to? action, t
      msg = "You don't have permission to #{action} this #{t}"
      render_denied(msg)
    end
  end

  def roleable
    case target_model
    when 'Project'
      return @project if @project
    when 'Annotation'
      return @annotatable.project if @annotatable
    else
      return @organization
    end
    @organization
  end

  def target_model
    controller_name.classify
  end

end