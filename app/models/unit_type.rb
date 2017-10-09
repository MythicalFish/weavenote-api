class UnitType < ActiveHash::Base
  
  self.data = [
    {:id => 1, :name => "Unit"},
    {:id => 2, :name => "Metre"},
    {:id => 3, :name => "Foot"},
    {:id => 4, :name => "Gram"},
    {:id => 5, :name => "Yarn"},
  ]

end