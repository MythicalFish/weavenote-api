source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.2'
gem 'puma', '~> 3.0'
gem 'rack-cors'

group :development, :test do
  gem 'byebug', platform: :mri
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'spring' 
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rb-readline'
end

gem 'jwt'
gem 'auth0'
gem 'mysql2'
gem 'active_model_serializers', '~> 0.10.5'
gem 'paperclip'
gem 'amoeba'
gem 'fog'
gem 'figaro'
gem 'active_hash'
gem 'letter_avatar'
gem 'pdfkit'
gem 'haml-rails'

group :production do
  gem 'newrelic_rpm'
end