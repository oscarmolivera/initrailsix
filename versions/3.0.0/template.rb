# COMMAND: rails new blog -m ~/webapps/initrailsix/versions/3.0.0/template.rb 
# Inspire by the article: https://medium.com/@josisusan/rails-template-9d804bf47fab
# And by : https://github.com/infinum/default_rails_template/blob/master/template.rb
# And by : https://github.com/dao42/rails-template/blob/master/composer.rb
# And by : https://github.com/excid3/jumpstart/blob/master/template.rb

require 'io/console'

# Dir Source for the 3 basic Files
def source_paths
  [__dir__]
end

# Start with my own Gemfile
remove_file 'Gemfile'
copy_file 'Gemfile', 'Gemfile'
db_user = IO::console.getpass '** Database AdminUser Name? : '
db_password = IO::console.getpass ' ** Database AdminUser Password? : '
SECRETS_RB_FILE = <<-HEREDOC.strip_heredoc
  ENV['DATABASE_USERNAME'] = "#{db_user}"
  ENV['DATABASE_PASSWORD'] = "#{db_password}"
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
    adapter: mysql2
    encoding: utf8
    pool: 5
    host: localhost
    database: #{app_name}_test
    username: <%= ENV['DATABASE_USERNAME'] %> 
    password: <%= ENV['DATABASE_PASSWORD'] %>
    socket: <%= ENV['SOCKET'] %>
  
HEREDOC
create_file 'config/database.yml', DB_CONFIG, force: true

BOOTSTRAP_CONFIG = <<-HEREDOC.strip_heredoc
    @import '~bootstrap/scss/bootstrap';
HEREDOC
create_file 'app/javascript/packs/stylesheets/application.scss', BOOTSTRAP_CONFIG, force: true

# Adding Localhost custom environment variables
def localhost_secrets
  content = <<-ENV_CONFIG
  
  # Load the Rails application.
  require_relative "application"

  # Load the app's custom environment variables here, so that they are loaded before environments/*.rb
  app_environment_variables = File.join(Rails.root, 'config', 'secrets.rb')
  load(app_environment_variables) if File.exist?(app_environment_variables)

  # Initialize the Rails application.
  Rails.application.initialize!
  ENV_CONFIG
  create_file 'config/environment.rb', content, force: true
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
  content = <<-APPJS
    require("@rails/ujs").start()
    require("turbolinks").start()
    require("@rails/activestorage").start()
    require("channels")    
    
    import 'bootstrap';
    import './stylesheets/application.scss';
    global.$ = jQuery;
  APPJS
  create_file 'app/javascript/packs/application.js', content, force: true
end

# Custom files
def copy_templates
  remove_file 'app/assets/stylesheets/application.css'
  remove_file '.gitignore'
  copy_file '.gitignore', '.gitignore'
  copy_file '.rubocop.yml', '.rubocop.yml'
  copy_file 'Procfile', 'Procfile'
  directory 'app', force: true
end

after_bundle do
  # Custom local environment variables
  remove_file 'config/environment.rb'
  localhost_secrets

  # Applying styling frameworks Jquery/bootstrap
  add_javascript
  config_bootstrap_jquery

  # Adding all the custom files
  copy_templates

  # Prepare DEVISE Gem
  generate 'devise:install'
  generate 'devise User'
  generate 'devise:views:bootstrap_templates'

  # Initial config of RSpec
  generate 'rspec:install'

  # Config Guard
  run 'bundle exec guard init'

  # ERB_2_HAML Files
  rails_command 'haml:erb2haml'
  
  # SimpleForm install
  rails_command 'generate simple_form:install'

  # Migrate
  rails_command 'db:create'
  rails_command 'db:migrate'


  # Commit everything to git
  git :init
  git add: '.'
  git commit: %Q(-m "Initial commit")

  run 'clear'
  say 'Houston: You are good to go!', :green
  say "Get Inside with: "
  say "$ cd #{app_name}", :yellow
end
