
puts ""

unless User.find_by_email('jake@mythical.fish')
  User.create({
    name: 'jake',
    email: 'jake@mythical.fish',
    auth0_id: 'auth0|58fa28e05ae79b35893d826a'
  })
end

project_data = [
  {
    name: 'Oversized T white',
    identifier: 'T123',
    development_stage_id: 2,
    category: 'Jersey',
    description: 'White oversized crew neck t-shirt',
    img_url: 'https://cdna.lystit.com/photos/2e50-2015/04/01/vetements-white-back-print-oversized-t-shirt-product-2-906061375-normal.jpeg',
    components: [
      { material_id: 1, quantity: 1 },
      { material_id: 2, quantity: 1.5 },
      { material_id: 4, quantity: 2.5 }
    ]
  },{
    name: 'Skinny blue jeans',
    identifier: 'J456',
    development_stage_id: 3,
    category: 'Jeans',
    description: 'These are skinny blue jeans',
    img_url: 'https://mosaic01.ztat.net/vgs/media/pdp-gallery/GS/12/1N/01/XK/12/GS121N01X-K12@26.1.jpg',
    components: [
      { material_id: 6, quantity: 3 },
      { material_id: 4, quantity: 2 },
    ]
  },{
    name: 'Gray dress',
    identifier: 'D789',
    development_stage_id: 3,
    category: 'Dress',
    description: 'This is a gray dress',
    img_url: 'https://mosaic01.ztat.net/vgs/media/pdp-gallery/KA/32/1C/06/UC/12/KA321C06U-C12@12.jpg',
    components: [
      { material_id: 2, quantity: 1.5 },
      { material_id: 8, quantity: 7 },
      { material_id: 7, quantity: 3 },
      { material_id: 3, quantity: 2.5 },
    ]
  },{
    name: 'Green jacket',
    identifier: 'J321',
    development_stage_id: 2,
    category: 'Jacket',
    description: 'This is a green jacket',
    img_url: 'https://mosaic01.ztat.net/vgs/media/pdp-gallery/JA/22/2H/09/GM/12/JA222H09G-M12@10.jpg',
    components: [
      { material_id: 1, quantity: 1.5 },
      { material_id: 3, quantity: 3 },
      { material_id: 6, quantity: 2.5 },
      { material_id: 4, quantity: 0.4 },
    ]
  },{
    name: 'Floral blouse',
    identifier: 'B987',
    development_stage_id: 1,
    category: 'Blouse',
    description: 'This is a floral blouse',
    img_url: 'https://mosaic01.ztat.net/vgs/media/pdp-gallery/VE/12/1E/0O/ZK/11/VE121E0OZ-K11@8.jpg',
    components: [
      { material_id: 3, quantity: 1 },
      { material_id: 5, quantity: 2.7 },
      { material_id: 6, quantity: 0.6 },
    ]
  },{
    name: 'Black jacket',
    identifier: 'J654',
    development_stage_id: 2,
    category: 'Jacket',
    description: 'This is a black jacket',
    img_url: 'https://mosaic01.ztat.net/vgs/media/pdp-gallery/HI/12/2H/01/MQ/11/HI122H01M-Q11@10.jpg',
    components: [
      { material_id: 1, quantity: 1.5 },
      { material_id: 3, quantity: 2.3 },
      { material_id: 5, quantity: 1.5 },
      { material_id: 8, quantity: 1.4 },
    ]
  }
]

materials = [
  {
    material_type_id: 1,
    name: 'Drape',
    identifier: '100-99',
    color_id: @colors[16].id,
    cost_base: 36,
  },{
    material_type_id: 2,
    name: 'Heavy fusing',
    identifier: '201-01',
    color_id: @colors[13].id,
    cost_base: 0.10,
  },{
    material_type_id: 1,
    name: 'Georgia',
    identifier: '100-50',
    color_id: @colors[2].id,
    cost_base: 5,
  },{
    material_type_id: 3,
    name: 'RIRI',
    identifier: '500-12',
    color_id: @colors[14].id,
    cost_base: 3,
  },{
    material_type_id: 4,
    name: 'String',
    identifier: '605-80',
    color_id: @colors[15].id,
    cost_base: 3,
  },{
    material_type_id: 5,
    name: 'Cupro',
    identifier: '150-01',
    color_id: @colors[9].id,
    cost_base: 2,
  },{
    material_type_id: 6,
    name: 'Shirt standard',
    identifier: '100-99',
    color_id: @colors[14].id,
    cost_base: 0.2,
  },{
    material_type_id: 7,
    name: 'Exotic',
    identifier: '900-60',
    color_id: @colors[12].id,
    cost_base: 13,
  }
]

measurement_groups = [ 
  { name: 'S' },
  { name: 'M' },
  { name: 'L' }
]
measurements = [
  {
    name: 'Hem',
    values: [ 52, 55, 57 ]
  },{
    name: 'Hem facing',
    values: [ 2.5, 2.5, 2.5 ]
  },{
    name: 'Shoulder length',
    values: [ 12.5, 13.5, 14.5 ]
  },{
    name: 'Sleeve length',
    values: [ 20.5, 21, 21.5 ]
  },{
    name: 'Underarm',
    values: [ 13.5, 14, 14.5 ]
  },{
    name: 'Sleeve opening',
    values: [ 17, 18, 19 ]
  },{
    name: 'Waist from hsp',
    values: [ 44, 46, 48 ]
  },
]

Project.all.destroy_all
ActiveRecord::Base.connection.execute("ALTER TABLE projects AUTO_INCREMENT = 1;")

Image.all.destroy_all
ActiveRecord::Base.connection.execute("ALTER TABLE images AUTO_INCREMENT = 1;")

Material.all.destroy_all
ActiveRecord::Base.connection.execute("ALTER TABLE materials AUTO_INCREMENT = 1;")

Component.all.destroy_all
ActiveRecord::Base.connection.execute("ALTER TABLE components AUTO_INCREMENT = 1;")

MeasurementGroup.all.destroy_all
ActiveRecord::Base.connection.execute("ALTER TABLE measurement_groups AUTO_INCREMENT = 1;")

MeasurementName.all.destroy_all
ActiveRecord::Base.connection.execute("ALTER TABLE measurement_names AUTO_INCREMENT = 1;")

MeasurementValue.all.destroy_all
ActiveRecord::Base.connection.execute("ALTER TABLE measurement_values AUTO_INCREMENT = 1;")


User.all.each do |user|
  
  puts "\nFor user: #{user.name}\n\n"

  materials.each do |data|
    user.materials.create!(data)
    puts " - Created material: #{data[:name]}"
  end

  puts ""

  project_data.each do |d|
    
    data = d.dup
    img_url = data[:img_url]
    data.delete(:img_url)
    components = data[:components]
    data.delete(:components)

    project = user.projects.create(data)
    puts " - Created project: #{data[:name]}"

    project.create_image({ url: img_url })
    project.components.create(components)
    project.measurement_groups.create(measurement_groups)
    
    measurements.each do |m|
      mm = project.measurement_names.create({ value: m[:name] })
      m[:values].each_with_index do |val, i|
        id = project.measurement_groups[i].id
        mm.measurement_values.create({value: val, measurement_group_id: id })
      end
    end

  end
  

end