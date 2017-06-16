class InvitesController < ApplicationController

  before_action :set_invitable, except: [ :retrieve, :accept ]
  
  before_action :set_invite, only: [ :retrieve, :accept ]
  skip_before_action :set_user!, only: [ :retrieve ]

  def index
    unless @invitable
      raise Exception.new("Missing invitable (project/organization), can't index Invites")
    end
    render json: @invitable.invites.where(accepted: false)
  end

  def retrieve
    render json: @invite
  end

  def accept
    
    invitable = @invite.invitable
    existing_role = @user.role_for(invitable)

    if existing_role
      existing_role.update(role_type_id: @invite.role_type_id)
    else
      invitable.roles.create({
        user: @user,
        role_type_id: @invite.role_type_id
      })
    end

    if invitable.class.name == 'Organization'
      org = invitable
    else
      org = invitable.org
    end

    user_org = @user.orgs.find_by_id(org.id)

    unless user_org
      org.roles.create({
        user: @user,
        role_type: RoleType.none
      })
    end

    @invite.update( accepted: true )

    render json: { success: true }

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
      raise Exception.new("User lacks ability to invite to #{@invitable.class.name}")
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

  def set_invitable
    pid = params[:project_id]
    @invitable = @user.projects.find(pid) if pid
    @invitable = @organization unless pid
    @able = Ability.new(@user, @invitable)
  end

  def set_invite
    @invite = Invite.find_by_key(params['key'])
    raise Exception.new('Invite not found') unless @invite
  end

end
