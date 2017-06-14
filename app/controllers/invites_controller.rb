class InvitesController < ApplicationController

  before_action :set_invitable

  def index
    unless @invitable
      raise Exception.new("Missing invitable (project/organization), can't index Invites")
    end
    render json: @invitable.invites.where(accepted: false)
  end

  def create
    able = Ability.new(@user, @invitable)
    if able.to? :create
      @invite = @invitable.invites.new(invite_params)
      if @invite.save
        index
      else
        raise Exception.new(@invite.errors.full_messages.join("\n"))
      end
    else
      raise Exception.new("User lacks ability to invite to #{@invitable.class_name.name}")
    end
  end

  private

  def invite_params
    p = params[:invite]
    p[:role_type_id] = 3
    if params[:as_guest]
      p[:role_type_id] = 2
    end
    p.permit(:email, :name, :role_type_id)
  end

  def set_invitable
    pid = params[:project_id]
    @invitable = @user.projects.find(pid) if pid
    @invitable = @organization unless pid
  end

end
