remove_file "Gemfile"
create_file "Gemfile" do
<<-RUBY
source "http://rubygems.org"


ruby '2.6.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false
# Flexible authentication solution for Rails with Warden
gem 'devise', '~> 4.7', '>= 4.7.1'
# HTML Abstraction Markup Language
gem 'haml', '~> 5.1', '>= 5.1.2'
# Build JSON APIs with ease.
gem 'jbuilder', '~> 2.7'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.2', '>= 6.0.2.2'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Turbolinks makes navigating your web application faster.
gem 'turbolinks', '~> 5'
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
# Transpile app-like JavaScript.
gem 'webpacker', '~> 4.0'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  # Guard and LiveReload automatically reloads your browser when 'view' files are modified.
  gem 'guard'
  gem 'guard-livereload', '~> 2.5', require: false
  # Listens to file modifications and notifies you about the changes.
  gem 'listen', '>= 3.0.5', '< 3.2'
  # A simple, fast Mysql library for Ruby, binding to libmysql.
  gem 'mysql2', '~> 0.5.3'
  # Automatic Ruby code style checking tool.
  gem 'rubocop', '~> 0.82.0', require: false
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
  # A tool for writing automated tests of websites.
  gem 'selenium-webdriver'
  # A testing framework for Rails 5+.
  gem 'rspec-rails', '~> 4.0'
  # Use sqlite3 as the database for testing.
  gem 'sqlite3', '~> 1.4'
  # Easy installation and use of web drivers to run system tests with browsers.
  gem 'webdrivers'
end
RUBY
end