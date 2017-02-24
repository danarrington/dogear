source 'https://rubygems.org'

ruby '2.3.1'
gem 'rails', '5.0.0'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier'
end

gem 'jquery-rails'
gem 'bootstrap-sass'
gem 'slim-rails'

# To use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1'
gem 'chartkick', '~> 2.2'
gem 'groupdate'
gem 'pg'

group :test, :development do
  gem 'rspec-rails'
  gem 'test-unit'
end

group :test do
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
