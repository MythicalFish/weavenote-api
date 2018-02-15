class UnitType < ApplicationRecord
  
  def display_name
    case name
      when 'Foot'
        "feet"
    else
      name.downcase + 's'
    end
  end

end