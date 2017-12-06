module ApplicationHelper

  def is_api_mode?
    request.subdomain == 'api' || request.port == 3001
  end

  def is_billing_mode?
    request.subdomain == 'billing' || request.port == 3002
  end

  def pretty_date date
    date.strftime('%b %e, %l:%M %p')
  end

end
