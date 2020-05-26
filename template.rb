# Inspire by the article: https://medium.com/@josisusan/rails-template-9d804bf47fab
# And by : https://github.com/infinum/default_rails_template/blob/master/template.rb
# And by : https://github.com/dao42/rails-template/blob/master/composer.rb
# And by : https://github.com/excid3/jumpstart/blob/master/template.rb

# Dir Source for the 3 basic Files
def source_paths
  [__dir__]
end

# Start with my own Gemfile
remove_file 'Gemfile'
copy_file 'Gemfile', 'Gemfile'

SECRETS_RB_FILE = <<-HEREDOC.strip_heredoc
  ENV['DATABASE_USERNAME'] = ''
  ENV['DATABASE_PASSWORD'] = ''
  ENV['SOCKET'] = '/var/run/mysqld/mysqld.sock'
HEREDOC
create_file 'config/secrets.rb', SECRETS_RB_FILE, force: true

# The Database YML FILE
DB_CONFIG = <<-HEREDOC.strip_heredoc
  development:
    adapter: mysql2
    encoding: utf8
    pool: 5
    host: localhost
    database: #{app_name}_development
    username: <%= ENV['DATABASE_USERNAME'] %> 
    password: <%= ENV['DATABASE_PASSWORD'] %>
    socket: <%= ENV['SOCKET'] %>
  test:
    adapter: sqlite3
    pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
    timeout: 5000
    database: db/#{app_name}_test.sqlite3  
HEREDOC
create_file 'config/database.yml', DB_CONFIG, force: true

BOOTSTRAP_CONFIG = <<-HEREDOC.strip_heredoc
    @import '~bootstrap/scss/bootstrap';
HEREDOC
create_file 'app/javascript/packs/stylesheets/application.scss', BOOTSTRAP_CONFIG, force: true

# Adding Localhost custom environment variables
def localhost_secrets
  content = <<-ENV_CONFIG
  
  # Load the app's custom environment variables here, so that they are loaded before environments/*.rb
  app_environment_variables = File.join(Rails.root, 'config', 'secrets.rb')
  load(app_environment_variables) if File.exist?(app_environment_variables)
  ENV_CONFIG
  insert_into_file 'config/environment.rb', content + "\n", after: "require_relative 'application'"
end

# JQuery-Bootstrap-Popper method
def add_javascript
  run 'yarn add expose-loader jquery popper.js bootstrap data-confirm-modal local-time'

  content = <<-JS
  const webpack = require('webpack')
  environment.plugins.append('Provide', new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    Popper: ["popper.js", "default"],
    Rails: '@rails/ujs'
  }))
  JS
  insert_into_file 'config/webpack/environment.js', content + "\n", before: 'module.exports = environment'
end

def config_bootstrap_jquery
  content = <<-BTSP
    import 'bootstrap';
    import './stylesheets/application.scss';
    global.$ = jQuery;
  BTSP
  insert_into_file 'app/javascript/packs/application.js', content + "\n", after: 'require("channels")'
end

# Custom files
def copy_templates
  remove_file 'app/assets/stylesheets/application.css'
  remove_file '.gitignore'
  copy_file '.gitignore', '.gitignore'
  copy_file '.rubocop.yml', '.rubocop.yml'
  directory 'app', force: true
end

after_bundle do
  # Custom local environment variables
  localhost_secrets

  # Applying styling frameworks Jquery/bootstrap
  add_javascript
  config_bootstrap_jquery

  # Adding all the custom files
  copy_templates

  # Initial config of RSpec
  generate 'rspec:install'
  # Config Guard
  run 'bundle exec guard init'

  # Fix default rubocop errors
  run 'bundle exec rubocop -a'

  # Commit everything to git
  git :init
  git add: '.'
  git commit: %Q(-m "Initial commit")

  say 'Applicacion creada con éxito!', :green
end
