source 'https://rubygems.org'

ruby '2.3.1'
gem 'rails', '5.0.0'

gem 'bcrypt', '~> 3.1' # To use ActiveModel has_secure_password
gem 'bootstrap-sass'
gem 'chartkick', '~> 2.2'
gem 'groupdate'
gem 'jquery-rails'
gem 'pg'
gem 'sentry-raven', '~> 2.4'
gem 'slim-rails'

group :assets do
  gem 'coffee-script' #hack to get assets on dokku working
  gem 'sass-rails'
  gem 'uglifier'
end

group :test, :development do
  gem 'rspec-rails'
  gem 'test-unit'
end

group :test do
  gem 'byebug'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'launchy'
  gem 'rails-controller-testing'
  gem 'rspec-collection_matchers'
  gem 'rspec-its'
  gem 'selenium-webdriver'
  gem 'sqlite3'
  gem 'timecop'
end

group :production do
  gem 'rails_12factor'
end
