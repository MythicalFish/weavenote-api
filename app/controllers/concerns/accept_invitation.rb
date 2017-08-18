# frozen_string_literal: true
module AcceptInvitation
  extend ActiveSupport::Concern
  included do
    
    def accept
      @invite = Invite.find_by_key(params[:id])
      fail_unless_invite
      fail_if_already_accepted
      fail_if_email_mismatch
      @invitable = @invite.invitable
      fail_if_already_admin
      assign_organization
      existing_role = @user.role_for(@invitable)
      if existing_role
        existing_role.update!(role_type: @invite.role_type)
      else
        @invitable.roles.create!({
          user: @user,
          role_type: @invite.role_type
        })
      end
      @invite.update!( accepted: true )
      msg = "You are now a #{@invite.role_type.name} for this #{@invitable.class.name}"
      render_success msg, @invite
    end

  end

  def fail_if_email_mismatch
    if @invite.email != @user.email
      render_warning("You are logged in with #{@user.email}, however the invite was sent to #{@invite.email}")
    end
  end

  def fail_unless_invite
    unless @invite
      render_warning("Invite not found")
    end
  end

  def fail_if_already_admin
    org_role = @user.role_for(invited_organization)
    if org_role && org_role.type == RoleType.admin
      render_warning("You're already an admin for this organization")
    end
  end

  def fail_if_already_accepted
    if @invite.accepted
      render_warning("You've already accepted this invite")
    end
  end

  def invited_organization
    if @invitable.class.name == 'Organization'
      return @invitable
    end
    @invitable.organization
  end

  def assign_organization
    # Invited user must have some kind of role for the organization
    # Here we check this, and assign RoleType.none if not
    # We also ensure the invited user is viewing this organization
    org = invited_organization
    user_org = @user.organizations.find_by_id(org.id)
    unless user_org
      org.roles.create!({
        user: @user,
        role_type: RoleType.none 
      })
    end
    @user.update!( current_organization_id: org.id )
  end


end