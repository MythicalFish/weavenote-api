namespace :fixed_data do

  task care_labels: :environment do 

    puts ''

    # Care labels
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

end