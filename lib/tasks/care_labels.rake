task care_labels: :environment do
  labels = [
    ['Do not wash', 'gin_sym_was_not.jpg'],
    ['Hand wash - max 40℃', 'gin_sym_was_hand.jpg'],
    ['Can be machine washed', 'gin_sym_was.jpg'],
    ['Max 30℃ - normal process', 'gin_sym_was_30.jpg'],
    ['Max 30℃ - mild process', 'gin_sym_was_30_mild.jpg'],
    ['Max 30℃ - very mild process', 'gin_sym_was_30_gentle.jpg'],
    ['Max 40℃ - normal process', 'gin_sym_was_40.jpg'],
    ['Max 40℃ - mild process', 'gin_sym_was_40_mild.jpg'],
    ['Max 40℃ - very mild process', 'gin_sym_was_40_gentle.jpg'],
    ['Max 60℃ - normal process', 'gin_sym_was_60.jpg'],
    ['Max 60℃ - mild process', 'gin_sym_was_60_mild.jpg'],
    ['Max 95℃ - normal process', 'gin_sym_was_95.jpg'],
    ['Any bleaching agent allowed', 'gin_sym_ble.jpg'],
    ['Do not bleach', 'gin_sym_ble_not.jpg'],
    ['Only Oxygen - non-chlorine bleach allowed', 'gin_sym_ble_limited.jpg'],
    ['Can be tumble dried', 'gin_sym_dry.jpg'],
    ['Tumble dry - max 60℃', 'gin_sym_dry_low.jpg'],
    ['Tumble dry - max 80℃', 'gin_sym_dry_normal.jpg'],
    ['Do not tumble dry', 'gin_sym_dry_not.jpg'],
    ['Line drying', 'gin_sym_dry_line.jpg'],
    ['Drip flat drying', 'gin_sym_dry_drip_flat.jpg'],
    ['Line drying in the shade', 'gin_sym_dry_line_shade.jpg'],
    ['Drip line drying in the shade', 'gin_sym_dry_drip_line_shade.jpg'],
    ['Flat drying in the shade', 'gin_sym_dry_flat_shade.jpg'],
    ['Drip flat drying in the shade', 'gin_sym_dry_drip_flat_shade.jpg'],
    ['Iron any heat - dry or steam', 'gin_sym_iro.jpg'],
    ['Iron sole max 110℃ - steam iron may cause irreversible damage', 'gin_sym_iro_max_110.jpg'],
    ['Iron sole max 150℃', 'gin_sym_iro_max_150.jpg'],
    ['Iron sole max 200℃', 'gin_sym_iro_max_200.jpg'],
    ['Do not iron', 'gin_sym_iro_not.jpg'],
    ['Dry clean only', 'gin_sym_pro_textile_care.jpg'],
    ['Specialist dry clean only', 'gin_sym_pro_textile_care.jpg'],
    ['Do not dry clean', 'gin_sym_pro_dry_not.jpg'],
    ['Dry clean in hydro-carbons - normal process', 'gin_sym_pro_dry_f_normal.jpg'],
    ['Dry clean in hydro-carbons - mild process', 'gin_sym_pro_dry_f_mild.jpg'],
    ['Dry clean in tetrachlorothene and all solvents listed for the symbol F - normal process', 'gin_sym_pro_dry_p_normal.jpg'],
    ['Dry clean in tetrachlorothene and all solvents listed for the symbol F - mild process', 'gin_sym_pro_dry_p_mild.jpg'],
    ['Professional wet cleaning - normal process', 'gin_sym_pro_wet_w_normal.jpg'],
    ['Professional wet cleaning - mild process', 'gin_sym_pro_wet_w_mild.jpg'],
    ['Professional wet cleaning - very mild process', 'gin_sym_pro_wet_w_gentle.jpg'],
    ['Do not wet clean', 'gin_sym_pro_wet_not.jpg']
  ]
  CareLabel.destroy_all
  ActiveRecord::Base.connection.execute('ALTER TABLE care_labels AUTO_INCREMENT = 1')
  labels.each do |a|
    CareLabel.create({name: a[0], icon: a[1].split('.')[0]})
    puts "Created \"#{a[0]}\""
  end
end