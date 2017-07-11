namespace :invite do

  task test: :environment do
    User.where('id != ?', 1).each do |u|
      u.roles.destroy!
      u.destroy!
    end
    Invite.all.destroy_all
    i = Invite.create!(
      inviter_id: 1,
      role_type_id: 2,
      email: 'jakey.bt@gmail.com',
      invitable_type: 'Organization',
      invitable_id: Organization.first.id
    )
    puts i.invite_link
  end

end