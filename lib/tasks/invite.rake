task :test_invite, [:role_type_id, :invitable_type] => :environment do |t,args|
  
  invitable_type = args[:invitable_type] || 'Organization'
  role_type_id = args[:role_type_id] || 2
  
  inviter = User.find(1)
  email = 'jakey.bt@gmail.com'
  user = User.find_by_email(email)
  user.roles.destroy_all if user
  
  params = {
    inviter_id: inviter.id,
    email: email,
    role_type_id: role_type_id,
    invitable_type: invitable_type,
  }
  if invitable_type == 'Organization'
    params[:invitable_id] = inviter.organizations.first.id
  else
    params[:invitable_id] = inviter.projects.last.id
  end
  i = Invite.create!(params)
  i.update(key:'test')
  puts i.invite_link
end
