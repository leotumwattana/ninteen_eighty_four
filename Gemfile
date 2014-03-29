source 'https://rubygems.org'

gem 'rails', '4.0.3'
gem 'activesupport', require: 'active_support'
gem 'uglifier'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'foundation-rails'
gem 'slim'
gem 'bson_ext'
gem 'mongoid', github: 'mongoid/mongoid'
gem 'bcrypt'
gem 'sidekiq'
gem 'sinatra', require: false

group :development, :test do
  # gem "better_errors"
  gem "foreman"
  gem "binding_of_caller"
  gem "letter_opener"
  gem "pry"
  gem 'rspec-rails'
  gem 'rb-fsevent', :require => false if RUBY_PLATFORM =~ /darwin/i
  gem 'guard-rspec'
  gem 'guard-livereload'
  gem 'factory_girl_rails'
end

group :test do
  gem 'faker'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'selenium-webdriver'
end