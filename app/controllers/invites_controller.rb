class InvitesController < ApplicationController

  skip_before_action :set_user!, only: [ :show ]
  before_action :set_invitable, except: [ :show, :accept ]
  before_action :set_invite, only: [ :show, :update, :destroy, :accept ]

  def index
    unless @invitable
      raise Exception.new("Missing invitable (project/organization), can't index Invites")
    end
    render json: @invitable.invites.where(accepted: false)
  end

  def show
    @invite = Invite.find_by_key!(params[:id])
    render json: @invite
  end

  def update
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

    UserController.show

  end

  def create
    @able.to? :create
    @invite = find_or_create
    if @invite.save
      index
    else
      raise Exception.new(@invite.errors.full_messages.join("\n"))
    end
  end

  def destroy
    @able.to? :destroy
    if @invite.destroy
      index
    else
      raise Exception.new(@invite.errors.full_messages.join("\n"))
    end
  end

  private

  def invite_for invitable
    invitable.invites.find_by_email(invite_params[:email])
  end

  def already_invited_to? invitable
    !!invite_for(invitable)
  end

  def is_collaborator_for? invitable
    invitable.collaborators.find_by_email(invite_params[:email])
  end

  def find_or_create
    if already_invited_to?(@invitable)
      invite = invite_for(@invitable)
      if invite.accepted
        if is_collaborator_for?(@invitable)
          user_error "User already added to #{@invitable.class.name}"
        else
          invite.update(accepted: false)
        end
      end
      invite.update(invite_params)
    else
      invite = @invitable.invites.new(invite_params) 
    end
    invite.send_email
    return invite
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
    invitable_class = Object.const_get(params[:invitable][:type])
    collection = invitable_class.model_name.collection
    @invitable = @user.send(collection).find(params[:invitable][:id])
    @able = Ability.new(@user, @invitable)
  end

  def set_invite
    @invite = @invitable.invites.find_by_key!(params[:id])
  end

end
