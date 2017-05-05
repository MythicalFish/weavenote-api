
puts ""

unless User.find_by_email('jake@mythical.fish')
  User.create({
    name: 'jake',
    email: 'jake@mythical.fish',
    auth0_id: 'auth0|58fa28e05ae79b35893d826a'
  })
end

DevelopmentStage.all.destroy_all
ActiveRecord::Base.connection.execute("ALTER TABLE development_stages AUTO_INCREMENT = 1;")
@stages = DevelopmentStage.create([
  { label: 'Sample' },
  { label: 'Production' },
  { label: 'Done' },
])

@stages.each do |c|
  puts "Created dev stage: #{c.label}"
end

Color.all.destroy_all
ActiveRecord::Base.connection.execute("ALTER TABLE colors AUTO_INCREMENT = 1;")
@colors = Color.create([
  { name: 'aqua', hex_code: '#7fdbff' },
  { name: 'blue', hex_code: '#0074d9' },
  { name: 'navy', hex_code: '#001f3f' },
  { name: 'teal', hex_code: '#39cccc' },
  { name: 'green', hex_code: '#2ecc40' },
  { name: 'olive', hex_code: '#3d9970' },
  { name: 'lime', hex_code: '#01ff70' },
  { name: 'yellow', hex_code: '#ffdc00' },
  { name: 'orange', hex_code: '#ff851b' },
  { name: 'red', hex_code: '#ff4136' },
  { name: 'fuchsia', hex_code: '#f012be' },
  { name: 'purple', hex_code: '#b10dc9' },
  { name: 'maroon', hex_code: '#85144b' },
  { name: 'white', hex_code: '#fff' },
  { name: 'silver', hex_code: '#ddd' },
  { name: 'gray', hex_code: '#aaa' },
  { name: 'black', hex_code: '#111' },
])

puts ""

@colors.each do |c|
  puts "Created color: #{c.name}"
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

material_types = [
  { name: 'Fabric' },
  { name: 'Fusing' },
  { name: 'Zip' },
  { name: 'Trim' },
  { name: 'Lining' },
  { name: 'Button' },
  { name: 'Leather' },
]

materials = [
  {
    type_index: 0,
    name: 'Drape',
    identifier: '100-99',
    color_id: @colors[16].id,
    price: 36,
  },{
    type_index: 1,
    name: 'Heavy fusing',
    identifier: '201-01',
    color_id: @colors[13].id,
    price: 0.10,
  },{
    type_index: 0,
    name: 'Georgia',
    identifier: '100-50',
    color_id: @colors[2].id,
    price: 5,
  },{
    type_index: 2,
    name: 'RIRI',
    identifier: '500-12',
    color_id: @colors[14].id,
    price: 3,
  },{
    type_index: 3,
    name: 'String',
    identifier: '605-80',
    color_id: @colors[15].id,
    price: 3,
  },{
    type_index: 4,
    name: 'Cupro',
    identifier: '150-01',
    color_id: @colors[9].id,
    price: 2,
  },{
    type_index: 5,
    name: 'Shirt standard',
    identifier: '100-99',
    color_id: @colors[14].id,
    price: 0.2,
  },{
    type_index: 6,
    name: 'Exotic',
    identifier: '900-60',
    color_id: @colors[12].id,
    price: 13,
  }
]

Project.all.destroy_all
ActiveRecord::Base.connection.execute("ALTER TABLE projects AUTO_INCREMENT = 1;")

Image.all.destroy_all
ActiveRecord::Base.connection.execute("ALTER TABLE images AUTO_INCREMENT = 1;")

MaterialType.all.destroy_all
ActiveRecord::Base.connection.execute("ALTER TABLE material_types AUTO_INCREMENT = 1;")

Material.all.destroy_all
ActiveRecord::Base.connection.execute("ALTER TABLE materials AUTO_INCREMENT = 1;")

Component.all.destroy_all
ActiveRecord::Base.connection.execute("ALTER TABLE components AUTO_INCREMENT = 1;")

User.all.each do |user|
  
  puts "\nFor user: #{user.name}\n\n"

  types = user.material_types.create(material_types)
  types.each do |t|
    puts " - Created material type: #{t.name}"
  end

  puts ""

  materials.each do |m|
    data = m.dup
    type_index = data[:type_index]
    data.delete(:type_index)
    data[:material_type_id] = user.material_types[type_index].id
    user.materials.create(data)
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
    project.images.create({ url: img_url })
    project.components.create(components)
    puts " - Created project: #{data[:name]}"
  end
  

end