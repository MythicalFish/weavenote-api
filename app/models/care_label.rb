class CareLabel < ActiveHash::Base
  self.data = [
    { id: 1, name: 'Tumble dry, permanent press' },
    { id: 2, name: 'Dry clean, any solvent' },
    { id: 3, name: 'Iron, any temperature, steam' },
    { id: 4, name: 'Machine wash, hot, gentle' },
    { id: 5, name: 'Machine wash, normal' },
  ]
end
