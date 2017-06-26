class InvitesController < ApplicationController

  skip_before_action :set_user!, only: [ :show ]
  before_action :set_invitable, except: [ :show, :accept ]
  before_action :set_invite, only: [ :show, :update, :destroy, :accept ]

  def index
    render json: pending_invites
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
    if is_collaborator?(invitee)
      user_error(msg[:already_collaborator])
    elsif already_invited?(invitee)
      user_error(msg[:already_invited])
    else
      @invite = @invitable.invites.new(invite_params) 
      if @invite.save
        @invite.send_email
      else
        user_error @invite
      end
      render_success "Invite sent", pending_invites
    end
  end

  def destroy
    @able.to? :destroy
    @invite.destroy!
    index
  end

  private

  def invitee
    invitee = invite_params[:email]
    user_error(msg[:no_email]) unless invitee
    invitee
  end

  def pending_invites
    @invitable.invites.where(accepted: false)
  end

  def invite_for email
    pending_invites.find_by_email(email)
  end

  def already_invited? email
    !!invite_for(email)
  end

  def is_collaborator? email
    @invitable.collaborators.find_by_email(email)
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
    unless @invitable
      raise "Missing invitable (project/organization), can't index Invites"
    end
    @able = Ability.new(@user, @invitable)
  end

  def set_invite
    @invite = @invitable.invites.find_by_key!(params[:id])
  end

  def msg
    {
      :no_email => "No email address provided for invite",
      :already_invited => "User already has already been invited"
      :already_collaborator => "User already is already a collaborator"
    }
  end

end
