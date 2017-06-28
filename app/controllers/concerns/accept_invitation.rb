# frozen_string_literal: true
module AcceptInvitation
  extend ActiveSupport::Concern
  included do
    
    def accept
      @invite = Invite.find_by_key(params[:id])
      fail_unless_invite
      @invitable = @invite.invitable
      fail_if_already_accepted
      fail_if_already_admin
      assign_organization
      existing_role = @user.role_for(@invitable)
      if existing_role
        existing_role.update!(role_type: @invite.role_type)
        msg = "Your role for this #{@invitable.class.name} has been updated to \"#{@invite.role_type.name}\""
      else
        @invitable.roles.create!({
          user: @user,
          role_type: @invite.role_type
        })
        msg = "You are now a #{@invite.role_type.name} for this #{@invitable.class.name}"
      end
      @invite.update!( accepted: true )
      render_success msg, @invite
    end

  end

  def fail_unless_invite
    unless @invite
      render_warning("Invite not found")
    end
  end

  def fail_if_already_admin
    if @user.role_for(invited_organization).type == RoleType.admin
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
    org = invited_organization
    user_org = @user.orgs.find_by_id(org.id)
    unless user_org
      org.roles.create!({
        user: @user,
        role_type: RoleType.guest
      })
    end
    @user.update!( current_organization_id: org.id )
  end


end