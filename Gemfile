source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby File.read(File.expand_path('.ruby-version', __dir__)).chomp

# Core

gem 'rails', '~> 6.0.3.2'
gem 'pg'
gem 'puma'

# API

gem 'graphql'
gem 'graphql-errors'

# Assets

gem 'sass-rails'
gem 'uglifier'

# Security

gem 'bcrypt'
gem 'devise'
gem 'devise-jwt'
gem 'dotenv-rails'
gem 'rack-cors'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  gem 'awesome_print'
  gem 'factory_bot_rails'
  gem 'pry'
  gem 'rspec-rails'
end

group :test do
  gem 'database_cleaner', '~> 1.6'
  gem 'faker', '~> 1.8'
  gem 'shoulda-matchers', '4.0.0.rc1'
  gem 'rails-controller-testing'
  gem 'simplecov', require: false
end

group :development do
  gem 'graphiql-rails'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
