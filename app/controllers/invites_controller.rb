class InvitesController < ApplicationController

  skip_before_action :set_user!, only: [ :show ]
  before_action :set_invitable, except: [ :show, :accept ]
  before_action :set_invite, except: [ :index, :show, :create ]

  def index
    render json: pending_invites
  end

  def show
    @invite = Invite.find_by_key!(params[:id])
    render json: @invite
  end

  def update
    @invite.update!(invite_params)
    render_success "Invite updated", pending_invites
  end
  
  def create
    @able.to? :create
    if already_collaborator?
      user_error(msg[:already_collaborator])
    elsif already_collaborator? @organization
      user_error(msg[:already_org_collaborator])
    elsif already_invited?
      user_error(msg[:already_invited])
    else
      @invite = @invitable.invites.new(invite_params) 
      @invite.save!
      @invite.send_email
      render_success "Invite sent", pending_invites
    end
  end

  def destroy
    @able.to? :destroy
    @invite.destroy!
    render_success "Invite cancelled", pending_invites
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
        role_type: RoleType.guest
      })
    end

    @invite.update!( accepted: true )

    UserController.show

  end



  private

  def email
    email = invite_params[:email]
    user_error(msg[:no_email]) unless email
    email
  end

  def pending_invites
    @invitable.invites.where(accepted: false)
  end

  def pending_invite
    pending_invites.find_by_email(email)
  end

  def already_invited?
    !!pending_invite
  end

  def collaborator invitable = nil
    invitable = invitable || @invitable
    invitable.collaborators.find_by_email(email)
  end

  def already_collaborator? invitable = nil
    !!collaborator(invitable)
  end

  def invite_params
    p = params[:invite]
    p[:role_type_id] = 3 unless p[:role_type_id]
    if params[:as_guest]
      p[:role_type_id] = 2
    end
    unless RoleType::EXPOSED_IDS.include? p[:role_type_id]
      server_error "User attempted to assign unpermitted role_type_id"
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
      :already_invited => "User already has already been invited",
      :already_collaborator => "User already is already a collaborator",
      :already_org_collaborator => "User already is already a collaborator for this Organization"
    }
  end

end
