namespace :role do

  task none: :environment do
    User.first.org_role.update!(role_type_id: 1)
    puts "Role is now: None"
  end

  task viewer: :environment do
    User.first.org_role.update!(role_type_id: 2)
    puts "Role is now: Viewer"
  end

  task editor: :environment do
    User.first.org_role.update!(role_type_id: 3)
    puts "Role is now: Editor"
  end

  task manager: :environment do
    User.first.org_role.update!(role_type_id: 4)
    puts "Role is now: Manager"
  end

  task admin: :environment do
    User.first.org_role.update!(role_type_id: 5)
    puts "Role is now: Admin"
  end

end