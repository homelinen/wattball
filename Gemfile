source 'https://rubygems.org'

gem 'rails', '~> 3.2.11'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

group :development do
  gem 'sqlite3'
end

gem 'therubyracer', '~> 0.10.2'
gem 'devise', '~> 2.2.3'

# Table generationble_for_collection", "
gem "table_for_collection", "~> 1.0.6"
gem "calendar_helper", "~> 0.2.5"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

group :production do
      gem "mysql2", "~> 0.3.11"
      gem "thin", "~> 1.5.0"
      gem "mail"
end
# Round-Robin scheduler
gem 'rrschedule'

gem "rspec-rails", "~> 2.0", :group => [:test, :development]

group :test do
  gem 'capybara', '~> 2.0.2'
  gem 'shoulda', '~> 3.3.2'

  gem 'mocha'

  gem 'guard', '~> 1.6.2'
  gem 'guard-rspec', '~> 2.4.0'

  # Notifications for Growl
  # Possibly will cause dep. problems
  gem 'rb-inotify', :require => false
  gem 'rb-fsevent', :require => false
  gem 'rb-fchange', :require => false
  gem 'libnotify', '~> 0.8.0', :require => false
end

#Authentication
gem "cancan", '~> 1.6.9'
# File uploads
gem "paperclip", "~> 3.0"

gem 'jquery-rails', '~> 2.2.1'
gem "jquery-ui-rails", "~> 4.0.2"

gem "breadcrumbs_on_rails", "~> 2.3.0"

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'

# Just to make a backup of the data
gem "yaml_db"

group :deploy do
  gem "capistrano"
  gem "rvm-capistrano"
  gem "capistrano-rbenv"
end
# Dummy data generation

gem "faker", "~> 1.1.2"
gem "factory_girl_rails", "~> 4.0"

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
