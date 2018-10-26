namespace :users do
  desc 'Generate auth tokens for users without one'
  task create_tokens: :environment do
    users_to_update = User.where(auth_token: nil)
    users_to_update.each do |u|
      puts u.name
      u.generate_token
      u.save
    end
  end
end
