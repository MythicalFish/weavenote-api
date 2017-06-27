# frozen_string_literal: true
module AcceptInvitation
  extend ActiveSupport::Concern
  included do
    
    def accept
      @invitable = @invite.invitable
      fail_if_admin
      @organization = add_user_to_organization
      existing_role = @user.role_for(@invitable)
      if existing_role
        existing_role.update!(role_type_id: @invite.role_type_id)
      else
        @invitable.roles.create!({
          user: @user,
          role_type_id: @invite.role_type_id
        })
      end
      @invite.update!( accepted: true )
      UserController.show
    end

  end

  def fail_if_admin
    if @user.role_for(invited_organization) == RoleType.admin
      user_error("You're already an admin for this organization")
    end
  end

  def invited_organization
    if @invitable.class.name == 'Organization'
      return @invitable
    end
    @invitable.org
  end

  def add_user_to_organization
    org = invited_organization
    user_org = @user.orgs.find_by_id(org.id)
    unless user_org
      org.roles.create!({
        user: @user,
        role_type: RoleType.guest
      })
    end
    @user.update!( current_organization_id: org.id )
    org
  end


end