# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

unless User.find_by_email('jake@mythical.fish')
  User.create({
    name: 'jake',
    email: 'jake@mythical.fish',
    auth0_id: 'auth0|58fa28e05ae79b35893d826a'
  })
end

DevelopmentStage.create([
  { label: 'Sample' },
  { label: 'Production' },
  { label: 'Done' },
])

project_data = [
  {
    name: 'Oversized T white',
    identifier: 'T123',
    development_stage_id: 2,
    category: 'Jersey',
    description: 'White oversized crew neck t-shirt',
    image: {
      url: 'https://cdna.lystit.com/photos/2e50-2015/04/01/vetements-white-back-print-oversized-t-shirt-product-2-906061375-normal.jpeg',
    }
  },{
    name: 'Skinny blue jeans',
    identifier: 'J456',
    development_stage_id: 3,
    category: 'Jeans',
    description: 'These are skinny blue jeans',
    image: {
      url: 'https://mosaic01.ztat.net/vgs/media/pdp-gallery/GS/12/1N/01/XK/12/GS121N01X-K12@26.1.jpg',
    }
  },{
    name: 'Gray dress',
    identifier: 'D789',
    development_stage_id: 3,
    category: 'Dress',
    description: 'This is a gray dress',
    image: {
      url: 'https://mosaic01.ztat.net/vgs/media/pdp-gallery/KA/32/1C/06/UC/12/KA321C06U-C12@12.jpg',
    }
  },{
    name: 'Green jacket',
    identifier: 'J321',
    development_stage_id: 2,
    category: 'Jacket',
    description: 'This is a green jacket',
    image: {
      url: 'https://mosaic01.ztat.net/vgs/media/pdp-gallery/JA/22/2H/09/GM/12/JA222H09G-M12@10.jpg',
    }
  },{
    name: 'Floral blouse',
    identifier: 'B987',
    development_stage_id: 1,
    category: 'Blouse',
    description: 'This is a floral blouse',
    image: {
      url: 'https://mosaic01.ztat.net/vgs/media/pdp-gallery/VE/12/1E/0O/ZK/11/VE121E0OZ-K11@8.jpg',
    }
  },{
    name: 'Black jacket',
    identifier: 'J654',
    development_stage_id: 2,
    category: 'Jacket',
    description: 'This is a black jacket',
    image: {
      url: 'https://mosaic01.ztat.net/vgs/media/pdp-gallery/HI/12/2H/01/MQ/11/HI122H01M-Q11@10.jpg',
    }
  }
]

User.all.each do |user|
  user.projects.destroy_all
  user.projects.create(project_data)
end