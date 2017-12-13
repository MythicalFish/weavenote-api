module CurrencyConversion

  require 'money/bank/google_currency'
  Money::Bank::GoogleCurrency.ttl_in_seconds = 86400
  Money.default_bank = Money::Bank::GoogleCurrency.new
  
  def self.do amount, from, to
    amount = Monetize.parse(amount).fractional
    money = Money.new(amount, from) 
    money.exchange_to(to).to_f
  end

end