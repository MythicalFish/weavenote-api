class SubscriptionsController < ApplicationController
  
  include Payola::StatusBehavior
  before_action :cancel_subscription, only: [:destroy]
  
  def new
    @plan = SubscriptionPlan.first
  end

  def create
    owner = @user
    params[:plan] = SubscriptionPlan.find_by(id: params[:plan_id])
    subscription = Payola::CreateSubscription.call(params, owner)
    render_payola_status(subscription)
  end

  private

  def cancel_subscription
    subscription = @organization.subscription
    Payola::CancelSubscription.call(subscription)
  end

end
