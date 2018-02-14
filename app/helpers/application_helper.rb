module ApplicationHelper

  def is_api_mode?
    [ "api", "api-dev" ].include?(request.subdomain) || request.port == 3001 
  end

  def is_billing_mode?
    [ "billing", "billing-dev" ].include?(request.subdomain) || request.port == 3002 
  end

  def pretty_date date
    date.strftime('%b %e, %l:%M %p')
  end

end
