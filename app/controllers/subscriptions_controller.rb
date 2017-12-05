class SubscriptionsController < ApplicationController
  
  include Payola::StatusBehavior
  before_action :cancel_subscription, only: [:destroy]
  
  def dashboard
    @subscription = @organization.active_subscription
    if @subscription
      @end_date = pretty_date(@subscription.current_period_end)
      @will_cancel = @subscription.cancel_at_period_end?
      @auto_renew_enabled = !@subscription.cancel_at_period_end?
      @is_active = @subscription.active?
      @is_own_subscription = @subscription.owner.email == @user.email
    end
  end

  def new
    @plan = plan
    @form_values = {}
    if params[:testData]
      @form_values = {
        name: 'Test User',
        card: '4242424242424242',
        month: '01',
        year: '2020',
        cvc: '123'
      }
    end
  end

  def create
    # Cancel existing subscriptions (immediately) 
    @organization.subscriptions.each do |s|
      if s.active?
        begin
          Payola::CancelSubscription.call(s)
        rescue
        end
      end
    end
    # Create a new one
    params[:plan] = plan
    subscription = Payola::CreateSubscription.call(params, @user)
    render_payola_status(subscription)
  end

  def reactivate
    
    subscription = @organization.subscriptions.find_by!(guid: params[:guid])
    secret_key = Payola.secret_key_for_sale(subscription)
    customer = Stripe::Customer.retrieve(subscription.stripe_customer_id, secret_key)
    stripe_subscription = customer.subscriptions.retrieve(subscription.stripe_id, secret_key)

    raise "Cannot reactivate subscription unless owned" if customer.email != @user.email
    
    # To reactivate in Stripe, you just need to set the Plan again
    stripe_subscription.plan = plan.stripe_id
    stripe_subscription.save

    subscription.cancel_at_period_end = false
    subscription.save!

    redirect_to '/'

  end

  private

  def cancel_subscription
    subscription = @organization.subscription
    Payola::CancelSubscription.call(subscription)
  end

  def plan
    return SubscriptionPlan.first unless params[:plan_id]
    SubscriptionPlan.find_by(id: params[:plan_id])
  end
end
