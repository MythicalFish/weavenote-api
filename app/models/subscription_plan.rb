class SubscriptionPlan < ActiveRecord::Base

  include Payola::Plan

  def redirect_path subscription
    link_organization_to(subscription)
    "/"
  end

  private

  def link_organization_to subscription
    # Find currently active organization
    org = subscription.owner.organization
    # Provide subscription ID to organization
    org.subscriptions << subscription
    org.save!
  end

end