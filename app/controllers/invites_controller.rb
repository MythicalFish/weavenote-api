class InvitesController < ApplicationController

  before_action :set_vars, except: [ :retrieve ]

  def index
    unless @invitable
      raise Exception.new("Missing invitable (project/organization), can't index Invites")
    end
    render json: @invitable.invites.where(accepted: false)
  end

  def retrieve
    @invite = Invite.find_by_key(params['key'])
    render json: @invite
  end

  def accept
    @invite = @invitable.invites.find_by_key(params[:key])
    byebug
    raise Exception.new('Invite not found') unless @invite
  end

  def create
    if @able.to? :create
      @invite = find_or_create
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

  def find_or_create
    invite = @invitable.invites.find_by_email(invite_params[:email])
    if invite
      if invite.accepted
        if @invitable.collaborators.find_by_email(invite_params[:email])
          validation_error "User already added"
        else
          invite.update(accepted: false)
        end
      end
      invite.update(invite_params)
      invite.send_email
      return invite
    else
      return @invitable.invites.new(invite_params) 
    end
  end

  def invite_params
    p = params[:invite]
    p[:role_type_id] = 3
    if params[:as_guest]
      p[:role_type_id] = 2
    end
    p.permit(:email, :name, :role_type_id)
  end

  def set_vars
    pid = params[:project_id]
    @invitable = @user.projects.find(pid) if pid
    @invitable = @organization unless pid
    @able = Ability.new(@user, @invitable)
  end

end
