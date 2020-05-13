# Inspire by the article: https://medium.com/@josisusan/rails-template-9d804bf47fab
# And by : https://github.com/infinum/default_rails_template/blob/master/template.rb
# And by : https://github.com/dao42/rails-template/blob/master/composer.rb
# And by : https://github.com/excid3/jumpstart/blob/master/template.rb

# Dir Source for the 3 basic Files
def source_paths
  [__dir__]
end

# Grabbing the big files
remove_file 'Gemfile'
copy_file 'Gemfile', 'Gemfile'
remove_file '.gitignore'
copy_file '.gitignore', '.gitignore'
copy_file '.rubocop.yml', '.rubocop.yml'

SECRETS_RB_FILE = <<-HEREDOC.strip_heredoc
  ENV['DATABASE_USERNAME'] = ''
  ENV['DATABASE_PASSWORD'] = ''
  ENV['SOCKET'] = '/var/run/mysqld/mysqld.sock'
HEREDOC
create_file 'config/secrets.rb', SECRETS_RB_FILE, force: true

# My Database YML FILE
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

def add_javascript
  run 'yarn add expose-loader jquery popper.js bootstrap data-confirm-modal local-time'

  content = <<-JS
  const webpack = require('webpack')
  environment.plugins.append('Provide', new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    Rails: '@rails/ujs'
  }))
  JS
  insert_into_file 'config/webpack/environment.js', content + "\n", before: 'module.exports = environment'
end
after_bundle do
  # Applying styling frameworks Jquery/bootstrap
  add_javascript

  # Initial config of RSpec
  generate 'rspec:install'

  # Fix default rubocop errors
  run 'bundle exec rubocop -a'

  # Commit everything to git
  git :init
  git add: '.'
  git commit: %Q(-m "Initial commit")

  say
  say 'Applicacion creada con éxito!', :blue
end
