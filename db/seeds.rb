
def care_labels
  puts ''
  CareLabel.all.destroy_all
  ActiveRecord::Base.connection.execute("ALTER TABLE care_labels AUTO_INCREMENT = 1;")
  CareLabel.create([
    { name: 'Tumble dry, permanent press' },
    { name: 'Dry clean, any solvent' },
    { name: 'Iron, any temperature, steam' },
    { name: 'Machine wash, hot, gentle' },
    { name: 'Machine wash, normal' },
  ]).each do |c|
    puts "Created care label: #{c.name}"
  end
  puts ''
end

def currencies
  puts ''
  Currency.all.destroy_all
  ActiveRecord::Base.connection.execute("ALTER TABLE currencies AUTO_INCREMENT = 1;")
  Currency.create([
    { name: 'British Pounds', iso_code: 'GBP', unicode: '\u00A3' },
    { name: 'Euros', iso_code: 'EUR', unicode: '\u20AC' },
    { name: 'US Dollars', iso_code: 'USD', unicode: '\u0024' },
  ]).each do |c|
    puts "Created currency: #{c.name}"
  end
  puts ''
end

def colors
  puts ''
  Color.all.destroy_all
  ActiveRecord::Base.connection.execute("ALTER TABLE colors AUTO_INCREMENT = 1;")
  Color.create([
    { name: 'Aqua', hex_code: '#7fdbff' },
    { name: 'Blue', hex_code: '#0074d9' },
    { name: 'Navy', hex_code: '#001f3f' },
    { name: 'Teal', hex_code: '#39cccc' },
    { name: 'Green', hex_code: '#2ecc40' },
    { name: 'Olive', hex_code: '#3d9970' },
    { name: 'Lime', hex_code: '#01ff70' },
    { name: 'Yellow', hex_code: '#ffdc00' },
    { name: 'Orange', hex_code: '#ff851b' },
    { name: 'Red', hex_code: '#ff4136' },
    { name: 'Fuchsia', hex_code: '#f012be' },
    { name: 'Purple', hex_code: '#b10dc9' },
    { name: 'Maroon', hex_code: '#85144b' },
    { name: 'White', hex_code: '#fff' },
    { name: 'Silver', hex_code: '#ddd' },
    { name: 'Gray', hex_code: '#aaa' },
    { name: 'Black', hex_code: '#111' },
  ]).each do |c|
    puts "Created color: #{c.name}"
  end
  puts ''
end

def material_types
  puts ''
  MaterialType.all.destroy_all
  ActiveRecord::Base.connection.execute("ALTER TABLE material_types AUTO_INCREMENT = 1;")
  MaterialType.create([
    { name: 'Fabric' },
    { name: 'Leather' },
    { name: 'Knit' },
    { name: 'Yarn' },
    { name: 'Fur' },
    { name: 'Lining' },
    { name: 'Fusing' },
    { name: 'Canvas' },
    { name: 'Trim' },
    { name: 'Wadding' },
    { name: 'Zip' },
    { name: 'Button' },
  ]).each do |t|
    puts "Created material type: #{t.name}"
  end
  puts ''
end

def unit_types
  puts ''
  UnitType.all.destroy_all
  ActiveRecord::Base.connection.execute("ALTER TABLE unit_types AUTO_INCREMENT = 1;")
  UnitType.create([
    {:name => "Unit"},
    {:name => "Metre"},
    {:name => "Foot"},
    {:name => "Gram"},
    {:name => "Yarn"},
  ]).each do |t|
    puts "Created unit type: #{t.name}"
  end
  puts ''
end

care_labels
currencies
colors
material_types
unit_types