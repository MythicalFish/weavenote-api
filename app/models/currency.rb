class Currency < ActiveHash::Base
  self.data = [
    { id: 1, name: 'British Pounds', iso_code: 'GBP', unicode: '\u00A3' },
    { id: 2, name: 'Euros', iso_code: 'EUR', unicode: '\u20AC' },
    { id: 3, name: 'US Dollars', iso_code: 'USD', unicode: '\u0024' },
  ]
end
