source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'
# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb.
gem 'bootsnap', '>= 1.4.2', require: false
# Flexible authentication solution for Rails with Warden.
gem 'devise', '~> 4.7', '>= 4.7.1'
# Bootstrap views for Devise with I18n support.
gem 'devise-bootstrap-views', '~> 1.1'
# Slugging and permalink plugins for Active Record.
gem 'friendly_id', '~> 5.3'
# HTML Abstraction Markup Language.
gem "haml-rails", "~> 2.0"
## High-level wrapper for processing images for the web with ImageMagick or libvips.
## gem 'image_processing', '~> 1.10', '>= 1.10.3'
# Build JSON APIs with ease.
gem 'jbuilder', '~> 2.7'
# Handle multiple models in a single form.
gem 'nested_form', '~> 0.3.2'
# Agnostic pagination in plain ruby
gem 'pagy', '~> 3.8', '>= 3.8.2'
# Use Puma as the app server.
gem 'puma', '~> 4.1'
# Object oriented authorization for Rails applications
gem 'pundit', '~> 2.1'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'.
gem 'rails', '~> 6.1.4.1', '>= 6.1.4.1'
# Simple Form a flexible way to create your forms.
gem 'simple_form', '~> 5.0', '>= 5.0.2'
# Use SCSS for stylesheets.
gem 'sass-rails', '>= 6'
# Turbolinks makes navigating your web application faster.
gem 'turbolinks', '~> 5'
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem.
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
# Transpile app-like JavaScript.
gem 'webpacker', '~> 4.0'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console.
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  # A testing framework for Rails 5+.
  gem 'rspec-core'
  gem 'rspec-expectations'
  gem 'rspec-mocks'
  gem 'rspec-rails'
  gem 'rspec-support'
  # Extracting `assigns` and `assert_template` from ActionDispatch.
  gem 'rails-controller-testing', '~> 1.0', '>= 1.0.5'
end

group :production do
  # Ruby interface to the  PostgreSQL RDBMS
  gem 'pg', '~> 1.2', '>= 1.2.3'
end

group :development do
  # Detects security vulnerabilities via static analysis.
  gem 'brakeman', '~> 4.8', '>= 4.8.2'
  # help to kill N+1 queries and unused eager loading.
  gem 'bullet', '~> 6.1'
  # Patch-level verification for Bundled apps.
  gem 'bundler-audit', '~> 0.7.0.1'
  # Guard and LiveReload automatically reloads your browser when 'view' files are modified.
  gem 'guard'
  gem 'guard-livereload', '~> 2.5', require: false
  # Guard::RSpec allows to automatically & intelligently launch specs when files are modified.
  gem 'guard-rspec', require: false
  # Listens to file modifications and notifies you about the changes.
  gem 'listen', '>= 3.0.5', '< 3.2'
  # A simple, fast Mysql library for Ruby, binding to libmysql.
  gem 'mysql2', '~> 0.5.3'
  # Automatic Ruby code style checking tool.
  gem 'rubocop', '~> 1.22.0', require: false
  gem 'rubocop-performance', require: false
  # Spring speeds up development by keeping your application running in the background.
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
end

group :test do
  # An integration testing tool for rack based web applications.
  gem 'capybara', '>= 2.15'
  # Ensureing a clean slate of databases for testing.
  gem 'database_cleaner'
  # Integration between factory_bot and rails
  gem 'factory_bot_rails'
  # Easily generate fake data: names, addresses, phone numbers, etc.
  gem 'faker', '~> 2.11'
  # A tool for writing automated tests of websites.
  gem 'selenium-webdriver'
  # Simple One-Liner Tests for Rails
  gem 'shoulda-matchers', '~> 4.3'
  # Use sqlite3 as the database for testing.
  gem 'sqlite3', '~> 1.4'
  # Easy installation and use of web drivers to run system tests with browsers.
  gem 'webdrivers'
end
