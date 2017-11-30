task usernames: :environment do
  User.all.each do |u|
    u.set_username
    u.save
    puts u.username
  end
end