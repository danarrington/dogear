source 'https://rubygems.org'

ruby '2.1.1'
gem 'rails', '4.0.0'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier'
end

gem 'jquery-rails'
gem 'bootstrap-sass'
#gem 'heroku'
gem 'slim-rails'

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'

group :test, :development do
  gem 'rspec-rails', "~> 2.13.2"
  gem 'sqlite3'
  gem 'guard-rspec'
  gem 'terminal-notifier-guard'
  gem 'spork-rails'
  gem 'guard-spork'
end

group :test do
  gem 'capybara', "2.0.2"
  gem 'factory_girl_rails', '4.2.1'
  gem 'factory_girl', '4.2.0'
  gem 'faker', '~> 1.1.2'
  gem 'database_cleaner', '~> 1.0.1'
  gem 'launchy', '~> 2.3.0'
  gem 'selenium-webdriver', '~> 2.35.1'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end
