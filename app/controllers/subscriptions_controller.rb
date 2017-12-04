class SubscriptionsController < ApplicationController
  
  include Payola::StatusBehavior
  before_action :cancel_subscription, only: [:destroy]
  
  def new
    @plan = plan
  end

  def create
    owner = @user
    params[:plan] = SubscriptionPlan.find_by(id: params[:plan_id])
    subscription = Payola::CreateSubscription.call(params, owner)
    render_payola_status(subscription)
  end

  def reactivate
    
    subscription = @organization.subscriptions.find_by!(guid: params[:guid])
    secret_key = Payola.secret_key_for_sale(subscription)
    customer = Stripe::Customer.retrieve(subscription.stripe_customer_id, secret_key)
    stripe_subscription = customer.subscriptions.retrieve(subscription.stripe_id, secret_key)

    raise "Cannot reactivate subscription unless owned" if customer.email != @user.email
    
    # To reactivate in Stripe, you just need to set the Plan again
    stripe_subscription.plan = plan
    stripe_subscription.save

    subscription.cancel_at_period_end = false
    subscription.save!

  end

  private

  def cancel_subscription
    subscription = @organization.subscription
    Payola::CancelSubscription.call(subscription)
  end

  def plan
    SubscriptionPlan.first
  end
end
