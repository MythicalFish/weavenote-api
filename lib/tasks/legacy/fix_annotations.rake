namespace :annotations do

  task fix: :environment do
    Annotation.all.each do |a|
      next if a.user
      next unless a.annotatable
      next unless a.annotatable.try(:user_id)
      a.update!(user_id: a.annotatable.user_id)
      puts "Updated annotation #{a.id}"
    end
  end

end