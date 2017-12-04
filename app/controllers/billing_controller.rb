class BillingController < ApplicationController
  def dashboard
    @subscription = @organization.active_subscription
    if @subscription
      @end_date = pretty_date(@subscription.current_period_end)
      @will_cancel = @subscription.cancel_at_period_end?
      @is_active = @subscription.active?
      @is_own_subscription = @subscription.owner.email == @user.email
    end
  end
end