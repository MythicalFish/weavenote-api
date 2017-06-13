class InvitesController < ApplicationController

  def create
    @user.invite
    #return
    #@invitation = Invitation.new(invitation_params)
    #if @invitation.save
    #  
    #else
    #  render json: @invitation.errors.full_messages.join(', '), status: :unprocessable_entity
    #end
  end

  private

  def invitation_params
    params.require(:email)
  end

end
