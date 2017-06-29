class InvitesController < ApplicationController

  include SetInvitable
  include AcceptInvitation

  before_action :set_invitable, except: [ :show, :accept ]
  before_action :set_invite, except: [ :show, :accept, :index, :create ]
  skip_before_action :set_user!, only: [ :show ]

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
    user_can? :create
    if already_collaborator?
      render_error(msg[:already_collaborator])
    elsif already_collaborator? @organization
      render_error(msg[:already_org_collaborator])
    elsif already_invited?
      render_error(msg[:already_invited])
    else
      @invite = @invitable.invites.new(invite_params) 
      @invite.save!
      @invite.send_email
      render_success "Invite sent", pending_invites
    end
  end

  def destroy
    user_can? :destroy
    @invite.destroy!
    render_success "Invite cancelled", pending_invites
  end

  private

  def email
    email = invite_params[:email]
    render_error(msg[:no_email]) unless email
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
    if p[:as_guest]
      p[:role_type_id] = 2
    end
    unless RoleType::EXPOSED_IDS.include? p[:role_type_id]
      render_fatal "User attempted to assign unpermitted role_type_id"
    end
    p.permit(:email, :name, :role_type_id)
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
