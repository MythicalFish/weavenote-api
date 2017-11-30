class BillingController < ApplicationController
  def dashboard
    @subscription = @organization.subscription
  end
end