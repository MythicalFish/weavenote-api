module ApplicationHelper

  def is_api_mode?
    request.subdomain == 'api' || request.port != 3002
  end

  def is_billing_mode?
    request.subdomain == 'billing' || request.port == 3002
  end

end
