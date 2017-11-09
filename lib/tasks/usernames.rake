task usernames: :environment do
  User.all.each do |u|
    n = u.email.split('@')[0]
    u.update!(username: n)
    puts u.username
  end
end